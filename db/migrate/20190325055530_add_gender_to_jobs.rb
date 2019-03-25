class AddGenderToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :men, :integer
    add_column :jobs, :women, :integer
    add_column :jobs, :ratio, :decimal, :precision => 9, :scale => 6
  end
end
