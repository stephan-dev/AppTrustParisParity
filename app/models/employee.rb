class Employee < ApplicationRecord
  # Identical rows can't be persisted
  validates :job_level, uniqueness: { scope: [:year, :collectivity, :contract_type, :job_title, :job_specialty] }


  def self.import(file)
    # add semi-colon ; as accepted csv separator
    CSV.foreach(file.path, :col_sep => ?;).with_index do |row, i|
      # skips headers because they're in french and they have accents
      next if i == 0

      employee = Employee.new(year: row[0], collectivity: row[1], contract_type: row[2], job_title: row[3], job_level: row[4], job_specialty: row[5])

      begin
        employee.save!
      rescue # if validation fails
        # the newest identical row is the most relevant
        Employee.where(year: row[0], collectivity: row[1], contract_type: row[2], job_title: row[3], job_level: row[4], job_specialty: row[5]).update(year: row[0], collectivity: row[1], contract_type: row[2], job_title: row[3], job_level: row[4], job_specialty: row[5], updated_at: Time.now)
      end

    end
  end
end
