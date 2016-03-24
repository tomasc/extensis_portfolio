module ExtensisPortfolio
  class AssetQueryTerm
    # Creates a new instance of ExtensisPortfolio::AssetQueryTerm
    #
    # @param field_name [String] the field used for the query, e.g. `asset_id`
    # @param operator [String] query operator, e.g. `equalValue`
    # @param values [String] the value to query for, e.g. id of the asset
    def initialize(field_name, operator, values)
      @field_name = field_name
      @operator = operator
      @values = values
    end

    # Returns a Hash for use in a soap request
    #
    # @return [Hash]
    def to_hash
      {
        field_name: @field_name,
        operator: @operator,
        values: @values
      }
    end
  end
end
