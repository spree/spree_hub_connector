Backbone.Collection = Backbone.Collection.extend(
  serializeToQueryString: (obj, prefix) ->
    str = []
    for p of obj
      k = (if prefix then prefix + "[" + p + "]" else p)
      str.push encodeURIComponent(k) + "=" + encodeURIComponent(obj[p])
    str.join "&"
)
