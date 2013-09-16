Augury.Views.Notifications.Index = Backbone.View.extend(
  render: ->
    @$el.html JST["admin/templates/notifications/index"]()
    @
)
