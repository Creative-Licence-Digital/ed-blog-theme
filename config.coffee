exports.config =
  paths:
    public: "assets"
    watched: ["source"]

  server:
    hostname: "0.0.0.0"

  plugins:
    postcss:
      processors: [
        require("autoprefixer")(["iOS 7", "iOS 8", "> 1%", "Firefox > 20"])
      ]

  overrides:
    production:
      plugins:
        postcss:
          processors: [
            require("autoprefixer")(["iOS 7", "iOS 8", "> 1%", "Firefox > 20"])
            require("csswring")
          ]

  files:
    javascripts:
      joinTo:
        "js/app.js": /^source\/js/
        "js/vendor.js": /^(vendor|bower_components)/
      order:
        before: [
          "bower_components/jquery/dist/jquery.js"
        ]

    stylesheets:
      joinTo:
        "css/app.css": /source\/css\/app.sass/

  modules:
    nameCleaner: (path) ->
      if /^(source|views)/i.test(path)
        backslashRe = /\\/g
        dotRe = /^(\.\.\/)*/g
        appRe = /^source\/js\//

        path = path
          .replace(backslashRe, "/")
          .replace(dotRe, "")
          .replace(appRe, "")
          .replace(/\.\w+$/, "")

      path
