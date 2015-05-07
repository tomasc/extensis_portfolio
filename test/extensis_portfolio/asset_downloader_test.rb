require 'minitest_helper'

module ExtensisPortfolio
  describe AssetDownloader do

    let(:server) { "http://demo.extensis.com:8090" }
    let(:username) { "***REMOVED***" }
    let(:password) { "***REMOVED***" }
    let(:connection) { ExtensisPortfolio::Connection.new(server, username, password) }
    let(:asset_id) { "2021" }
    let(:catalog_id) { "***REMOVED***" }

    subject { ExtensisPortfolio::AssetDownloader.new(connection, asset_id, catalog_id) }

    # ---------------------------------------------------------------------

    it 'can download a file' do
      subject.must_respond_to :download_file
    end

    describe 'download_file' do
      it 'returns a file' do
        subject.download_file.must_equal "foo"
      end
    end

  end
end
