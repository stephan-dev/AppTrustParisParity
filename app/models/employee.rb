class Employee < ApplicationRecord
  # Identical row can't be persisted several times in several imports
  validates :job_level, uniqueness: { scope: [:year, :collectivity, :contract_type, :job_title, :job_specialty] }, :message => "doublon"


  def self.import(file)
    # add semi-colon ; as accepted csv separator
    CSV.foreach(file.path, :col_sep => ?;).with_index do |row, i|
      # skips headers because they're in french and they have accents
      next if i == 0

      Employee.create!(year: row[0], collectivity: row[1], contract_type: row[2], job_title: row[3], job_level: row[4], job_specialty: row[5])

    end
  end
end
