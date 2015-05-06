class ExtensisAssetQuery

  # gallery_id String
  # query_term ExtensisAssetQuery
  # query_term ExtensisAssetQuery

  def initialize(gallery_id="", query_term="", sort_options="")
    @gallery_id = gallery_id
    @query_term = query_term
    @sort_options = sort_options
  end

  def to_hash
    {
      gallery_id: @gallery_id,
      query_term: @query_term,
      sort_options: @sort_options
    }
  end

end
