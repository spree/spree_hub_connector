Augury.Routers.Tests = Backbone.Router.extend(
  routes:
    "test": "index"

  index: ->
    Augury.update_nav 'test'

    view = new Augury.Views.Tests.New()
    $("#integration_main").html view.render().el
)
