class ApplicationPresenter < SimpleDelegator
  def initialize(model, view)
    @model = model
    @view = view
    super(@model)
    puts @model.name
  end
end
