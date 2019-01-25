class AddColumnToEventTable < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :min_ticket_price, :int
    add_column :events, :max_ticket_price, :int
  end
end
