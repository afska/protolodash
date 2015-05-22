# protolodash
Talk directly with whom you have to talk!

This is a wrapper of [lodash](https://github.com/lodash/lodash) library, that inserts its utils into the prototypes of your primitive types. In teory, it's auto-updatable as the function names are obtained with a crawler of the official docs. Enjoy!

## users
### how to use
```javascript
var _ = require('protolodash');

[1, [2, 3], [4]].flatten();
// → [1, 2, 3, 4]

['one', 'two', 'three'].groupBy('length');
// → { '3': ['one', 'two'], '5': ['three'] }

"abc".padLeft(6);
// → "   abc"

function(a, b) { return a + b; }.partial(2)(3);
// → 5

_.isNull(null);
// → true
//(you can still use lodash normally)
```

### how to install
```bash
npm install protolodash --save
```

### what is supported?
```javascript
["Array", "Collection", "Date", "Function", "String"]
```

#### ...and Object?
Noup.

## devs
### how to update
```bash
sudo npm install -g coffee-script
npm install
coffee crawler.coffee > methods.js
```
