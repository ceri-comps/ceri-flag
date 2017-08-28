# ceri-flag

webpack based - load only what you need - svg inline flags.  
See [ceri-icon](https://github.com/ceri-comps/ceri-icon) if you need a svg inline icon.

Features:
- plain JS - no dependencies

supports:
- [(flg) flag-icon-css](http://flag-icon-css.lip.is/)
- [(sq) 1x1 flag-icon-css](http://flag-icon-css.lip.is/)

If you need other free flag sets, let me know..
### [Demo](https://ceri-comps.github.io/ceri-flag)
# Install

```sh
npm install --save-dev ceri-flag
```

## Usage
- [general ceri component usage instructions](https://github.com/cerijs/ceri#i-want-to-use-a-component-built-with-ceri)


- webpack.config:
```js
// webpack.config.js
Flags = require("ceri-flag")
...
module.exports = {
  ...
  plugins:[
    ...
    new Flags(["flg-gb","sq-de"])
    ...
  ]
  ...
}
```

- in your project
```coffee
window.customElements.define("ceri-flag", require("ceri-flag"))
```
```html
<ceri-flag name="flg-gb"></ceri-flag>
```

For examples see [`dev/`](dev/).

#### Props
Name | type | default | description
---:| --- | ---| ---
name | String | - | (required) name of the icon
label | String | name | aria-label
size | Number | (font-size) | height of the icon in px
scale | Number | 1 | size multiplier

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
