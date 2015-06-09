require 'minitest_helper'
require 'tempfile'

module ExtensisPortfolio
  describe AssetDownloader do
    @@connection = ExtensisPortfolio::Connection.new(ENV['SERVER'], ENV['USERNAME'], ENV['PASSWORD'], {logger: Logger.new('test_logfile.log'), log_level: :debug})

    let(:asset_id) { "2106" }
    let(:catalog_id) { ENV['CATALOG_ID'] }

    subject { ExtensisPortfolio::AssetDownloader.new(@@connection, catalog_id) }

    # ---------------------------------------------------------------------

    it 'returns a file' do
      subject.download_asset(asset_id).length.must_equal 908532
    end

  end
end
