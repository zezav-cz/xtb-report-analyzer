require "active_record"
require "rake"
require_relative "config/environment"
require_relative "db/migration"

namespace :db do
  desc "Migrate the database (apply all migrations)"
  task :up do
    CreateBalanceOperations.migrate(:up)
    CreateCashOperations.migrate(:up)
    CreateClosedPositions.migrate(:up)
    CreateOpenPositions.migrate(:up)
    CreatePendingOrders.migrate(:up)
    puts "Migrations applied successfully."
  end

  desc "Undo migrations"
  task :down do
    CreateBalanceOperations.migrate(:down)
    CreateCashOperations.migrate(:down)
    CreateClosedPositions.migrate(:down)
    CreateOpenPositions.migrate(:down)
    CreatePendingOrders.migrate(:down)
    puts "Rolled migrations back successfully."
  end
end
