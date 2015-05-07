module ExtensisPortfolio
  class RSAEncryption

    def initialize(modulus, exponent)
      seq = OpenSSL::ASN1::Sequence.new([
        OpenSSL::ASN1::Integer.new(modulus),
        OpenSSL::ASN1::Integer.new(exponent)
      ])
      @public_key = OpenSSL::PKey::RSA.new(seq.to_der)
    end

    def encrypt(string)
      Base64.encode64(@public_key.public_encrypt(string))
    end

  end
end
