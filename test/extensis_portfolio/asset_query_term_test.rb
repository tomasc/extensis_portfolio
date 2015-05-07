require 'minitest_helper'

module ExtensisPortfolio
  describe AssetQueryTerm do

    let(:field_name) { "asset_id" }
    let(:operator) { "equalValue" }
    let(:values) { "2021" }

    subject { ExtensisPortfolio::AssetQueryTerm.new(field_name, operator, values) }

    # ---------------------------------------------------------------------

    it 'returns a Hash' do
      subject.to_hash.must_be_kind_of Hash
    end

    it 'returns the correct Hash' do
      hash = {
        field_name: field_name,
        operator: operator,
        values: values
      }

      subject.to_hash.must_equal hash
    end

  end
end
