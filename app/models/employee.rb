class Employee < ApplicationRecord
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|

      employee_hash = row.to_hash
      employee = Employee.where(id: employee_hash["id"])

      if employee.count == 1
        employee.first.update_attributes(employee_hash)
      else
        Employee.create!(employee_hash)
      end
    end
  end
end
