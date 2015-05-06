require 'savon'
require 'faraday'

# connection = ExtensisPortfolio::Connection.new(server, password, …)
# asset_downloader = ExtensisPortfolio::AssetDownloader.new(connection)
# asset_downloader.download_job(asset_id) # => ...

class ExtensisPortfolioService

  def initialize(params={})
    # NOTE: Probably should be in the settings.yml
    @server = "http://demo.extensis.com:8090"
    @username = "kamila.farshchi"
    @password = "Mh-kl#Q4TRMm&S8a"
    @catalog_name = "EADN – MCA Chicago"
    @catalog_id = "87C27791-4420-469D-0FD8-611E790AEDFA"
    @soap_client = Savon.client(wsdl: "#{@server}/ws/1.0/AssetService?wsdl")
    @session_id = get_session_id
  end

  def get_soap_operations
    @soap_client.operations
  end

  def get_assets(params={})
    # catalog_id = params.fetch(:catalog_id)
    asset_query = ExtensisAssetQuery.new
    @soap_client.call(:get_assets, message: {session_id: @session_id, catalog_id: @catalog_id, assets: {}}).body
  end

  def get_catalogs
    @soap_client.call(:get_catalogs, message: {session_id: @session_id}).body
  end

  def download_file(asset_id="2021")
    # this should be separate service
    # 
    # task = ExtensisPortfolio::Task.new(name, type, catalog_id)
    # job = ExtensisPortfolio::Job.new(source_image, tasks) # maybe there could be more jobs? not only for assets?
    # asset_query_term = ExtensisPortfolio::QueryTerm.new(…)
    # asset_query = ExtensisPortfolio::Term.new(…)
    # message = ExtensisPortfolio::Message.new(…)
    # 
    # response = connection.run_job(message)
    # job_id = response.…
    # 
    # file = asset_downloader.download_job(job_id)

    task = {
      name: "Download",
      type: "download",
      catalog_id: @catalog_id
    }
    job = {
      source_image: "original",
      tasks: [task]
    }
    asset_query_term = {
      field_name: "asset_id",
      operator: "equalValue",
      values: asset_id
    }
    asset_query = {query_term: asset_query_term}
    message = {session_id: @session_id, catalog_id: @catalog_id, assets: asset_query, job: job}

    response = @soap_client.call(:run_job, message: message).body
    job_id = response.fetch(:run_job_response).fetch(:return)

    # GET http://my-portfolio-server.com:8090/FileTransfer/download&sessionId=A0732234-04E7-11E0-B047-83BE4E1E8B7D&jobId=9138C4E4-D43C-D868-39BA-4D82374D8827 HTTP/1.1
    # Host: my-portfolio-server.com:8090
    # Connection: close
    #
    # params = {:'sessionId' => @session_id, :'jobId' => job_id}
    response = http_client.get("/FileTransfer/download&sessionId=#{@session_id}&jobId=#{job_id}")

    response.body
  end

  private # =============================================================

  def get_session_id
    login(@username, @password).body.fetch(:login_response).fetch(:return)
  end

  def run_job(catalog_id, assets, job)
    @soap_client.call(:run_job, message: {session_id: @session_id})
  end

  def login(username, password)
    message = {user_name: @username, encrypted_password: get_encrypted_password}
    @soap_client.call(:login, message: message)
  end

  def logout
    @soap_client.call(:logout)
  end

  def get_rsa_public_encryption_key
    response = @soap_client.call(:get_rsa_public_encryption_key).body.fetch(:get_rsa_public_encryption_key_response)
    modulus = response.fetch(:return).fetch(:modulus_base16).to_i(16)
    exponent = response.fetch(:return).fetch(:exponent).to_i
    RSAEncryptionService.new(modulus, exponent)
  end

  def get_encrypted_password
    get_rsa_public_encryption_key.encrypt(@password)
  end

  def http_client
    Faraday.new(url: @server) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

end
