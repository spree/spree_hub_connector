Augury.Routers.Messages = Backbone.Router.extend(
  routes:
    "messages": "index"
    "messages/:id": "show"

  index: ->
    view = new Augury.Views.Messages.Index
    $("#integration_main").html view.render().el

  show: ->
    message = new Augury.Models.Message
    view = new Augury.Views.Messages.Show(model: message)
    $("#integration_main").html view.render().el
)
