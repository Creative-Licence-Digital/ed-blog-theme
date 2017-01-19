class SignUpView extends Backbone.View

  events:
    "submit": "onSubmit"

  initialize: ->
    @originalText = $(".signup-status").html()

  onSubmit: (e) ->
    e.preventDefault()
    window.clearTimeout @timeout

    email   = $(".signup-email").val()
    $status = $(".signup-status")

    $status.html("Creating your account...")

    done = (err, msg) =>
      @$el.removeClass("show")

      @timeout = window.setTimeout =>
        $status.html(msg)
        @$el
          .addClass("show")
          .toggleClass("success", not err)
          .toggleClass("error", err)

        window.location = "https://admin.edapp.com/welcome" unless err

        @timeout = window.setTimeout =>
          $status.html(@originalText)
          @$el.removeClass("show", "success", "error")
        , 3000
      , 100

    $.ajax
      type: "POST"
      crossDomain: true
      xhrFields: { withCredentials: true }
      url: "https://admin.edapp.com/register"
      data: { email, demo: true }
      success: =>
        done(false, "Great! Creating your account...")
      error: =>
        done(true, "Sorry, something went wrong. Please try again later.")

module.exports = SignUpView
