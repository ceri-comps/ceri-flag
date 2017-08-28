var ceri, flags;

flags = require("./_ceri-flag.json");

ceri = require("ceri/lib/wrapper");

module.exports = ceri({
  mixins: [require("ceri/lib/style"), require("ceri/lib/props"), require("ceri/lib/computed")],
  props: {
    name: String,
    size: Number,
    scale: {
      type: Number,
      "default": 1
    },
    label: String
  },
  initStyle: {
    display: "inline-block"
  },
  data: function() {
    return {
      aspect: 1
    };
  },
  computed: {
    role: function() {
      if (this.label) {
        return "img";
      } else {
        return "presentation";
      }
    },
    width: function() {
      return this.aspect * this.height;
    },
    height: function() {
      if (this.size != null) {
        return this.size * this.scale;
      } else {
        return parseFloat(window.getComputedStyle(this).getPropertyValue("font-size")) * this.scale;
      }
    }
  },
  methods: {
    updateRole: function() {
      if ((this.svg != null) && (this.role != null)) {
        return this.svg.setAttribute("role", this.role);
      }
    },
    updateWidth: function() {
      if ((this.svg != null) && this.width) {
        return this.svg.setAttribute("width", this.width);
      }
    },
    updateHeight: function() {
      if ((this.svg != null) && this.height) {
        return this.svg.setAttribute("height", this.height);
      }
    }
  },
  watch: {
    name: function(name) {
      var s, svg;
      if ((svg = flags[name]) != null) {
        this.style.display = "none";
        this.innerHTML = flags[name];
        s = this.svg = this.firstChild;
        this.aspect = s.getAttribute("width") / s.getAttribute("height");
        this.updateRole();
        this.updateWidth();
        this.updateHeight();
        return this.style.display = "inline-block";
      } else if (process.env.NODE_ENV !== 'production') {
        return console.error("ceri-flag isn't setup properly - failed to get " + name);
      }
    },
    role: "updateRole",
    width: "updateWidth",
    height: "updateHeight"
  }
});
