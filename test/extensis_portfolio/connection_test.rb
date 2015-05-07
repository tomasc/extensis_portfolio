require 'minitest_helper'

module ExtensisPortfolio
  describe Connection do

    let(:server) { "http://demo.extensis.com:8090" }
    let(:username) { "***REMOVED***" }
    let(:password) { "***REMOVED***" }
    let(:asset_id) { "2021" }
    let(:catalog_id) { "***REMOVED***" }
    let(:query_term) { ExtensisPortfolio::AssetQueryTerm.new("asset_id", "equalValue", asset_id) }
    let(:query) { ExtensisPortfolio::AssetQuery.new(query_term) }

    subject { ExtensisPortfolio::Connection.new(server, username, password) }

    # ---------------------------------------------------------------------

    it 'returns a #session_id' do
      subject.must_respond_to :session_id
    end

    it 'returns the #session_id as a string' do
      subject.session_id.must_be_kind_of String
    end

    # ---------------------------------------------------------------------

    it 'responds to #soap_client' do
      subject.must_respond_to :soap_client
    end

    it 'returns the #soap_client as a Savon::Client' do
      subject.soap_client.must_be_kind_of Savon::Client
    end

    # ---------------------------------------------------------------------

    it 'returns a #http_client' do
      subject.must_respond_to :http_client
    end

    it 'returns the #http_client as a Faraday::Connection' do
      subject.http_client.must_be_kind_of Faraday::Connection
    end

    # ---------------------------------------------------------------------

    it 'returns a list of available soap operations' do
      subject.get_soap_operations.must_include :login
    end

    it 'returns a list of assets' do
      subject.get_assets(catalog_id, query)[:asset_id].must_equal asset_id
    end

    it 'returns a list of job ids' do
      subject.get_job_ids.must_be_kind_of Array
    end

    it 'returns the status of a job' do
      job_ids = subject.get_job_ids
      subject.get_status_for_jobs(job_ids).must_equal "foo"
    end

  end
end
