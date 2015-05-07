module ExtensisPortfolio
  class AssetDownloader

    # Creates a new instance of ExtensisPortfolio::AssetDownloader
    #
    # @param connection [ExtensisPortfolio::Connection]
    # @param asset_id [String]
    # @param catalog_id [String]
    def initialize(connection, catalog_id)
      @connection = connection
      @session_id = connection.session_id
      @soap_client = connection.soap_client
      @http_client = connection.http_client
      @catalog_id = catalog_id
    end

    # Runs the HTTP request on the connection and returns a file
    #
    # @return [Hash] response of the request
    def download_asset(asset_id)
      http_response.body
    end

    private # =============================================================

    def task
      ExtensisPortfolio::Task.new("Download asset", "download", @catalog_id).to_hash
    end

    def job
      ExtensisPortfolio::Job.new("original", [task]).to_hash
    end

    def asset_query_term(asset_id)
      ExtensisPortfolio::AssetQueryTerm.new("asset_id", "equal_value", @asset_id).to_hash
    end

    def asset_query(asset_id)
      ExtensisPortfolio::AssetQuery.new(asset_query_term(asset_id)).to_hash
    end

    def run_job_message(asset_id)
      {
        session_id: @session_id,
        catalog_id: @catalog_id,
        assets: asset_query(asset_id),
        job: job.to_hash
      }
    end

    def run_job_request
      @soap_client.call(:run_job, message: run_job_message(asset_id))
    end

    def job_id
      run_job_request.body.fetch(:run_job_response).fetch(:return)
    end

    def http_response
       @http_client.get("/FileTransfer/download&sessionId=#{@session_id}&jobId=#{job_id}")
    end

  end
end
