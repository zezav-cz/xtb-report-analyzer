require "tty-box"
require "tty-reader"
require "tty-screen"
require "tty-table"
require "pastel"
require "tty-pie"

module UUI
  class Menu
    SLEEP_TIME = 5

    # Initializes the Menu object.
    # @param name [String] The name of the application.
    # @param version [String] The version of the application.
    # @param commands [Hash] A hash of commands.
    # @param db_path [String] Path to the database file.
    def initialize(name, version, commands, db_path)
      @internet_connection = false
      @mutex = Mutex.new
      @monitoring_runing = false
      @monitoring_stop = false
      @name = name
      @version = version
      @commands = commands
      @db_path = db_path
      start_monitoring()
    end

    # Generates the menu.
    # @return [String] The generated menu.
    def generate()
      left_lines = info.lines
      center_lines = help.lines
      right_lines = status.lines

      menu_output = left_lines.zip(center_lines, right_lines).map do |left, center, right|
        "#{left.chomp}#{center.chomp}#{right.chomp}"
      end

      menu_output.join("\n")
    end

    private

    def render_simple_table(table)
      table.render(:basic, padding: [0, 1], multiline: true) do |renderer|
        renderer.border = nil
        renderer.alignments = [:left]
      end
    end

    def info
      TTY::Box.frame(
        width: TTY::Screen.width / 4,
        height: 5,
        align: :center,
        padding: [1, 1],
        title: { top_left: " Info " },
      ) do
        render_simple_table(TTY::Table.new { |t| t << ["Name", @name]; t << ["Version", @version] })
      end
    end

    def help
      commands_table = TTY::Table.new do |t|
        @commands.map { |k, v| [k.to_s, v] }.each_slice(3).to_a.each do |a|
          comosed_array = []
          (0..a.length - 2).each { |i| comosed_array += a[i] + ["|"] }
          comosed_array += a.last
          t << comosed_array
        end
      end
      TTY::Box.frame(
        width: TTY::Screen.width / 2,
        height: 5,
        align: :center,
        padding: [1, 1],
        title: { top_left: " Commands " },
      ) { render_simple_table(commands_table) }
    end

    def status
      TTY::Box.frame(
        width: TTY::Screen.width / 4,
        height: 5,
        align: :center,
        padding: [1, 1],
        title: { top_left: " Status " },
      ) do
        render_simple_table(TTY::Table.new { |t| t << ["DB", @db_path]; t << ["Internet", @internet_connection ? "Connected" : "Disconnected"] })
      end
    end

    def start_monitoring()
      return if @monitoring_runing
      @monitoring_runing = true
      @internet_connection = internet_connection?
      Thread.new do
        while !@monitoring_stop
          status = internet_connection?
          @mutex.synchronize { @internet_connection = status }
          sleep(SLEEP_TIME)
        end
      end
    end

    def stop_monitoring()
      @monitoring_stop = true
      @monitoring_runing = false
    end

    def internet_connection?
      begin
        true if system("ping -c 1 google.com > /dev/null 2>&1")
      rescue
        false
      end
    end
  end
end
