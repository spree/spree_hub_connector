Augury.Views.Home.Integration = Backbone.View.extend(
  initialize: (options) ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove

  tagName: 'li'

  render: ->
    @$el.html JST["admin/templates/home/integration"](model: @model)

    @$el.addClass 'integration'
    if @model.is_enabled()
      @$el.addClass 'enabled'
    else
      @$el.addClass 'disabled'
    @$el.data('vendor', '')
    @$el.data('integration-id', @model.get('id'))
)
