require "tty-box"
require "tty-reader"
require "tty-screen"
require "tty-table"
require "pastel"
require "tty-pie"
require_relative "../data/data_analyzer"
require_relative "../ui/convertor"

module UUI
  # Class that represents the body of the UI.
  class Body
    COLORS = [
      :bright_yellow,
      :bright_green,
      :bright_blue,
      :bright_magenta,
      :bright_cyan,
    ]
    FILL = ["*", "x", "@", "+"]

    # Initializes the Body object.
    # @param commands [Hash] A hash of commands.
    def initialize(commands)
      @commands = commands
      @data_analyzer = DataAnalyer.new
      open_positions
      @align = :center
    end

    # Generates the UI body.
    # @return [String] The generated UI body.
    def generate()
      TTY::Box.frame(width: TTY::Screen.width, height: TTY::Screen.height - 7 - 2, align: @align, padding: [1, 10], title: { top_left: " Body " }) do
        @heading + "\n\n" + @connten
      end
    end

    def open_positions()
      data = @data_analyzer.open_positions
      columns = [:symbol, :volume, :open_price, :purchase_value, :id]
      cd = Convertor.to_table(data, columns)
      @connten = TTY::Table.new(header: columns, rows: cd).render(:ascii, alignment: [:center], resize: true, width: (TTY::Screen.width * 0.8).to_i)
      @heading = "OPEN POSITIONS"
      @align = :center
    end

    def close_position()
      data = @data_analyzer.closed_positions
      columns = [:symbol, :volume, :open_price, :close_price, :purchase_value, :id]
      cd = Convertor.to_table(data, columns)
      @connten = TTY::Table.new(header: columns, rows: cd).render(:ascii, alignment: [:center], resize: true, width: (TTY::Screen.width * 0.8).to_i)
      @heading = "CLOSED POSITIONS"
      @align = :center
    end

    def pending_orders()
      data = @data_analyzer.pending_orders
      columns = [:symbol, :purchase_value, :nominal_value, :price, :transaction_type, :id]
      cd = Convertor.to_table(data, columns)
      @connten = TTY::Table.new(header: columns, rows: cd).render(:ascii, alignment: [:center], resize: true, width: (TTY::Screen.width * 0.8).to_i)
      @heading = "PENDING OPRDERS"
      @align = :center
    end

    def help()
      help_menu = ""
      @commands.each do |key, command|
        help_menu += "'#{key}' => #{command}\n"
      end
      @connten = help_menu
      @heading = "HELP"
      @align = :center
    end

    def etfs()
      data = @data_analyzer.etfs
      p data
      columns = [:symbol, :total_volume, :total_purchase_value]
      # now i have array of hashes, i need to convert it to array of hashes with foloweing properties
      data2 = data.map { |r| { name: r[:symbol], value: r[:total_purchase_value] } }
      # create cross with COLORS and FILL and for each hash add color and fill
      data2.each_with_index do |d, i|
        d[:color] = COLORS[i % COLORS.length]
        d[:fill] = FILL[i % FILL.length]
      end
      p data2
      @connten = TTY::Pie.new(data: data2, radius: 10, legend: { left: 30, format: "%<label>s %<name>s %<currency>s€ (%<percent>.0f%%)" }).render
      @heading = "ETFS"
      @align = :left
    end
  end
end
