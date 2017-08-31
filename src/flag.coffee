flags = require "./_ceri-flag.json"

ceri = require "ceri/lib/wrapper"

module.exports = ceri

  mixins: [
    require "ceri/lib/props"
    require "ceri/lib/computed"
  ]

  props:
    name: 
      type: String
      cbs: (name) -> 
        if (svg = flags[name])?
          @style.display = "none"
          next = requestAnimationFrame or @$nextTick
          next =>
            f = flags[name]
            @ratio = f.r
            @innerHTML = "<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='#{f.vb}'>#{f.c}</svg>"
            @svg = @firstChild
            next => @style.display = "inline-block"
        else if process.env.NODE_ENV != 'production'
          console.error "ceri-flag isn't setup properly - failed to get #{name}"
    size: Number
    scale:
      type: Number
      default: 1
    label: String

  data: -> 
    svg: null
    ratio: 1

  computed:
    role: -> if @label then "img" else "presentation"
    width: -> @ratio * @height
    height: -> 
      if @size?
        return @size*@scale
      else
        return parseFloat(window.getComputedStyle(@).getPropertyValue("font-size"))*@scale
  watch:
    svg: (s) ->
      if s?
        s.setAttribute "aria-label", @label if @label?
        s.setAttribute "role", @role 
        s.setAttribute "width", @width
        s.setAttribute "height", @height 