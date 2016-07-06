class BasePresenter
  attr_reader :template
  def initialize(object,template)
    @object   = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end
end
