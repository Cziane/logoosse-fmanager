@fs= Npm.require('fs');
Meteor.methods
	saveFile :(file,secure=null,database=null)->
		if !checkHash(file)
			throw(new Meteor.Error(423, 'Failed to save file. File corrupted'));
		database= database !=null ? database : fileManager.database !=null ? fileManager.database :false
		secure = secure!= null ? secure : fileManager.secure !=null ? fileManager.secure : false
		if database
			res =Files.insert {name : file.name , type : file.type, size : file.size, publish: secure, hash : file.hash, blob :true, content :file.content }
		else
			fs.writeFile(fileManager.path + file.name, blob, encoding, (err)->
      			if err 
        			throw(new Meteor.Error(500, 'Failed to save file.', err))
     			else 
        			res =Files.insert {name : file.name , type : file.type, size : file.size,path : fileManager.path, publish: secure, hash : file.hash, blob :false }

#Check there are no corruptions of the file.
checkHash=(file)->
	return file.hash == CryptoJS.MD5(file.content).toString()

