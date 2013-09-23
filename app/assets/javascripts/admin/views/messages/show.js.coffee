Augury.Views.Messages.Show = Backbone.View.extend(
  events: ->
    'click nav li a': 'showSubView'

  render: ->
    @$el.html JST["admin/templates/messages/show"](model: @model)
    @showInitialSubView()
    @

  showInitialSubView: ->
    switch @model.get('queue_name')
      when 'accepted' then @$el.find('#detail-view').html JST["admin/templates/messages/_payload"](model: @model)
      when 'archived' then @$el.find('#detail-view').html JST["admin/templates/messages/_result"](model: @model)
      when 'incoming' then @$el.find('#detail-view').html JST["admin/templates/messages/_children"](model: @model)

  showSubView: (e) ->
    templateName = $(e.currentTarget).data('template')
    if templateName?
      @$el.find('#detail-view').html JST["admin/templates/messages/_#{templateName}"](model: @model)
)
