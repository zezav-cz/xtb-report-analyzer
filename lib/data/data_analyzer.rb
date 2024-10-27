require_relative "../models/open_position"
require_relative "../models/closed_position"
require_relative "../models/pending_order"

# @class DataAnalyer
# @desc Class that analyzes data from the database
class DataAnalyer
  # Returns all closed positions with their attributes.
  # @return [Array<Hash>] An array of hashes representing closed positions.
  def closed_positions()
    attributes = Models::ClosedPosition.new.attributes.keys
    data = []
    Models::ClosedPosition.all.each do |r|
      data << attributes.map { |a| { a.to_sym => r.send(a) } }.reduce(:merge)
    end
    data
  end

  # Returns all pending orders with their attributes.
  # @return [Array<Hash>] An array of hashes representing pending orders.
  def pending_orders()
    attributes = Models::PendingOrder.new.attributes.keys
    data = []
    Models::PendingOrder.all.each do |r|
      data << attributes.map { |a| { a.to_sym => r.send(a) } }.reduce(:merge)
    end
    data
  end

  # Returns the current state of open positions.
  # @return [Array<Hash>] An array of hashes representing the current state of open positions.
  def curent_state()
    Models::OpenPosition
      .select("symbol, sum(purchuase_value) as total")
      .group(:symbol)
      .map { |r| { symbol: r.symbol, total: r.total } }
  end

  # Returns the closed positions with their total and percentage values.
  # @return [Array<Hash>] An array of hashes representing closed positions with total and percentage values.
  def closed()
    Models::ClosedPosition
      .select("symbol, sum(purchuase_value) as pur_sum, sum(sell_value) as sell_sum")
      .group(:symbol)
      .map { |r| { symbol: r.symbol, total: r.sell_sum - r.pur_sum, percent: (r.sell_sum - r.pur_sum) / r.pur_sum * 100 } }
  end

  # Returns all open positions with their attributes.
  # @return [Array<Hash>] An array of hashes representing open positions.
  def open_positions()
    attributes = Models::OpenPosition.new.attributes.keys
    data = []
    Models::OpenPosition.all.each do |r|
      data << attributes.map { |a| { a.to_sym => r.send(a) } }.reduce(:merge)
    end
    data
  end

  # Returns the ETF positions with their total volume and purchase value.
  # @return [Array<Hash>] An array of hashes representing ETF positions with total volume and purchase value.
  def etfs()
    Models::OpenPosition
      .select("symbol, sum(volume) as total_volume, sum(purchase_value) as total_purchase_value")
      .group(:symbol)
      .map { |r| { symbol: r.symbol, total_volume: r.total_volume, total_purchase_value: r.total_purchase_value } }.to_a
  end
end
