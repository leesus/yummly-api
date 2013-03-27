# Yummly Node.js API

Node.js module wrapping the Yummly API.  To use you must sign up on Yummly.com to get an api key and an app id.

## Usage

Module is not yet published to npm so for the time being just clone the repo to get the code.  Run `npm install` to install the dependencies.

Public methods are search() and recipe(), see Yummly API docs for examples of returned data.  Returns JSON.

```
// Require module
var Yummly = require('yummly-api');

// Create an instance
var yummly = new Yummly({
	apiKey: 'your_api_key',
	appId: 'your_app_id'
});

// Call methods
// For other options see Yummly API
yummly.search({ q: 'Chicken'}, function(err, statusCode, data) {
	var recipes = JSON.parse(data);
});

yummly.recipe('Traditional-Abalone-Allrecipes', function(err, statusCode, data){
	var recipe = JSON.parse(data);
});
```

## Tests

Tests are written with Mocha and Should, to run `npm test`.