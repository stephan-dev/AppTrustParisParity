class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.integer :year
      t.string :collectivity
      t.string :contract_type
      t.string :job_title
      t.string :job_level
      t.string :job_specialty
      t.timestamps
    end
  end
end
