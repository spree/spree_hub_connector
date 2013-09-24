Augury.Routers.Queues = Backbone.Router.extend(
  routes:
    'queues/:queue_name':     'index'
    'queues/accepted/:state': 'indexByState'

  index: (queue_name) ->
    Augury.update_nav 'messages'

    queues = new Augury.Collections.Queues([], queue_name: queue_name)
    queues.fetch().done ->
      view = new Augury.Views.Queues.Index(collection: queues)
      $('#integration_main').html view.render().el

  indexByState: (state) ->
    Augury.update_nav 'messages'

    queues = new Augury.Collections.Queues([], queue_name: 'accepted')
    queues.fetch(data: { state: state }).done ->
      view = new Augury.Views.Queues.Index(collection: queues, state: state)
      $('#integration_main').html view.render().el
)

