module ExtensisPortfolio
  class AssetDownloader

    # Creates a new instance of ExtensisPortfolio::AssetDownloader
    #
    # @param connection [ExtensisPortfolio::Connection]
    # @param catalog_id [String]
    def initialize connection, catalog_id
      @connection = connection
      @session_id = connection.session_id
      @soap_client = connection.soap_client
      @http_client = connection.http_client
      @catalog_id = catalog_id
    end

    # Runs the HTTP request on the connection and returns a file
    #
    # @param asset_id [String]
    # @return [Hash] response of the request
    def download_asset asset_id
      http_download_file_request(asset_id).body
    end

    private # =============================================================

    def task
      ExtensisPortfolio::Task.new("Download asset", "download", @catalog_id)
    end

    def job
      ExtensisPortfolio::Job.new("original", [task.to_hash])
    end

    def asset_query_term asset_id
      ExtensisPortfolio::AssetQueryTerm.new("asset_id", "equalValue", asset_id)
    end

    def asset_query asset_id
      ExtensisPortfolio::AssetQuery.new(asset_query_term(asset_id).to_hash)
    end

    def run_job_message asset_id
      {
        session_id: @session_id,
        catalog_id: @catalog_id,
        assets: asset_query(asset_id).to_hash,
        job: job.to_hash
      }
    end

    def run_job_request asset_id
      @soap_client.call(:run_job, message: run_job_message(asset_id))
    end

    def get_job_id asset_id
      run_job_request(asset_id).body.fetch(:run_job_response).fetch(:return)
    end

    def http_download_file_request asset_id
      job_id = get_job_id(asset_id)

      @http_client.get("/FileTransfer/download", {:sessionId => @session_id, :jobId => job_id})
    end

  end
end
