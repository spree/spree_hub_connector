Augury.Views.Integrations.Signup = Backbone.View.extend(
  events:
    'click button#save': 'save'
    "change input[name='enabled']": 'toggle_enabled_services'

  render: ->
    @$el.html JST["admin/templates/integrations/signup"]
      integration: @model
      parameters_by_service: @parameters_by_service()

    @$el.find('input.param').bind "keyup paste", ->
      current = $(@)

      duplicates = $("[name='#{current.attr('name')}']")
      if duplicates.length > 1
        duplicates.val(current.val())

    @toggle_enabled_services()

    $('#content-header').find('.page-title').text(@model.get('display') + ' Setup')

    $('#content-header').find('.page-actions').remove()
    $('#content-header').find('.table-cell').after JST["admin/templates/integrations/back_button"]

    @

  parameters_by_service: ->
    @ret = {}

    _.map(@model.get("services"), (service) =>
      @ret[service["name"]] = service["requires"]["parameters"]
    )
    @ret

  toggle_enabled_services: ->
    for service_name,parameters of @parameters_by_service()
      checked = @$el.find("input[value='#{service_name}']").is ':checked'
      if checked
        @$el.find("input.#{service_name}").removeAttr 'disabled'
      else
        @$el.find("input.#{service_name}").attr 'disabled', true


  save: ->
    parameters = {}

    _($('input.param')).each (param) ->
      param = $(param)
      val = param.val()
      if val?
        parameters[param.attr('name')] = val
      else
        console.log('missing')

    enabled = $(".enabled:checked").map ->
      $(@).val()

    @model.signup parameters, enabled.get(), error: @displayErrors
)
