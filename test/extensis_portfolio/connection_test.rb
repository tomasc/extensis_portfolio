require 'minitest_helper'

module ExtensisPortfolio
  describe Connection do
    @@connection = ExtensisPortfolio::Connection.new(ENV['SERVER'], ENV['USERNAME'], ENV['PASSWORD'], {logger: Logger.new('test_logfile.log'), log_level: :debug})

    let(:asset_id) { "2106" }
    let(:catalog_id) { ENV['CATALOG_ID'] }
    let(:query_term) { ExtensisPortfolio::AssetQueryTerm.new("asset_id", "equalValue", asset_id) }
    let(:query) { ExtensisPortfolio::AssetQuery.new(query_term) }

    # ---------------------------------------------------------------------

    it 'returns a #session_id' do
      @@connection.must_respond_to :session_id
    end

    it 'returns the #session_id as a string' do
      @@connection.session_id.must_be_kind_of String
    end

    # ---------------------------------------------------------------------

    it 'responds to #soap_client' do
      @@connection.must_respond_to :soap_client
    end

    it 'returns the #soap_client as a Savon::Client' do
      @@connection.soap_client.must_be_kind_of Savon::Client
    end

    # ---------------------------------------------------------------------

    it 'returns a #http_client' do
      @@connection.must_respond_to :http_client
    end

    it 'returns the #http_client as a Faraday::Connection' do
      @@connection.http_client.must_be_kind_of Faraday::Connection
    end

    # ---------------------------------------------------------------------

    it 'returns a list of available soap operations' do
      @@connection.get_soap_operations.must_include :login
    end

    it 'returns a list of catalogs' do
      @@connection.get_catalogs.must_be_kind_of Savon::Client
    end

    it 'returns a list of assets' do
      @@connection.get_assets(catalog_id, query)[:asset_id].must_equal asset_id
    end

    it 'returns an asset by id' do
      @@connection.get_asset_by_id(catalog_id, asset_id)[:asset_id].must_equal asset_id
    end

    it 'returns a list of job ids' do
      @@connection.get_job_ids.must_be_kind_of Array
    end

    it 'returns the status of jobs' do
      job_ids = @@connection.get_job_ids
      @@connection.get_status_for_jobs(job_ids).first[:catalog_id].must_equal catalog_id
    end

    it 'returns the error details of a job' do
      job_id = @@connection.get_job_ids.first
      @@connection.get_error_details_for_job(job_id).must_be_kind_of Hash
    end

    it 'returns the error details of a job' do
      job_id = @@connection.get_job_ids.first
      @@connection.get_error_details_for_job(job_id).must_be_kind_of Hash
    end

  end
end
