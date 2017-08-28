path = require "path"
Flags = require("./src/flag-plugin.coffee")
module.exports =
  devtool: false
  plugins:[
    new Flags(["flg-gb","sq-de"])
  ]