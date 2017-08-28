flags = require "./_ceri-flag.json"

ceri = require "ceri/lib/wrapper"

module.exports = ceri

  mixins: [
    require "ceri/lib/style"
    require "ceri/lib/props"
    require "ceri/lib/computed"
  ]

  props:
    name: String
    size: Number
    scale:
      type: Number
      default: 1
    label: String

  initStyle:
    display: "inline-block"

  data: -> aspect: 1

  computed:
    role: -> if @label then "img" else "presentation"
    width: -> @aspect * @height
    height: -> 
      if @size?
        return @size*@scale
      else
        return parseFloat(window.getComputedStyle(@).getPropertyValue("font-size"))*@scale
  methods:
    updateRole: -> @svg.setAttribute "role", @role if @svg? and @role?
    updateWidth: -> @svg.setAttribute "width", @width if @svg? and @width
    updateHeight: -> @svg.setAttribute "height", @height if @svg? and @height
  watch:
    name: (name) -> 
      if (svg = flags[name])?
        @style.display = "none"
        @innerHTML = flags[name]
        s = @svg = @firstChild
        @aspect = s.getAttribute("width")/s.getAttribute("height")
        @updateRole()
        @updateWidth()
        @updateHeight()
        @style.display = "inline-block"
      else if process.env.NODE_ENV != 'production'
        console.error "ceri-flag isn't setup properly - failed to get #{name}"
    role: "updateRole"
    width: "updateWidth"
    height: "updateHeight"