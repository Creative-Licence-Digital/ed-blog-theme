app =
  initialize: ->
    $("[data-view]").each (i, el) ->
      try
        View = require($(el).data("view"))
        new View({ el })
      catch err
        console.log err

module.exports = app
