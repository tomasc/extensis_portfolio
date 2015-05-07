require 'minitest_helper'

module ExtensisPortfolio
  describe AssetDownloader do

    let(:server) { "http://demo.extensis.com:8090" }
    let(:username) { "***REMOVED***" }
    let(:password) { "***REMOVED***" }
    let(:connection) { ExtensisPortfolio::Connection.new(server, username, password) }
    let(:asset_id) { "2018" }
    let(:catalog_id) { "***REMOVED***" }

    subject { ExtensisPortfolio::AssetDownloader.new(connection, catalog_id) }

    # ---------------------------------------------------------------------

    it 'returns a file' do
      subject.download_asset(asset_id).must_equal "foo"
    end

  end
end
