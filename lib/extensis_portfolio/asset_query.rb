module ExtensisPortfolio
  class AssetQuery

    # Creates a new instance of ExtensisPortfolio::AssetQuery
    #
    # @param query_term [ExtensisPortfolio::AssetQueryTerm]
    def initialize(query_term)
      @query_term = query_term
    end

    # Returns a Hash for use in a soap request
    #
    # @return [Hash]
    def to_hash
      {
        query_term: @query_term.to_hash
      }
    end

  end
end
