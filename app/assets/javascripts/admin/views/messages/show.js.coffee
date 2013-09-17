Augury.Views.Messages.Show = Backbone.View.extend(
  render: ->
    @$el.html JST["admin/templates/messages/show"](model: @model)
    @showSubView('notifications')
    @

  showSubView: (templateName) ->
    @$el.find('#detail-view').html JST["admin/templates/messages/_#{templateName}"](model: @model)
)
