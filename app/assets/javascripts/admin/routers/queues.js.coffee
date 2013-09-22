Augury.Routers.Queues = Backbone.Router.extend(
  routes:
    'queues/:queue_name': 'index'

  index: (queue_name) ->
    queues = new Augury.Collections.Queues([], queue_name: queue_name)
    queues.fetch().done ->
      view = new Augury.Views.Queues.Index(collection: queues)
      view.render()
)

