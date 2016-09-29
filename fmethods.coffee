Meteor.methods
	saveFile :(file , fileManagername, publish=true,secure=null)->
		Meteor[fileManager].saveFile file, publish, secure

	deleteFile:(fileName , fileManager, secure=null)->
		Meteor[fileManager].deleteFile fileName, secure

	loadFile :(fileName,fileManager,secure=null)->
		Meteor[fileManager].loadFile fileName, secure

	updateFile:(fileName, file , fileManager, publish=true, secure=null)->
		Meteor[fileManager].updateFile fileName, file, publish, secure

