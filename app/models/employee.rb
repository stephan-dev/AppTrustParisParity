class Employee < ApplicationRecord
  require 'csv'

  def self.import(file)
    CSV.foreach(file.path, :col_sep => ?;).with_index do |row, i|

      next if i == 0

      Employee.create!(year: row[0], collectivity: row[1], contract_type: row[2], job_title: row[3], job_level: row[4], job_specialty: row[5])

    end
  end
end
