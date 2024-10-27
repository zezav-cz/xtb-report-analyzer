require "json"
require "roo"
require_relative "../common/data"

# @module Convertors
module Convertors
  # @class XLSXToJSON
  # @desc Class that converts an XLSX file to JSON format
  class XLSXToJSON
    # hash of headers for each sheet
    @@TABLE_HEADERS = {
      Common::Data::CLOSED_POSITIONS => {
        :position => "Position", :symbol => "Symbol", :type => "Type", :volume => "Volume", :open_time => "Open time",
        :open_price => "Open price", :close_time => "Close time", :close_price => "Close price",
        :open_origin => "Open origin", :close_origin => "Close origin", :purchuse_value => "Purchase value",
        :sale_value => "Sale value", :sl => "SL", :tp => "TP", :margin => "Margin", :commission => "Commission",
        :swap => "Swap", :rollover => "Rollover", :gross_pl_comment => "Gross P/L", :comment => "Comment",
      },
      Common::Data::OPEN_POSITIONS => {
        :position => "Position", :symbol => "Symbol", :type => "Type", :volume => "Volume", :open_time => "Open time",
        :open_price => "Open price", :market_price => "Market price", :purchase_value => "Purchase value",
        :sl => "SL", :tp => "TP", :margin => "Margin", :commission => "Commission", :swap => "Swap",
        :rollover => "Rollover", :gross_pl => "Gross P/L", :comment => "Comment",
      },
      Common::Data::PENDING_ORDERS => {
        :id => "ID", :symbol => "Symbol", :purchase_value => "Purchase value", :nominal_value => "Nominal Value",
        :price => "Price", :margin => "Margin", :type => "Type", :order => "Order", :side => "side", :sl => "SL",
        :tp => "TP", :open_time => "Open time",
      },
      Common::Data::CASH_OPERATIONS => {
        :id => "ID", :type => "Type", :time => "Time", :comment => "Comment", :symbol => "Symbol", :amount => "Amount",
      },
      Common::Data::BALANCE_OPERATIONS => {
        :id => "ID", :type => "Type", :time => "Time", :comment => "Comment", :amount => "Amount",
      },
    }
    # hash of sheet names
    @@SHEET_NAMES = {
      Common::Data::CLOSED_POSITIONS => "CLOSED POSITION HISTORY",
      Common::Data::OPEN_POSITIONS => "OPEN POSITION 20102024",
      Common::Data::PENDING_ORDERS => "PENDING ORDERS HISTORY ",
      Common::Data::CASH_OPERATIONS => "CASH OPERATION HISTORY",
      Common::Data::BALANCE_OPERATIONS => "BALANCE OPERATION HISTORY MT",
    }

    # Initializes the XLSXToJSON object with the given file path.
    # @param file_path [String] Path to the XLSX file
    def initialize(file_path)
      @file_path = file_path
    end

    # Returns the parsed data as a hash.
    # @return [Hash] The JSON data
    def get_data
      parse_workbook if @data.nil?
      @data
    end

    # Returns the parsed data as a JSON string.
    # @return [String] The JSON data as a string
    def get_json
      get_data.to_json
    end

    private

    def parse_sheet(sheet)
      raise ArgumentError, "Unsupported sheet" unless Common::Data::valid?(sheet)
      @sheet.sheet(@@SHEET_NAMES[sheet]).parse(**@@TABLE_HEADERS[sheet]).reject { |r| r[:position] == "Total" }
    end

    def parse_workbook()
      @sheet ||= Roo::Spreadsheet.open(@file_path)
      raise ArgumentError, "Unsupported workbook (expected sheets #{@@SHEET_NAMES.values}" unless @sheet.sheets.sort == @@SHEET_NAMES.values.sort
      @data ||= @@SHEET_NAMES.keys.map { |sheet| [sheet, parse_sheet(sheet)] }.to_h
      transform_data
    end

    def transform_data()
      # in all values in @data, rename key type to transactino_type
      @data.each do |sheet, records|
        records.each do |record|
          record[:transaction_type] = record.delete(:type)
        end
      end

      @data[Common::Data::OPEN_POSITIONS].each { |x| x[:id] = x.delete(:position) }
      @data[Common::Data::CLOSED_POSITIONS].each { |x| x[:id] = x.delete(:position) }
    end
  end
end
