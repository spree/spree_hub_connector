Augury.Routers.Notifications = Backbone.Router.extend(
  routes:
    "notifications": "index"

  index: ->
    Augury.update_nav 'notifications'

    view = new Augury.Views.Notifications.Index()
    $("#integration_main").html view.render().el
)
