Augury.Routers.Home = Backbone.Router.extend(
  routes:
    "": "index"
    "add/:id": "addIntegration"
    "edit/:id": "addIntegration"
    "delete/:id?confirm=:confirm": "delete"

  index: ->
    Augury.update_nav('overview')

    view = new Augury.Views.Home.Index(collection: Augury.integrations)
    $("#integration_main").html view.render().el

  addIntegration: (id) ->
    integration = Augury.integrations.get(id)
    view = new Augury.Views.Home.AddIntegration(integration: integration)
    view.render()
    modalEl = $("#new-integration-modal")
    modalEl.html(view.el)
    modalEl.modal(
      closeHTML: "<i class=\"icon-remove\"></i>"
      minHeight: 500
      minWidth: 860
      persist: true
      onClose: (dialog) ->
        $.modal.close()
        $("#integrations-select").select2 "val", ""
        $("#new-integration-modal").html('')
        Backbone.history.navigate '/', trigger: true
    )

  delete: (id, confirm) ->
    integration = Augury.integrations.get id
    if confirm != 'true'
      dialog = JST['admin/templates/shared/confirm_delete']
      $.modal(dialog(klass: 'integration', warning: 'Are you sure you want to delete this integration?', identifier: id))
    else
      $.modal.close()
      integration.destroy()
      Augury.integrations.remove integration
      Backbone.history.navigate '/', trigger: true
      Augury.Flash.notice "The integration has been deleted."
)
