
path = require "path"
fs = require "fs-extra"
ext = path.extname(__filename)
if ext == ".coffee"
  require "coffeescript/register"
flagPath = require "./flag-path"
VirtualModulePlugin = require('virtual-module-webpack-plugin')

allFlags = {}
for file in fs.readdirSync(flagPath)
  allFlags[path.basename(file,".json")] = require path.resolve(flagPath, file)

module.exports = class Flags
  constructor: (options) ->
    result = {}
    for name in options
      tmp = name.split("-")
      set = tmp.shift()
      tmp = tmp.join("-")
      flg = allFlags[set][tmp]
      if flg?
        result[name] = flg
      else
        throw new Error "ceri-flag: flag '#{name}' not found"

    return new VirtualModulePlugin
      path: path.resolve(__dirname,"_ceri-flag.json")
      contents: JSON.stringify(result)