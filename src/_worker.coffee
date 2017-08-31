fs = require "fs-extra"
SVGO = require "svgo"
svgo = new SVGO(multipass: true)
path = require "path"
minify = require('html-minifier').minify
cheerio = require "cheerio"
flagPath = require "./flag-path"

processFile = (file, name) => 
  fs.readFile file, encoding:"utf8"
  .then (content) => new Promise (resolve) =>
    svgo.optimize content, (optimized) => 
      
      $ = cheerio.load(optimized.data)
      svg = $("svg")
      minified = minify svg.html(),
        caseSensitive: true # for svg
        keepClosingSlash: true # for svg
        quoteCharacter: "'" # for optimized json
        removeAttributeQuotes: true # smaller
        sortAttributes:true # for better compression
      resolve(n: name, vb: svg.attr("viewBox"), r: svg.attr("width")/svg.attr("height"), c: minified)
    #resolve(name: name, svg: content)
module.exports = (sets) => Promise.all sets.map (set) =>
  re = new RegExp(set.re,"i")
  optimizers = []
  for f in ["node_modules/#{set.folder}","../#{set.folder}"]
    folder = path.resolve(f)
    try
      stat = await fs.lstat(folder)
      break if stat.isDirectory()
    folder = null
  if folder
    files = await fs.readdir(folder)
    for file in files 
      optimizers.push(processFile(path.resolve(folder,file),name[1])) if (name = re.exec(file))?

  return Promise.all(optimizers)
    .then (flags) =>
      obj = {}
      for flag in flags
        if flag?.n?
          obj[flag.n] = flag
          delete flag.n
      console.log "#{set.short} (#{set.name}): #{flags.length} flags"
      return obj
    .then JSON.stringify
    .then fs.writeFile.bind(null, path.resolve(flagPath,"#{set.short}.json"))
  
