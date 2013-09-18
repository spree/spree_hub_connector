Augury.Views.Messages.Show = Backbone.View.extend(
  events: ->
    'click nav li a': 'showSubView'

  render: ->
    @$el.html JST["admin/templates/messages/show"](model: @model)
    @$el.find('#detail-view').html JST["admin/templates/messages/_notifications"](model: @model)
    @

  showSubView: (e) ->
    templateName = $(e.currentTarget).data('template')
    @$el.find('#detail-view').html JST["admin/templates/messages/_#{templateName}"](model: @model)
)
