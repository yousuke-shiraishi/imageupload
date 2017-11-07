class RemoveTitleFromBlogs < ActiveRecord::Migration[5.1]
  def change
    remove_column :blogs, :title, :string
  end
end
