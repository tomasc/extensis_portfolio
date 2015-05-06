class ExtensisAssetQueryTerm

  # field_name: String
  # operator: queryOperator
  # values: string

  def initialize(field_name, operator, values)
    @field_name = field_name
    @operator = operator
    @values = values
  end

  def to_hash
    {
      field_name: @field_name,
      operator: @operator,
      values: @values
    }
  end

end
