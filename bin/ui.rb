#!/usr/bin/env ruby

require_relative "../lib/ui"
ui = UI.new(ARGV.length.zero? ? nil : ARGV[0])
ui.run
