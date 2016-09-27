class @FileManager
	constructor : (src, path='', mime=[], secure=null, sizeMax=0, database=false)->
		@src=src
		@mime=mime
		@secure=secure
		@sizeMax=sizeMax
		@path='/'+path.replace(/\.\./g,'').replace(/\/+/g,'').replace(/^\/+/,'').replace(/\/+$/,'')
		@database=database


	saveFile :(file,publish)->
		if @sizeMax>0 && file.size > @sizeMax
			throw new Meteor.Error(456, 'Failed to save file. File size over size allowed')
		if @mime.lenght>0 && @mime.indexOf(file.type)==-1
			throw new Meteor.Error(456, 'Failed to save file. File type not allowed')
		if !checkSecurity(secure)
			throw new Meteor.Error(423, 'Failed to save file. You are not allowed to')
		if Files.findOne {name : file.name } , {name : 1} 
				throw new Meteor.Error(425, 'Failed to save file. File Already stored use update method')
		if database
			res =Files.insert {name : @path+file.name , ftype : file.type, size : file.size, publish: publish, hash : file.hash, blob :true, content :file.content }
		else
			fs=Npm.require('fs');
			if !fs.existsSync(@path)
				fs.mkdirSync(@path);
				encoding=file.type =='text' ? 'utf8' : 'binary'
				fs.writeFile Meteor.settings.fmanagerFolder+@path + file.name.replace(/\.\./g,'').replace(/\//g,''), file.content, encoding, (err)->
					if err 
						throw err
					#else
						#res =Files.insert {name : @path+file.name, ftype : file.type, size : file.size, path : path, publish: publish, hash : file.hash, blob :false}

	loadFile : (fileName)->
		Files.findOne {name : @path+file.name } , {name : 1} 
	deleteFile : (fileName)->


	updateFile : (fileName,file)->
