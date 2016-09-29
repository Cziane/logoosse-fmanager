if Meteor.isServer
	ApiFile = new Restivus
		prettyJson: true


	ApiFile.addRoute 'fmanager/:fmanager/:fileName',
		get:->
			Meteor[@urlParams.fmanager].loadFile  @urlParams.fileName null