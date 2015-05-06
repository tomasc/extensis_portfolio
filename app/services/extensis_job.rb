class ExtensisJob

  # source_image ExtensisSourceImage
  # Takes ExtensisSourceImage, tasks Array and settings Array

  def initialize tasks, source_image="SourceImage::original"
    @source_image = source_image
    @tasks = tasks
  end

  def to_hash
    {
      source_image: @source_image,
      tasks: @tasks
    }
  end

end
