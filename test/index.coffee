Yummly = require "../lib/index"
should = require "should"

apiKey = "YOUR_API"
appId = "YOUR_APP_ID"

describe "Yummly API module", ->	

	yummly = null

	afterEach ->
		yummly = null

	describe "when instantiated", ->

		it "should return a new instance of Yummly", ->
			yummly = new Yummly 'apiKey': apiKey, 'appId': appId
			yummly.constructor.name.should.equal "Yummly"

		
		it "constructor should set api key and app id", ->
			yummly = new Yummly 'apiKey': apiKey, 'appId': appId
			yummly.apiKey.should.equal apiKey
			yummly.appId.should.equal appId

		it "constructor should throw errors if api key and app id arguments not supplied", (done) ->
			(-> new Yummly 'appId': appId ).should.throw "You must supply an API Key"
			(-> new Yummly 'apiKey': apiKey ).should.throw "You must supply an App ID"
			(-> new Yummly()).should.throw "You must supply an options hash, { apiKey: 'your_api_key', appId: 'your_app_id' }"
			done()

describe "Yummly search method", ->

	yummly = null
	search = null

	beforeEach ->
		yummly = new Yummly apiKey: apiKey, appId: appId

	afterEach ->
		yummly = null

	it "should exist", ->
		yummly.search.should.be.ok

	it "should perform a search", (done) ->
		yummly.search q: 'abalone', requireImages: true, (error, statusCode, data) ->
			if error
				console.error error
			else if statusCode is 200
				search = JSON.parse data
				done()

    it "should return results in a matches array", ->
    	search.matches.should.be.ok

    it "should return recipe names", ->
    	if matches.length > 0
    		search.matches[0].recipeName.should.be.ok

    it "should return images", ->
    	search.requireImages.should.be.ok

describe "Yummly recipe method", ->

	yummly = null
	recipe = null

	beforeEach ->
		yummly = new Yummly apiKey: apiKey, appId: appId

	afterEach ->
		yummly = null

	it "should exist", ->
		yummly.recipe.should.be.ok

	it "should get a recipe", (done) ->
		yummly.recipe 'Traditional-Abalone-Allrecipes', (error, statusCode, data) ->
			if error
				console.error error
			else if statusCode is 200
				recipe = JSON.parse data
				done()

	it "should have a name", ->
		recipe.name.should.equal "Traditional Abalone"

	it "should have images", ->
		recipe.images.length.should.equal 1

	it "should have a list of ingredients", ->
		recipe.ingredientLines.length.should.equal 9

