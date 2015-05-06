class ExtensisJob

  # Takes ExtensisSourceImage, tasks and settings Array

  def initialize(source_image, tasks, settings=[])
    @gallery_id = gallery_id
    @query_term = query_term
    @sort_options = sort_options
  end

  def to_s
    builder = Builder::XmlMarkup.new
    builder.instruct!(:xml, encoding: "UTF-8")

    builder.asset_query { |b|
      b.gallery_id(@gallery_id) if @gallery_id
      b.query_term(@query_term) if @query_term
      b.sort_options(@sort_options) if @sort_options
    }

    builder
  end

end
