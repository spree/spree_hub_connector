window.Augury =
  init: ->
    $.ajaxPrefilter (options, originalOptions, jqXHR) ->
      jqXHR.setRequestHeader("X-Augury-Token", Augury.api_key)
      if options.url.indexOf("http", 0) is -1
        options.url = "#{Augury.url}/api#{options.url}"
      options.xhrFields = withCredentials: true

    @show_integration_menu()

  show_integration_menu: ->
    $('.sixteen.columns .block-table ').html JST["admin/templates/shared/integration_menu"]
      connections: Augury.connections

    $("#connections-select").on "select2-selected", (event, object) =>
      selected = $("#connections-select").select2('data').element
      connectionId = $(selected).val()
      if connectionId == 'new-connection'
        Backbone.history.navigate '/connections/new', trigger: true
      else
        Augury.vent.trigger 'connection:change', connectionId


  post_init: ->
    @handle_link_clicks()
    @start_resource_poller(Augury.queue_stats)
    Backbone.history.start pushState: true, root: '/admin/integration/'

  connect: ->
    @init()

    @Routers._active['connections'] = new @Routers.Connections()

    @post_init()

    url = if _(Augury.connections).size() > 0
      url = "connections"
    else
      url = "connections/new"

    Backbone.history.navigate url, trigger: true

  start: ->
    @init()
    @integrations  = new @Collections.Integrations(@Preload.integrations)
    @mappings      = new @Collections.Mappings(@Preload.mappings)
    @schedulers    = new @Collections.Schedulers(@Preload.schedulers)
    @parameters    = new @Collections.Parameters(@Preload.parameters)
    @notifications = new @Collections.Notifications(@Preload.notifications)
    @queue_stats   = new @Models.QueueStats(@Preload.queue_stats)
    @messages      = @Preload.messages

    @Routers._active['home'] = new @Routers.Home()
    @Routers._active['common'] = new @Routers.Common()
    # @Routers._active['integrations'] = new @Routers.Integrations()
    @Routers._active['mappings'] = new @Routers.Mappings
      collection: @mappings
      parameters: @parameters
    @Routers._active['schedulers'] = new @Routers.Schedulers
      collection: @schedulers
    @Routers._active['connections'] = new @Routers.Connections()
    @Routers._active['parameters'] = new @Routers.Parameters
      collection: @parameters
    @Routers._active['tests'] = new @Routers.Tests()
    @Routers._active['messages'] = new @Routers.Messages()
    @Routers._active['notifications'] = new @Routers.Notifications()
    @Routers._active['queues'] = new @Routers.Queues()

    @post_init()

  Models: {}
  Collections: {}
  Routers: { _active: {} }
  Views: {
            Home:          {}
            Integrations:  {}
            Mappings:      {}
            Connections:   {}
            Schedulers:    {}
            Parameters:    {}
            Tests:         {}
            Messages:      {}
            Notifications: {}
            Queues:        {}
            Shared:        {}
        }
  Preload: {}
  SignUp: {}

  handle_link_clicks: ->
    $(document).on "click", "a[href^='/admin/integration']", (event) ->

      href = $(event.currentTarget).attr('href')

      if href is '/admin/integration'
        href = ''
      else
        href = href.replace Backbone.history.root, ''

      if href.indexOf Backbone.history.root is 0
        event.preventDefault()
        Backbone.history.navigate href, trigger: true

  update_nav: (name='') ->
    $('nav#hub-menu li a').removeClass 'active'
    if name != ''
      $("nav#hub-menu li a#hub-menu-#{name}").addClass 'active'

  start_resource_poller: (model_or_collection, delay=60000) ->
    poller = Backbone.Poller.get(model_or_collection)
    poller.stop() if poller.active()
    poller.set(delay: delay, delayed: true)
    poller.start()
    poller.on 'success', ->
      model_or_collection.trigger 'reset'

  stop_resource_poller: (model_or_collection) ->
    Backbone.Poller.get(model_or_collection).stop()

