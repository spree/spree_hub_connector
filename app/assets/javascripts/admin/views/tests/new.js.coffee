Augury.Views.Tests.New = Backbone.View.extend(
  initialize: ->
    @samples = new Augury.Collections.Samples()
    @samples.bind 'add', @showSamples

  events:
    'click button#create-endpoint-message': 'createMessage'
    'select2-selected select#endpoint-message-samples': 'loadSample'
    'click button#cancel': 'cancel'

  render: ->
    @$el.html JST['admin/templates/tests/new']()
    @initializeAceEditor()
    @resetSamples()
    @$('select#endpoint-message-samples').select2()
    @

  resetSamples: ->
    $('#endpoint-message-samples').empty()
    @samples.fetch()

  showSamples: (sample) ->
    sampleMessage = sample.keys()[0]
    $('#endpoint-message-samples').
      append($('<option></option>').
                val(sampleMessage).html(sampleMessage))

  loadSample: (e) ->
    new Augury.Models.Sample(id: $(e.target).val()).
      fetch().
      done((sample) => @showSample(@editor, sample))

  showSample: (editor, sample) ->
    editor.getSession().setValue JSON.stringify(sample, null, 4)

  createMessage: (e) ->
    e.preventDefault()
    message = new Augury.Models.Message()
    message.save { origin: 'test', message: @messageValueToJSON() },
      success: @created,
      error: @displayErrors

  created: (message) ->
    messageLink = $("<a></a>").
      html(message.get('id')).
      attr('href', "/admin/integration/messages/#{message.get('id')}")
    @$('#endpoint-last-generated-message').html messageLink
    Augury.Flash.success "The message was successfully inserted into Incoming queue."

  messageValueToJSON: ->
    JSON.parse @editor.getSession().getValue()

  initializeAceEditor: ->
    @editor = ace.edit @$el.find('#endpoint-message-editor')[0]
    @editor.setTheme 'ace/theme/chrome'
    @editor.getSession().setMode 'ace/mode/json'
    @editor.setShowPrintMargin false
    @editor

  cancel: (e) ->
    e.preventDefault()
    Backbone.history.navigate '/', trigger: true
)

