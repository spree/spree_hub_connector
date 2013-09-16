Augury.Routers.Tests = Backbone.Router.extend(
  routes:
    "test": "index"

  index: ->
    view = new Augury.Views.Tests.New()
    $("#integration_main").html view.render().el
)
