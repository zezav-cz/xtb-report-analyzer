module Common
  module Data
    CLOSED_POSITIONS = :closed_positions
    OPEN_POSITIONS = :open_positions
    PENDING_ORDERS = :pending_orders
    CASH_OPERATIONS = :cash_operations
    BALANCE_OPERATIONS = :balance_operations

    DESCRIPTIONS = {
      CLOSED_POSITIONS => "Closed positions",
      OPEN_POSITIONS => "Open positions",
      PENDING_ORDERS => "Pending orders",
      CASH_OPERATIONS => "Cash operations",
      BALANCE_OPERATIONS => "Balance operations",
    }

    TABLE_NAMES = {
      CLOSED_POSITIONS => "closed_positions",
      OPEN_POSITIONS => "open_positions",
      PENDING_ORDERS => "pending_orders",
      CASH_OPERATIONS => "cash_operations",
      BALANCE_OPERATIONS => "balance_operations",
    }

    ID_NAMES = {
      OPEN_POSITIONS => "position",
      CLOSED_POSITIONS => "position",
      PENDING_ORDERS => "id2",
      CASH_OPERATIONS => "id2",
      BALANCE_OPERATIONS => "id2",
    }

    # Returns the ID name for a given table.
    # @param table [Symbol] The table type.
    # @return [String] The ID name for the table.
    # @raise [ArgumentError] If the table type is invalid.
    def self.get_id_name(table)
      raise ArgumentError, "Invalid table" unless ID_NAMES.key?(table)
      ID_NAMES[table]
    end

    # Returns the table name for a given table.
    # @param table [Symbol] The table type.
    # @return [String] The table name.
    # @raise [ArgumentError] If the table type is invalid.
    def self.get_table_name(table)
      raise ArgumentError, "Invalid table" unless TABLE_NAMES.key?(table)
      TABLE_NAMES[table]
    end

    # Returns the description for a given table.
    # @param table [Symbol] The table type.
    # @return [String] The description of the table.
    # @raise [ArgumentError] If the table type is invalid.
    def self.get_description(table)
      raise ArgumentError, "Invalid table" unless DESCRIPTIONS.key?(table)
      DESCRIPTIONS[table]
    end

    # Returns an array of all data types.
    # @return [Array<Symbol>] An array of all data types.
    def self.all_dtypes
      [CLOSED_POSITIONS, OPEN_POSITIONS, PENDING_ORDERS, CASH_OPERATIONS, BALANCE_OPERATIONS]
    end

    # Checks if a given data type is valid.
    # @param dtype [Symbol] The data type.
    # @return [Boolean] True if the data type is valid, false otherwise.
    def self.valid?(dtype)
      all_dtypes.include?(dtype)
    end
  end
end
