Augury.Views.Home.NewIntegration = Backbone.View.extend(
  initialize: (attrs) ->
    @options = attrs
    @model = attrs.integration

  events:
    'click button#cancel': 'cancel'

  render: ->
    # Show modal
    @$el.html JST["admin/templates/home/new_integration"](options: @options)

    # Setup modal tabs
    @$el.find("#modal-tabs").tabs().addClass("ui-tabs-vertical ui-helper-clearfix")
    @$el.find("#modal-tabs li").removeClass("ui-corner-top").addClass("ui-corner-left")

    @validation()

    @

  validation: ->
    @$el.find('form#new-integration').parsley
      validators:
        endpointname: (val, endpointname) ->

      listeners:
        onFormSubmit: (isFormValid, e) =>
          e.preventDefault()
          if isFormValid
            @save()

  save: () ->
    event.preventDefault()
    Augury.Flash.success 'Successfully created new integration!'
    $('.ui-dialog-content').dialog 'close'

  cancel: (event) ->
    event.preventDefault()
    $('.ui-dialog-content').dialog 'close'
)
