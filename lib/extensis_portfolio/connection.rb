require "logger"

module ExtensisPortfolio
  class Connection

    # Returns the session_id used to make calls to the Extensis Portfolio API
    #
    # @return [String]
    attr_reader :session_id

    # Returns a Faraday::Connection object for making http requests to the
    # Extensis Portfolio API
    #
    # @return [Faraday::Connection]
    attr_reader :http_client

    # Returns a Savon::Client for making calls soap requests to the
    # Extensis Portfolio API
    #
    # @return [Savon::Client]
    attr_reader :soap_client

    # Creates a new instance of ExtensisPortfolio::Connection
    #
    # @param server [String]
    # @param username [String]
    # @param password [String]
    def initialize server, username, password, options={}
      @username = username
      @password = password
      savon_options = options.merge({wsdl: "#{server}/ws/1.0/AssetService?wsdl"})
      @soap_client = Savon.client(savon_options)
      @http_client = Faraday.new(url: server)
      @session_id = get_session_id
    end

    # Logs in the soap client
    #
    # @param username [String]
    # @param password [String]
    # @return [Savon::Response]
    def login username, password
      message = {user_name: @username, encrypted_password: get_encrypted_password}

      @soap_client.call(:login, message: message)
    end

    # Logs out the soap client, making the session id invalid
    #
    def logout
      @soap_client.call(:logout)
    end

    # Returns a list of available soap operations
    #
    # @return [Array]
    def get_soap_operations
      @soap_client.operations
    end

    # Returns a list of assets based on a query
    # TODO: Simple method to get asset by id
    #
    # @param catalog_id [String]
    # @param query [AssetQuery]
    # @param result_options [Hash] optional hash with options how to display the results
    # @return [Array]
    def get_assets catalog_id, query, result_options={}
      message = {session_id: @session_id, catalog_id: catalog_id, assets: query.to_hash, result_options: result_options}

      @soap_client.call(:get_assets, message: message).body[:get_assets_response][:return][:assets]
    end

    # Returns the asset that has the provided id
    #
    # @param catalog_id [String]
    # @param asset_id [String]
    # @param result_options [Hash] optional hash with options how to display the results
    # @return [Hash]
    def get_asset_by_id catalog_id, asset_id, result_options={}
      query_term = ExtensisPortfolio::AssetQueryTerm.new("asset_id", "equalValue", asset_id)
      query = ExtensisPortfolio::AssetQuery.new(query_term.to_hash)

      get_assets(catalog_id, query, result_options)
    end

    # Returns a list of catalogs
    #
    # @return [Array]
    def get_catalogs
      message = {session_id: @session_id}

      @soap_client.call(:get_catalogs, message: message).body[:get_catalogs_response][:return]
    end

    # Returns a list of job ids
    #
    # @return [Array]
    def get_job_ids
      message = {session_id: @session_id}

      @soap_client.call(:get_job_i_ds, message: message).body[:get_job_i_ds_response][:return]
    end

    # Get the status of jobs
    #
    # @param job_ids [Array] array of job ids
    # @return [Array]
    def get_status_for_jobs job_ids
      message = {session_id: @session_id, job_ids: job_ids}

      @soap_client.call(:get_status_for_jobs, message: message).body[:get_status_for_jobs_response][:return]
    end

    # Get the error details of a job
    #
    # @param job_id [String] job id
    # @return [Hash]
    def get_error_details_for_job job_id
      message = {session_id: @session_id, job_id: job_id}

      @soap_client.call(:get_error_details_for_job, message: message).body[:get_error_details_for_job_response][:return]
    end

    private # =============================================================

    def get_session_id
      login_response = login(@username, @password).body.fetch(:login_response)

      login_response.fetch(:return)
    end

    def get_rsa_public_encryption_key
      response = @soap_client.call(:get_rsa_public_encryption_key).body
      encryption_key = response.fetch(:get_rsa_public_encryption_key_response).fetch(:return)

      {
        modulus: encryption_key.fetch(:modulus_base16).to_i(16),
        exponent: encryption_key.fetch(:exponent).to_i
      }
    end

    def get_encrypted_password
      modulus = get_rsa_public_encryption_key.fetch(:modulus)
      exponent = get_rsa_public_encryption_key.fetch(:exponent)

      ExtensisPortfolio::RSAEncryption.new(modulus, exponent).encrypt(@password)
    end

  end
end
