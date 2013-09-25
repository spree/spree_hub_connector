Augury.Views.Notifications.Index = Backbone.View.extend(
  initialize: ->
    _.bindAll @, 'renderTable'
    Augury.notifications.bind 'reset', @renderTable

  events:
    'click button[type=submit]': 'search'

  render: ->
    @$el.html JST["admin/templates/notifications/index"]()
    @$el.find('#filter-reference-type, #filter-level').select2()
    @renderTable()

    @

  renderTable: ->
    @$el.find('#notifications-view').html JST["admin/templates/notifications/notifications_table"](notifications: Augury.notifications)
    @$el.find('#notifications-table').find('td.actions a').on 'click', ->
      $(@).parent().parent().next().toggle()
      $(@).parent().parent().toggleClass('without-border')
      SyntaxHighlighter.highlight()

    # Set up pagination
    @paginator = new Augury.Views.Shared.Paginator(collection: Augury.notifications)
    @$el.find('#notifications-table').after @paginator.render().el

  search: (e) ->
    e.preventDefault()
    @setQueryFields()
    Augury.notifications.fetch(data: Augury.notifications.queryFields(), reset: true)

  setQueryFields: ->
    Augury.notifications.clearQueryFields()

    Augury.notifications.setQueryField 'reference_type', @$el.find('#filter-reference-type').select2('val')
    Augury.notifications.setQueryField 'reference_id', @$el.find('#filter-reference-id').val().toLowerCase()
    Augury.notifications.setQueryField 'level', @$el.find('#filter-level').select2('val')
)
