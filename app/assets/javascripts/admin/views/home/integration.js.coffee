Augury.Views.Home.Integration = Backbone.View.extend(
  initialize: (options) ->
    @listenTo @model, 'change', @render
    @listenTo @model, 'destroy', @remove

    @poller = (new Augury.Poller @model, 15000, (model) ->
      !model.get('consumers') || model.get('consumers').length < 1
    ).start()

  tagName: 'li'

  events:
    'click .integration-toggle': 'toggleIntegration'

  render: ->
    @$el.html JST["admin/templates/home/integration"](model: @model)

    if @model.is_custom()
      @$el.addClass 'custom'
    @$el.addClass 'integration'
    if @model.is_enabled()
      @$el.addClass 'enabled'
    else
      @$el.addClass 'disabled'
    @$el.data('vendor', '')
    @$el.data('integration-id', @model.get('id'))

    # Set integration toggle as enabled/disabled
    @$el.find('.integration-toggle').toggles
      on:    true
      width: 90
      text:
        on:  'Enabled',
        off: 'Disabled'
    unless @model.is_enabled()
      id = @model.get('id')
      @$el.find(".integration-toggle").first().trigger('toggleOff')

  toggleIntegration: (e) ->
    e.preventDefault()
    integration = @model

    if @$el.hasClass 'enabled'
      integration.disableMappings().done(=>
        @$el.removeClass('enabled').addClass('disabled')
        Augury.integrations.fetch()
        Augury.mappings.fetch()
        @active = Augury.integrations
      ).fail(->
        Augury.Flash.error "There was a problem updating the integration."
      )
    else
      integration.enableMappings().done(=>
        @$el.removeClass('disabled').addClass('enabled')
        Augury.integrations.fetch()
        Augury.mappings.fetch()
        @active = Augury.integrations
      ).fail(->
        Augury.Flash.error "There was a problem updating the integration."
      )
)
