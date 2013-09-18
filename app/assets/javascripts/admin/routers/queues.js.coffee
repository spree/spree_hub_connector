Augury.Routers.Queues = Backbone.Router.extend(
  routes:
    'queues/:queue_name': 'index'

  index: (queue_name) ->
    view = new Augury.Views.Queues.Index(queue_name: queue_name)
    view.render()
)

