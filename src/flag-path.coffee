path = require "path"
if path.extname(__filename) == ".coffee"
  try
    require "coffeescript/register"
  catch
    try
      require "coffee-script/register"
flagsPath = "../flags"
module.exports = path.resolve(__dirname, flagsPath)