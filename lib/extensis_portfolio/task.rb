module ExtensisPortfolio
  class Task
    # Creates a new ExtensisPortfolio::Task
    #
    # @param name [String] the name of the task
    # @param type [String] the type of task, [list of options](http://doc.extensis.com/api/portfolio/assets_taskType.html)
    # @param catalog_id [String] the catalog id
    # @param settings [Array] optional settings
    def initialize(name, type, catalog_id, settings = [])
      @name = name
      @type = type
      @catalog_id = catalog_id
      @settings = settings
    end

    # Returns a Hash for use in a soap request
    #
    # @return [Hash]
    def to_hash
      {
        name: @name,
        type: @type,
        catalog_id: @catalog_id,
        settings: @settings
      }
    end
  end
end
