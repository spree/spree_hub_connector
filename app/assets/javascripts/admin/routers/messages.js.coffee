Augury.Routers.Messages = Backbone.Router.extend(
  routes:
    'messages/:id': 'show'

  show: (id) ->
    message = new Augury.Models.Message(id: id)
    message.fetch().done ->
      view = new Augury.Views.Messages.Show(model: message)
      $('#integration_main').html view.render().el
      SyntaxHighlighter.highlight()
)

