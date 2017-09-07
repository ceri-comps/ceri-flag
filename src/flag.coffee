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
    size: 
      type: Number
    scale:
      type: Number
      default: 1
    label: 
      type: String

  data: -> 
    svg: null
    ratio: 1

  computed:
    role: 
      get: -> if @label then "img" else "presentation"
    width: 
      get: -> @ratio * @height if @svg
      cbs: (val) ->
        if val? and (s = @svg)?
          s.setAttribute "width", val
          @style.display = "inline-block"
    height: 
      get: -> 
        if @size?
          return @size*@scale
        else
          return parseFloat(window.getComputedStyle(@).getPropertyValue("font-size"))*@scale
      cbs: (val) ->
        @svg?.setAttribute "height", val if val?
  watch:
    name: (name) -> 
      if (svg = flags[name])?
        @style.display = "none"
        next = requestAnimationFrame or @$nextTick
        next =>
          f = flags[name]
          @ratio = f.r
          @innerHTML = "<svg xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' viewBox='#{f.vb}'>#{f.c}</svg>"
          s = @svg = @firstChild
          s.setAttribute "aria-label", @label if @label?
          s.setAttribute "role", @role
      else if process.env.NODE_ENV != 'production'
        console.error "ceri-flag isn't setup properly - failed to get #{name}"
