window.Augury.Poller = class AuguryPoller
  constructor: (collection, delay) ->
    @poller = Backbone.Poller.get(collection, { delay: delay, delayed: true })
    @poller.on 'success', ->
      collection.trigger 'reset'

  start: =>
    @poller.start()

  stop: =>
    @poller.stop()

  changeDelay: (delay) =>
    @poller.set(delay: delay, delayed: true).start()
