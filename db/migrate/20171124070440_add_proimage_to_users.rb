class AddProimageToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :proimage, :string
  end
end
