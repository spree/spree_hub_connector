Augury.Routers.Queues = Backbone.Router.extend(
  routes:
    'queues/:queue_name':     'index'
    'queues/accepted/:state': 'indexByState'

  index: (queue_name) ->
    queues = new Augury.Collections.Queues([], queue_name: queue_name)
    queues.fetch().done ->
      view = new Augury.Views.Queues.Index(collection: queues)
      view.render()

  indexByState: (state) ->
    queues = new Augury.Collections.Queues([], queue_name: 'accepted')
    queues.fetch(data: { state: state }).done ->
      view = new Augury.Views.Queues.Index(collection: queues, state: state)
      view.render()
)

