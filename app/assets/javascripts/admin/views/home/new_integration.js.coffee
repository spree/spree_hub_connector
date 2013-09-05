Augury.Views.Home.NewIntegration = Backbone.View.extend(
  initialize: (attrs) ->
    @options = attrs
    @model = attrs.integration

  events:
    'click button#cancel': 'cancel'
    'change :input': 'changed'

  render: ->
    # Show modal
    @$el.html JST["admin/templates/home/new_integration"](options: @options)

    # Setup modal tabs
    @$el.find("#modal-tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix")
    @$el.find("#modal-tabs li").removeClass("ui-corner-top").addClass("ui-corner-left")

    @validation()

    @

  validation: ->
    @$el.find('form#add-new-integration').parsley
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
    @model.set(category: 'endpoint')
    @model.save {}, success: @saved, error: @displayErrors

  saved: ->
    Augury.Flash.success 'Successfully created new integration!'
    $('.ui-dialog-content').dialog 'close'

  cancel: (event) ->
    event.preventDefault()
    $('.ui-dialog-content').dialog 'close'
)
