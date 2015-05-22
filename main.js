var _ = require("lodash");
//---

_.forOwn(require("./methods"), function(methods, name) {
	methods.forEach(function(method) {
		var prototype = eval(name).prototype;
		if (prototype[method] !== undefined) return;

		prototype[method] = function() {
			var args = Array.prototype.slice.call(arguments);
			return _[method].apply(this, [this].concat(args));
		};
	});
});

module.exports = _;