'use strict'

http = require 'http'
querystring = require 'querystring'

noop = ->

getJSON = (options, callback) ->
	http.get options, (res) ->
		jsonData = ''
		res
			.on 'error', (e) ->
				callback e
			.on 'data', (data) ->
				jsonData += data
			.on 'end', (e) ->
				callback e, res.statusCode, jsonData

module.exports = class Yummly

	constructor: (options) ->
		unless options?
			throw new Error "You must supply an options hash, { apiKey: 'your_api_key', appId: 'your_app_id' }"
		
		if options.apiKey
			@apiKey = options.apiKey
		else
			throw new Error "You must supply an API Key"

		if options.appId
			@appId = options.appId
		else
			throw new Error "You must supply an App ID"

		@defaults =
			host: 'api.yummly.com'
			port: 80
			rootPath: '/v1/api/'
			path: ''
			headers:
				'Content-Type': 'application/json'
				'X-Yummly-App-ID': @appId
				'X-Yummly-App-Key': @apiKey


	search: (options, callback = noop) ->
		@defaults.path = @defaults.rootPath + 'recipes'
		if options
			@defaults.path += '?' + querystring.stringify options

		getJSON @defaults, callback

	recipe: (recipeId, callback = noop) ->
		@defaults.path = @defaults.rootPath + 'recipe/' + recipeId
		getJSON @defaults, callback