Augury.Views.Home.NewEndpoint = Backbone.View.extend(
  initialize: (attrs) ->
    @options = attrs
    @model = attrs.integration

  events:
    'click button#cancel': 'cancel'
    'change :input': 'changed'

  render: ->
    # Show modal
    @$el.html JST["admin/templates/home/new_endpoint"](model: @model)

    @validation()

    @

  validation: ->
    @$el.find('form#add-new-endpoint').parsley
      trigger: 'change'
      listeners:
        onFormSubmit: (isFormValid, e) =>
          e.preventDefault()
          if isFormValid
            @save()
      validators:
        endpointname: (val, endpointname) ->
          pattern = /^[a-z|_]*$/
          return pattern.exec(val) != null
        endpointurl: (val, endpointurl) ->
          regex = VerEx()
            .startOfLine()
            .then('http')
            .maybe('s')
            .then('://')
            .maybe('www.')
            .anythingBut(' ')
            .endOfLine()
          regex.test val.trim()
      messages:
        endpointname: "This value must be lowercase and contain no spaces"
        endpointurl: "This value must be a valid URL"

  save: ->
    @model.set(category: 'custom', display: @model.get('name'))
    @model.save {}, 
      success: =>
        if !_.find(Augury.integrations, (integration) -> integration == @model)
          Augury.integrations.add @model
        Augury.Flash.success 'Successfully created new integration!'
        $('.ui-dialog-content').dialog 'close'
      error: @displayErrors

  saved: ->

  cancel: (event) ->
    event.preventDefault()
    $('.ui-dialog-content').dialog 'close'
)
