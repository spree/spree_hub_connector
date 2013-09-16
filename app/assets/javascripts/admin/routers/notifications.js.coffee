Augury.Routers.Notifications = Backbone.Router.extend(
  routes:
    "notifications": "index"

  index: ->
    view = new Augury.Views.Notifications.Index()
    $("#integration_main").html view.render().el
)
