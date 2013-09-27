Augury.Views.Messages.Show = Backbone.View.extend(
  initialize: ->
    _.bindAll @, 'render'
    @model.on 'change', @render

  events: ->
    'click nav li a': 'showSubView'
    'click a.refresh': 'refreshMessage'
    'click a.attempt': 'attemptMessage'
    'click a.archive': 'archiveMessage'

  render: ->
    @$el.html JST["admin/templates/messages/show"](model: @model)
    @showInitialSubView()
    @

  showInitialSubView: ->
    switch @model.get('queue_name')
      when 'accepted'
        if @model.has_errors()
          @$el.find('#detail-view').html JST["admin/templates/messages/_last_error"](model: @model)
          @$el.find('[data-template=last_error]').addClass('active')
        else
          @$el.find('#detail-view').html JST["admin/templates/messages/_payload"](model: @model)
          @$el.find('[data-template=payload]').addClass('active')
      when 'archived'
        @$el.find('#detail-view').html JST["admin/templates/messages/_result"](model: @model)
        @$el.find('[data-template=result]').addClass('active')
      when 'incoming'
        @$el.find('#detail-view').html JST["admin/templates/messages/_children"](model: @model)
        @$el.find('[data-template=children]').addClass('active')


  showSubView: (e) ->
    templateName = $(e.currentTarget).data('template')
    $(e.currentTarget).closest('nav').find('a.active').removeClass('active')
    $(e.currentTarget).addClass('active')
    if templateName?
      @$el.find('#detail-view').html JST["admin/templates/messages/_#{templateName}"](model: @model)
      SyntaxHighlighter.highlight()
      if templateName == 'notifications'
        @$el.find('.message-section').find('td.actions a').on 'click', ->
          $(@).parent().parent().next().toggle()
          $(@).parent().parent().toggleClass('without-border')

  refreshMessage: (e) ->
    e.preventDefault()
    @model.fetch().done ->
      Augury.Flash.success 'Message has been refreshed.'

  attemptMessage: (e) ->
    e.preventDefault()
    $.ajax
      url: "/stores/#{Augury.store_id}/messages/#{@model.id}"
      type: "PUT"
      data: attempt_now: true
      success: =>
        Augury.Flash.success 'Message will be attempted shortly.'
        @model.fetch()
      error: ->
        Augury.Flash.error 'Message could not be attemped. Please try again.'

  archiveMessage: (e) ->
    e.preventDefault()
    $('#dialog-confirm').dialog
      dialogClass: 'dialog-delete'
      modal: true
      resizable: false
      draggable: false
      minHeight: 180
      buttons:
        "Yes": =>
          @model.archive().done =>
            $('#dialog-confirm').dialog 'close'
            @refreshMessage(e)
        "No": =>
          $('#dialog-confirm').dialog 'close'
)
