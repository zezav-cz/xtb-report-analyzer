class CreateBalanceOperations < ActiveRecord::Migration[8.0]
  def change
    create_table :balance_operations do |t|
      t.string :transaction_type
      t.datetime :time
      t.string :comment
      t.decimal :amount, precision: 10, scale: 2
    end
  end
end

class CreateCashOperations < ActiveRecord::Migration[8.0]
  def change
    create_table :cash_operations do |t|
      t.string :transaction_type
      t.datetime :time
      t.string :comment
      t.string :symbol
      t.decimal :amount, precision: 10, scale: 2
    end
  end
end

class CreateClosedPositions < ActiveRecord::Migration[8.0]
  def change
    create_table :closed_positions do |t|
      t.string :symbol
      t.string :transaction_type
      t.float :volume
      t.datetime :open_time
      t.decimal :open_price, precision: 10, scale: 2
      t.datetime :close_time
      t.decimal :close_price, precision: 10, scale: 2
      t.string :open_origin
      t.string :close_origin
      t.decimal :purchase_value, precision: 15, scale: 2
      t.decimal :sale_value, precision: 15, scale: 2
      t.decimal :sl, precision: 10, scale: 2
      t.decimal :tp, precision: 10, scale: 2
      t.decimal :margin, precision: 10, scale: 2
      t.decimal :commission, precision: 10, scale: 2
      t.decimal :swap, precision: 10, scale: 2
      t.decimal :rollover, precision: 10, scale: 2
      t.string :gross_pl_comment
      t.string :comment
    end
  end
end

class CreateOpenPositions < ActiveRecord::Migration[8.0]
  def change
    create_table :open_positions do |t|
      t.string :symbol
      t.string :transaction_type
      t.float :volume
      t.datetime :open_time
      t.decimal :open_price, precision: 10, scale: 2
      t.decimal :market_price, precision: 10, scale: 2
      t.decimal :purchase_value, precision: 15, scale: 2
      t.decimal :sl, precision: 10, scale: 2
      t.decimal :tp, precision: 10, scale: 2
      t.decimal :margin, precision: 10, scale: 2
      t.decimal :commission, precision: 10, scale: 2
      t.decimal :swap, precision: 10, scale: 2
      t.decimal :rollover, precision: 10, scale: 2
      t.decimal :gross_pl, precision: 15, scale: 2
      t.string :comment
    end
  end
end

class CreatePendingOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :pending_orders do |t|
      t.string :symbol
      t.decimal :purchase_value, precision: 15, scale: 2
      t.decimal :nominal_value, precision: 15, scale: 2
      t.decimal :price, precision: 10, scale: 2
      t.decimal :margin, precision: 10, scale: 2
      t.string :transaction_type
      t.string :order
      t.string :side
      t.decimal :sl, precision: 10, scale: 2
      t.decimal :tp, precision: 10, scale: 2
      t.datetime :open_time
    end
  end
end
