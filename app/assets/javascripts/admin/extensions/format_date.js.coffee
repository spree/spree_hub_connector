window.Augury.format_date = (stringToParse, format) ->
  if format?
    moment(stringToParse).format(format)
  else
    moment(stringToParse).format('ddd, MMM Do YYYY h:mm:ss a')
