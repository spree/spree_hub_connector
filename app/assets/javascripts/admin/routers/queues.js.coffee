Augury.Routers.Queues = Backbone.Router.extend(
  routes:
    'queues/:id': 'index'

  index: (id) ->
    queue = new Augury.Models.Queue(id: id)
    queue.fetch().done ->
      view = new Augury.Views.Queues.Index(model: queue)
      view.render()
)

