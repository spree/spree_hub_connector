Augury.Collections.Samples = Backbone.Collection.extend(
  model: Augury.Models.Sample

  initialize: ->
    @url = '/samples'
)
