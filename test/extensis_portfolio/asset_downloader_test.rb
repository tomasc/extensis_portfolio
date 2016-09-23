require 'minitest_helper'
require 'tempfile'

module ExtensisPortfolio
  describe AssetDownloader do
    let(:asset_id) { '11826' }
    let(:catalog_id) { ENV['CATALOG_ID'] }

    before do
      VCR.use_cassette 'asset_downloader', match_requests_on: %i(path) do
        @@connection = ExtensisPortfolio::Connection.new(ENV['SERVER'], ENV['USERNAME'], ENV['PASSWORD'], logger: Logger.new('test_logfile.log'), log_level: :debug)
      end
    end

    subject { ExtensisPortfolio::AssetDownloader.new(@@connection, catalog_id) }

    it 'returns a file' do
      subject.download_asset(asset_id).length.must_equal 295_440
    end
  end
end
