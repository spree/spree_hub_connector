Augury.Routers.Notifications = Backbone.Router.extend(
  routes:
    "notifications": "index"
    "notifications/:reference_token": "indexReferenceTokenSearch"

  index: ->
    Augury.update_nav 'notifications'

    view = new Augury.Views.Notifications.Index()
    $("#integration_main").html view.render().el

  indexReferenceTokenSearch: (referenceToken) ->
    Augury.update_nav 'notifications'

    view = new Augury.Views.Notifications.Index()
    el = $("#integration_main").html view.render().el
    el.find('#filter-reference-token').val(referenceToken)
    view.search()
)
