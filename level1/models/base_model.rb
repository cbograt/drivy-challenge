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

  def as_json(attributes)
    attributes.each_with_object({}) do |attribute, res|
      res[attribute] = send(attribute.to_sym)
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
