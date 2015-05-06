require 'savon'
require 'faraday'

class ExtensisPortfolioService

  def initialize(params={})
    # NOTE: Probably should be in the settings.yml
    @server = "http://demo.extensis.com:8090/ws/1.0/AssetService?wsdl"
    @username = 'kamila.farshchi'
    @password = 'Mh-kl#Q4TRMm&S8a'
    @catalog_name = 'EADN – MCA Chicago'
    @soap_client = Savon.client(wsdl: @server)
    @session_id = get_session_id
  end

  def get_soap_operations
    @soap_client.operations
  end

  def get_assets(params={})
    catalog_id = params.fetch(:catalog_id)
    @soap_client.call(:get_assets, message: {catalog_id: catalog_id})
  end

  def get_catalogs
    @soap_client.call(:get_catalogs, message: {session_id: @session_id})
  end

  private # =============================================================

  def get_session_id
    login(@username, @password).body.fetch(:login_response).fetch(:return)
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

  # def soap_client
  #   Savon.client(wsdl: @server)
  # end

  # def http_client
  #   Faraday.new(url: 'http://sushi.com') do |faraday|
  #     faraday.request  :url_encoded             # form-encode POST params
  #     faraday.response :logger                  # log requests to STDOUT
  #     faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
  #   end
  # end

end
