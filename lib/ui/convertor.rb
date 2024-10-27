module Convertor
  # Converts a table of hashes to an array of arrays based on the specified columns.
  # @param table [Array<Hash>] The table to convert.
  # @param columns [Array<Symbol>] The columns to include in the resulting table.
  # @return [Array<Array>] The converted table.
  # @raise [InvalidArgumentError] If the table is not an array.
  # @raise [InvalidArgumentError] If the columns are not an array.
  # @raise [InvalidArgumentError] If the columns array is empty.
  def self.to_table(table, columns)
    raise InvalidArgumentError, "Table must be an array" unless table.is_a?(Array)
    raise InvalidArgumentError, "Columns must be an array" unless columns.is_a?(Array)
    raise InvalidArgumentError, "Columns must not be empty" if columns.empty?

    res = []
    table.each do |object|
      res << columns.map { |column| object[column] }
    end
    return [["NaN"] * columns.length] if res.empty?
    res
  end
end
