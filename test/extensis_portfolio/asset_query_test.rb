require 'minitest_helper'

module ExtensisPortfolio
  describe AssetQuery do

    let(:query_term) { ExtensisPortfolio::AssetQueryTerm.new("field_name", "operator", "values") }

    subject { ExtensisPortfolio::AssetQuery.new(query_term) }

    # ---------------------------------------------------------------------

    it 'returns a Hash' do
      subject.to_hash.must_be_kind_of Hash
    end

    it 'returns the correct Hash' do
      hash = {
        query_term: query_term.to_hash
      }

      subject.to_hash.must_equal hash
    end

  end
end
