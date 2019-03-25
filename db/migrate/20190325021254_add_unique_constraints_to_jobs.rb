class AddUniqueConstraintsToJobs < ActiveRecord::Migration[5.2]
  def change
    # uniqueness with race condition, but couldn't add longer index title
    add_index :jobs, [:job_specialty, :job_level , :job_title], unique: true
  end
end
