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
    SyntaxHighlighter.all()

  search: ->
    reference_type = @$el.find('#filter-reference-type').select2('data').text.toLowerCase()
    reference_id = @$el.find('#filter-reference-id').val().toLowerCase()
    level = @$el.find('#filter-level').select2('data').text.toLowerCase()

    query =
      reference_type: reference_type
      reference_id: reference_id
      level: level
    Augury.notifications.query(query)
)
