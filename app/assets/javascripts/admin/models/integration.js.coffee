Augury.Models.Integration = Backbone.Model.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/integrations"

  toJSON: ->
    @attributes = _.omit(@attributes, 'id')
    return integration: _(@attributes).clone()

  signup: (parameters, enabled, options={}) ->
    defer = $.Deferred()
    $.ajax
      url: "/stores/#{Augury.store_id}/integrations/#{@.id}/signup",
      type: "POST",
      data: 
        store_id: Augury.store_id
        parameters: parameters
        enabled: enabled
      success: ->
        defer.resolve()
      error: (jqXHR, textStatus, errorThrown) ->
        defer.reject(jqXHR, textStatus, errorThrown, options)
    defer.promise()

  mappings: ->
    Augury.mappings.where(integration_id: @id)

  enableMappings: ->
    defer = $.Deferred()
    $.ajax
      url: "/stores/#{Augury.store_id}/integrations/#{@.id}/enable_mappings"
      type: "GET"
      success: ->
        defer.resolve(true)
      error: ->
    defer.promise()

  disableMappings: ->
    defer = $.Deferred()
    $.ajax
      url: "/stores/#{Augury.store_id}/integrations/#{@.id}/disable_mappings"
      type: "GET"
      success: ->
        defer.resolve(true)
      error: ->
    defer.promise()

  is_enabled: ->
    mappings = Augury.mappings.where integration_id: @id
    if mappings.length > 0
      _(mappings).any (mapping) ->
        mapping.get('enabled') == true
    else
      @get('category') == 'custom'
)
