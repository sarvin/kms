class Address < ActiveRecord::Base
  belongs_to :state
  belongs_to :addressable, polymorphic: true

  def columns_generated_by_user_populated?
    attributes_hash = attributes

    self.class.columns_generated_by_user.each do |column|
      return true if attributes_hash[column]
    end

    false
  end

  def self.columns_generated_by_user
    important_fields = []
    columns_generated_programmatically = {
      id: true,
      addressable_id: true,
      addressable_type: true,
      created_at: true,
      updated_at: true
    }

    self.column_names.each do |column|
      next if columns_generated_programmatically.has_key?(column.to_sym)

      important_fields.push(column)
    end

    return important_fields
  end
end
