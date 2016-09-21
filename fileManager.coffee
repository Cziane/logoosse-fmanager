class FileManager
	constructor : (path)->
		@path= pathDir
		@database=false
		@remote=false
		@private=false

	constructor :(path, private)->
		@path= pathDir
		@database=false
		@remote=false
		@private=private

	constructor : (path, database)->
		@path= path
		@database=true
		@remote=false
		@private=false

	constructor : (path, database, private)->
		@path= path
		@database=true
		@remote=false
		@private=true

	constructor : (path, remoteAddr)->
		@path= path
		@database=false
		@remote=true
		@remoteAddr=remoteAddr
		@private=false

	constructor : (path, remoteAddr)->
		@path= path
		@database=false
		@remote=true
		@remoteAddr=remoteAddr
		@private=false


	saveFile :(file)->
		if Meteor.isClient
			Meteor.call 'saveFile' , myFile , @ , ()->

		if Meteor.isServer

	delFile :(file)->
		if Meteor.isClient
			Meteor.call 'delFile' , myFile , @ , ()->
				
		if Meteor.isServer

	updateFile :(file)->
		if Meteor.isClient
			Meteor.call 'saveFile' , myFile , @ , ()->
				
		if Meteor.isServer

	saveFiles : (files)->
		if Meteor.isClient
			for file in files then do (file) =>
				Meteor.call('saveFile' , myFile , @ , ()->
				
				)