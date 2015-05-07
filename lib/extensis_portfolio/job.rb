module ExtensisPortfolio
  class Job

    # Creates a new instance of ExtensisPortfolio::Job
    #
    # @param source_image [String] source image, either `original` or `preview`
    # @param tasks [Array] array of tasks
    def initialize(source_image, tasks)
      @source_image = source_image
      @tasks = tasks
    end

    # Returns a Hash for use in a soap request
    #
    # @return [Hash]
    def to_hash
      {
        source_image: @source_image,
        tasks: @tasks.map{ |t| t.to_hash }
      }
    end

  end
end
