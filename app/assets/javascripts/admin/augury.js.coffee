window.Augury =
  init: ->
    $.ajaxPrefilter (options, originalOptions, jqXHR) ->
      jqXHR.setRequestHeader("X-Augury-Token", Augury.api_key)
      if options.url.indexOf("http", 0) is -1
        options.url = "#{Augury.url}/api#{options.url}"
      options.xhrFields = withCredentials: true

  post_init: ->
    @handle_link_clicks()

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
    @integrations = new @Collections.Integrations(@Preload.integrations)
    @mappings = new @Collections.Mappings(@Preload.mappings)
    @schedulers = new @Collections.Schedulers(@Preload.schedulers)
    @parameters = new @Collections.Parameters(@Preload.parameters)
    @messages = @Preload.messages

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

  update_nav: (active) ->
    $("ul.sidebar li").removeClass 'active'
    $("ul.sidebar li.#{active}").addClass 'active'

