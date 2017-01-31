app =
  initialize: ->
    $("a").each (i, el) ->
      if el.origin isnt window.location.origin
        $(el).attr("target", "_blank")

    $("[data-view]").each (i, el) ->
      try
        View = require($(el).data("view"))
        new View({ el })
      catch err
        console.log err

module.exports = app
