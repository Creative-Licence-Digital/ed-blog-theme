class DisqusView extends Backbone.View
  events:
    "click": "load"

  load: ->
    @$el.remove()

    script = document.createElement('script');
    script.src = '//edapp.disqus.com/embed.js'
    script.setAttribute('data-timestamp', +new Date())
    (document.head or document.body).appendChild(script)

module.exports = DisqusView
