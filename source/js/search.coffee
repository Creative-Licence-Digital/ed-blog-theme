class SearchView extends Backbone.View
  events:
    "input #search-input": "onInput"

  onInput: (e) ->
    e.preventDefault()
    value  = e.target.value
    hasVal = value.length > 3

    window.clearTimeout @timeout

    if hasVal
      @search(value)
    else
      @timeout = window.setTimeout (-> $("#search-results").empty()), 300

    @$el.toggleClass "show-results", hasVal
    @$el.toggleClass "has-input", value.length > 0

  search: (value) ->
    params    = limit: 100, include: "tags"

    getLength = (post) ->
      value.split(" ").reduce (m, v) ->
        l1 = post.title.match(v)?.length or 0
        l2 = post.markdown.match(v)?.length or 0
        m + l1 + l2
      , 0

    $.get(ghost.url.api("posts", params)).done ({ posts }, status) =>
      matches = posts
        .filter((p) -> getLength(p) > 0)
        .sort((a, b) -> getLength(b) - getLength(a))

      @render value, matches

  render: (value, posts) ->
    if posts.length
      $("#search-results").html(@template(value, posts))
    else
      $("#search-results").html("<li>Sorry, nothing matches your search</li>")

  template: (value, posts) ->
    textChars = 92
    firstWord = value.split(" ")[0]?.toLowerCase()

    "<li>Showing #{posts.length} results</li>" +

    posts.map( (p) ->
      dist = textChars / 2
      content = $("<div />").html(p.html).text()
      i = content.toLowerCase().indexOf(firstWord.toLowerCase())
      i = Math.max(i, dist)
      x = i - dist
      y = i + dist

      text = content.slice(x, y).replace(firstWord, "<b>#{firstWord}</b>")

      """
        <li>
          <a href="#{p.url}">
            <h3>#{p.title}</h3>
            <p>#{if i > dist then "..." else ""}#{text}...</p>
          </a>
        </li>
      """
    ).join("")



module.exports = SearchView
