Augury.Collections.Notifications = Augury.PaginatedCollection.extend(
  model: Augury.Models.Notification

  url: ->
    "/stores/#{Augury.store_id}/notifications?page=#{@_page}"
)
