Augury.Models.Message = Backbone.Model.extend(
  initialize: ->
    @urlRoot = "/stores/#{Augury.store_id}/messages"

  validation:
    message:
      required: true
      msg: "Message is required"
)

