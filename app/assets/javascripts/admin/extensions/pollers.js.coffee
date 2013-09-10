window.Augury.Poller = class AuguryPoller
  constructor: (collectionOrModel, delay, condition) ->
    options =
      delay: delay
      delayed: true
    options.condition = condition if condition?

    @poller = Backbone.Poller.get(collectionOrModel, options)
    @poller.on 'success', ->
      collectionOrModel.trigger 'change'

  start: =>
    @poller.start()

  stop: =>
    @poller.stop()

  changeDelay: (delay) =>
    @poller.set(delay: delay, delayed: true).start()
