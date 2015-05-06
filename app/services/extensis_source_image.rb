class ExtensisSourceImage

  # Takes a string "original" or "preview"

  def initialize(source)
    @source = source
  end

  def to_hash
    {
      source: @source
    }
  end

  # def to_s
  #   builder = Builder::XmlMarkup.new
  #   builder.instruct!(:xml, encoding: "UTF-8")

  #   builder.source_image { |b|
  #     b.source_image(@source)
  #   }

  #   builder
  # end

end
