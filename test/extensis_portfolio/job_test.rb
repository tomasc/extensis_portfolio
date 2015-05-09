require 'minitest_helper'

module ExtensisPortfolio
  describe Job do

    let(:task1) { ExtensisPortfolio::Task.new("name", "foo", "catalog_id") }
    let(:task2) { ExtensisPortfolio::Task.new("name", "bar", "catalog_id") }

    subject { ExtensisPortfolio::Job.new("original", [task1]) }
    subject { ExtensisPortfolio::Job.new("original", [task1, task2]) }

    # ---------------------------------------------------------------------

    it 'returns a Hash' do
      subject.to_hash.must_be_kind_of Hash
    end

    it 'returns the correct Hash' do
      hash = {
        source_image: "original",
        tasks: [task1.to_hash, task2.to_hash]
      }

      subject.to_hash.must_equal hash
    end

  end
end
