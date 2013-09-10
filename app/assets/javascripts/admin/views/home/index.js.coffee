Augury.Views.Home.Index = Backbone.View.extend(
  initialize: ->
    _.bindAll @, 'render'
    @collection.bind 'reset', @render
    @collection.bind 'add', @render

    # Create poller to update integrations in background
    @poller = new Augury.Poller(@collection, 600000)
    @poller.start()

  events:
    'click .edit-integration': 'editIntegration'
    'click .edit-endpoint': 'editEndpoint'
    'click .refresh-integration': 'refreshIntegration'

  render: ->
    @env = Augury.connections[Augury.env_id]

    # Filter integrations from the collection that don't have any mappings
    @filterIntegrations()

    @$el.html JST["admin/templates/home/index"](env: @env, collection: @active)
    @addAll()

    @$el.find('#active-integrations').before JST["admin/templates/shared/stats"]

    if $('#content-header .container .block-table').find('.page-actions').length < 1
      $('#content-header .container .block-table').append('<div class="table-cell"><ul class="page-actions"></ul></div>')
    $('#content-header').find('.page-actions').html JST["admin/templates/home/add_integration_select"](collection: @inactive)

    @$el.find('#integrations-list').find('.actions a').powerTip
      popupId: 'integration-tooltip'
    @$el.find('#integrations-list').find('.actions a').on
      powerTipRender: () ->
        $('#integration-tooltip').addClass $(this).attr('class')

    @setupAddIntegrationSelect()

    @

  addAll: ->
    @active.each(@addOne, @)

  addOne: (model) ->
    view = new Augury.Views.Home.Integration(model: model)
    view.render()
    @$el.find('#integrations-list').append view.el
    model.on 'destroy', view.remove, view

  filterIntegrations: ->
    activeIntegrations = @collection.filter (integration) ->
      !_(integration.mappings()).isEmpty() || integration.get('category') == 'custom'
    inactiveIntegrations = @collection.filter (integration) ->
      _(integration.mappings()).isEmpty() || !integration.get('category') == 'custom'

    @active = new Augury.Collections.Integrations(activeIntegrations)
    @inactive = new Augury.Collections.Integrations(inactiveIntegrations)

  setupAddIntegrationSelect: ->
    # Append connection select dropdown
    @$el.find('#active-integrations').html JST["admin/templates/home/new_integration"]
      collection: @inactive

    $('#content-header').find('.page-title').text('Overview')

    # Handle selections from add integration select2
    $("#integrations-select").on "select2-selected", (event, object) =>
      selected = $("#integrations-select").select2('data').element
      integrationId = $(selected).data('integration-id')
      if integrationId
        @showIntegrationModal(integrationId)
      else
        @showEndpointModal()

    $("#connections-select").on "select2-selected", (event, object) =>
      selected = $("#connections-select").select2('data').element
      connectionId = $(selected).val()
      if connectionId == 'new-connection'
        Backbone.history.navigate '/connections/new', trigger: true
      else
        Augury.vent.trigger 'connection:change', connectionId


  editIntegration: (e) ->
    e.preventDefault()
    integrationId = $(e.currentTarget).closest('li.integration').data('integration-id')
    @showIntegrationModal(integrationId)

  editEndpoint: (e) ->
    e.preventDefault()
    integrationId = $(e.currentTarget).closest('li.integration').data('integration-id')
    @showEndpointModal(integrationId)

  showIntegrationModal: (integrationId) ->
    integration = Augury.integrations.get(integrationId)
    view = new Augury.Views.Home.AddIntegration(integration: integration)
    view.render()
    modalEl = $("#new-integration-modal")
    modalEl.html(view.el)
    modalEl.dialog(
      dialogClass: 'new-integration-modal dialog-integration'
      draggable: false
      resizable: false
      modal: true
      minHeight: 400
      minWidth: 865
      show: 'fade'
      hide: 'fade'

      open: () ->
        $('body').css('overflow', 'hidden')

      close: () ->
        $('body').css('overflow', 'auto')
        $("#integrations-select").select2 "val", ""
        $("#new-integration-modal").html('')
    )

  showEndpointModal: (integrationId) ->
    if integrationId?
      integration = Augury.integrations.get(integrationId)
    else
      integration = new Augury.Models.Integration
    view = new Augury.Views.Home.NewEndpoint(integration: integration)
    view.render()
    modalEl = $("#new-integration-modal")
    modalEl.html(view.el)
    modalEl.dialog(
      dialogClass: 'new-integration-modal dialog-integration'
      draggable: false
      resizable: false
      modal: true
      minHeight: 400
      minWidth: 865
      show: 'fade'
      hide: 'fade'

      open: () -> 
        $('body').css('overflow', 'hidden')

      close: () ->
        $('body').css('overflow', 'auto')
        $("#integrations-select").select2 "val", ""
        $("#new-integration-modal").html('')
    )

  refreshIntegration: (e) ->
    e.preventDefault()
    Augury.integrations.fetch(reset: true)
    Augury.mappings.fetch(reset: true)
    Augury.Flash.success "Refreshed integration."
)
