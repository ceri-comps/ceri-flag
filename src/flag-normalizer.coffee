fs = require "fs-extra"
path = require "path"
flagPath = require "./flag-path"
handleThat = require "handle-that"
ora = require "ora"

sets = [{
    short: "flg"
    name: "flag-icon-css"
    folder: "flag-icon-css/flags/4x3"
    re: "([a-z-]+).svg"
  },{
    short: "sq"
    name: "square flag-icon-css"
    folder: "flag-icon-css/flags/1x1"
    re: "([a-z-]+).svg"
}]

console.log "\nNormalizing SVG flags for ceri-flag"

fs.ensureDir(flagPath)

spinner = ora((remaining = sets.length) + " flag sets remaining...").start()

handleThat sets,
  worker: path.resolve(flagPath, "../lib", "_worker")
  onText: (lines) =>
    spinner.stop()
    console.log(lines.join("\n"))
    spinner.start(remaining + " flag sets remaining...")
  onProgress: (count) => spinner.text = (remaining = count) + " flag sets remaining..."
  onFinish: => spinner.succeed "all flag sets normalized"

