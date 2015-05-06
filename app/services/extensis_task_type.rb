class ExtensisTaskType

  # Takes type Symbol

  def initialize(type)
    @type = type
  end

  def to_hash
    {
      type: @type
    }
  end

end
