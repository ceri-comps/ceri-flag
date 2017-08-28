window.customElements.define "ce-flag", require "../src/flag.coffee"
ceri = require "ceri-dev-server/lib/createView"
module.exports = ceri
  structure: template 1,"""
    <a href="https://github.com/ceri-comps/ceri-flag/blob/master/dev/basic.coffee">source</a>
    <p>flg-gb:
      <ce-flag name="flg-gb" scale=2 #ref="gb"></ce-icon>
    </p>
    <p>sq-de:
      <ce-flag name="sq-de" scale=2 #ref="de"></ce-icon>
    </p>
   """
  tests: flag: ->
    before (done) -> setTimeout done, 200
    it "should work", =>
      