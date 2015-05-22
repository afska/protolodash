request = require "request"
_ = require "lodash"
#---

url = "https://raw.githubusercontent.com/lodash/lodash/master/doc/README.md"

request.get url, (err, {body: docs}) =>
	if err then process.exit 1

	included = ["Array", "Collection", "Date", "Function", "String"]

	adapt = (protos) =>
		protos.Array = protos.Array.concat protos.Collection
		_.omit protos, "Collection"

	exps = [
		/^## `(\w+)`$/                      # ## `Title`
		/^\* <a .+>`_\..+` -> `(.+)`<\/a>$/ # * <a href="...">`_.old` -> `new`</a>
		/^\* <a .+>`_\.(.+)`<\/a>$/         # * <a href="...">`_.method`</a>
	]

	makeTree = (protos, line) =>
		matcher = _.find exps, (exp) => exp.test line
		if not matcher? then return protos

		elem = line.match(matcher)[1]
		if _.first(exps).test line
			protos.push name: elem, methods: []
		else
			_.last(protos).methods.push elem

		protos

	protos = _(docs)
		.chain()
		.split /\n/
		.reduce makeTree, []
		.filter (proto) => _.contains included, proto.name
		.indexBy "name"
		.mapValues (proto) => proto.methods
		.value()

	console.log "module.exports = #{JSON.stringify adapt protos};"
