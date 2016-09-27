Meteor.methods
	saveFile :(file , publish, fileManagername)->
		Meteor[fileManager].saveFile file publish
	deletFile:(file , fileManager)->

	updateFile:(file , fileManager)->


