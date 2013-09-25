Augury.Collections.Notifications = Augury.PaginatedCollection.extend(
  model: Augury.Models.Notification

  url: ->
    "/stores/#{Augury.store_id}/notifications"

  parse: (data) ->
    @page  = data.page
    @pages = data.pages
    data.notifications
)
