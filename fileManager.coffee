class @FileManager
	constructor : (path='', mime=[], secure=null, sizeMax=0, database=false)->
		@mime=mime
		if !secure
			@checkSecurity=defaultSecurity
		else
			@checkSecurity=secure
		@sizeMax=sizeMax
		@path='/'+path.replace(/\.\./g,'').replace(/\/+/g,'').replace(/^\/+/,'').replace(/\/+$/,'')
		@database=database


	saveFile :(file,publish=true,secure=null)->
		if @sizeMax>0 && file.size > @sizeMax
			throw new Meteor.Error(456, 'Failed to save file. File size over size allowed')
		if @mime.lenght>0 && @mime.indexOf(file.type)==-1
			throw new Meteor.Error(456, 'Failed to save file. File type not allowed')
		if !@checkSecurity(secure)
			throw new Meteor.Error(423, 'Failed to save file. You are not allowed to')
		if Files.findOne {name : file.name } , {name : 1} 
				throw new Meteor.Error(425, 'Failed to save file. File Already stored use update method')
		if @database
			res =Files.insert {name : @path+file.name , ftype : file.type, size : file.size, publish: publish,secure :@secure ,hash : getHash(file), blob :true, content :file.content }
		else
			fs=Npm.require('fs');
			if !fs.existsSync(@path)
				fs.mkdirSync(@path);
			encoding=file.type =='text' ? 'utf8' : 'binary'
			fs.writeFileSync Meteor.settings.fmanagerFolder+@path + file.name.replace(/\.\./g,'').replace(/\//g,''), file.content, encoding
			res =Files.insert {name : @path+file.name, ftype : file.type, size : file.size, path : path, publish: publish, secure :@secure,hash : file.hash, blob :false}
		return true

	loadFile : (fileName,secure=null)->
		loadedFile=Files.findOne {name : @path+file.name }
		if !loadedFile
			throw new Meteor.Error(444, 'Failed to save file. not found')
		if !loadedFile.publish && !@checkSecurity(secure)
			throw new Meteor.Error(423, 'Not allowed to load file')
		if !loadedFile.blob
			loadedFile.content=readFileSync(Meteor.settings.fmanagerFolder+loadFile.name)
		if loadedFile.hash != getHash(loadFile.content)
				throw new Meteor.Error(445,'File corrupted')
		return loadedFile

	deleteFile : (fileName,secure=null)->
		loadedFile=Files.findOne {name : @path+file.name }
		if !loadedFile
			throw new Meteor.Error(444, 'Failed to save file. not found')
		if loadedFile.secure && !@checkSecurity(secure)
			throw new Meteor.Error(423, 'Not allowed to load file')
		if !loadedFile.blob
			readFileSync(Meteor.settings.fmanagerFolder+loadFile.name)
		Files.deleteOne(@path+file.name)
		return true

	updateFile : (fileName,file, publish=true, secure=null)->
		if @sizeMax>0 && file.size > @sizeMax
			throw new Meteor.Error(456, 'Failed to save file. File size over size allowed')
		if @mime.lenght>0 && @mime.indexOf(file.type)==-1
			throw new Meteor.Error(456, 'Failed to save file. File type not allowed')
		if !@checkSecurity(secure)
			throw new Meteor.Error(423, 'Failed to save file. You are not allowed to')
		if !Files.findOne {name : fileName } , {name : 1} 
				throw new Meteor.Error(444, 'Failed to update file. File not stored use save method')
		if @database
			res =Files.insert {name : @path+fileName , ftype : file.type, size : file.size, publish: publish,secure :@secure ,hash : getHash(file), blob :true, content :file.content }
		else
			fs=Npm.require('fs');
			if !fs.existsSync(@path)
				fs.mkdirSync(@path);
			encoding=file.type =='text' ? 'utf8' : 'binary'
			fs.writeFileSync Meteor.settings.fmanagerFolder+@path + fileName.replace(/\.\./g,'').replace(/\//g,''), file.content, encoding
			res =Files.update {name : @path+fileName, ftype : file.type, size : file.size, path : path, publish: publish, secure :@secure,hash : file.hash, blob :false, content: null}
		return true
