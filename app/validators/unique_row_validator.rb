class UniqueRowValidator < ActiveModel::Validator
  def validate(record)
    if record.attributes_for_uniqueness.values.uniq.size == 1
      record.errors[:base] << 'Il ne peut pas pas y avoir deux entrées (lignes) identiques'
    end
  end
end