class AddBanTillDateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :ban_till_date, :date, default: Date.today
  end
end
