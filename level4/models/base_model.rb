require 'json'

class BaseModel
  class << self
    def build_from_hash(hash = {})
      new(**hash)
    end

    def find(id)
      collection_key = name.downcase.to_sym
      Database.find(collection_key, id)
    end
  end

  def as_json(attributes = nil)
    (attributes || default_json_attributes).each_with_object({}) do |attribute, res|
      value = send(attribute.to_sym)
      res[attribute] = if value.is_a?(BaseModel)
                         value.as_json
                       elsif value.is_a?(Array)
                         value.map(&:as_json)
                       else
                         value
                       end
    end
  end

  def to_json(attributes = nil)
    as_json(attributes || default_json_attributes).to_json
  end

  protected

  def default_json_attributes
    [:id]
  end
end
