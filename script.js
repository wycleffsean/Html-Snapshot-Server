var page = require('webpage').create(),
	system = require('system');

var url = system.args[1];
page.open(url, function(status) {
	page.evaluate(function() {});	
	console.log(page.content);
	phantom.exit();
});