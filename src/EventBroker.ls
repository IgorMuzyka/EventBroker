
EventEmitter = require "events" .EventEmitter
{split, last} = require "prelude-ls"


class EventBroker extends EventEmitter
	const separator = ":"
	const acceptor = "*"
	const space = "                                                                                                "

	emit: (event, object) ~>
		super "message", {_event: event, object: object}

	on: (event, listener) ~>
		super "message", (object) ~>
			shouldSendEvent = @compareMessageNamespaces event, object._event

			if shouldSendEvent
				if event.indexOf(acceptor) != -1
					listener object._event, object.object
				else
					listener object.object

	any: (listener) ~>
		@on acceptor, listener

	compareMessageNamespaces: (required = "", given = "") ~>
		valid = false
		requiredParts = split separator, required
		givenParts = split separator, given

		if requiredParts.length <= givenParts.length or --requiredParts.length == givenParts.length and required.indexOf(acceptor) != -1
			acceptsAnySincePosition = -1
			partsToSatisfy = requiredParts.length

			for position from 0 til requiredParts.length
				if requiredParts[position] == acceptor
					acceptsAnySincePosition = position
					break

			if acceptsAnySincePosition != -1
				partsToSatisfy = acceptsAnySincePosition

			unsatisfiedParts = partsToSatisfy

			for position from 0 til partsToSatisfy
				if requiredParts[position] == givenParts[position]
					--unsatisfiedParts

			valid = !unsatisfiedParts

		valid


module.exports = EventBroker
