#save a File on remote server
@saveFile=(file,secure=null,database=null)->
	fs=Npm.require('fs');
	if !checkHash(file)
		throw(new Meteor.Error(423, 'Failed to save file. File corrupted'))
	database= database !=null ? database : fileManager.database !=null ? fileManager.database :false
	secure = secure!= null ? secure : fileManager.secure !=null ? fileManager.secure : false
	if database
		res =Files.insert {name : file.name , type : file.type, size : file.size, publish: secure, hash : file.hash, blob :true, content :file.content }
	else
		encoding=file.type =='text' ? 'utf8' : 'binary'
		fs.writeFile(fileManager.path + file.name, blob, encoding, (err)->
      	if err 
        	throw(new Meteor.Error(422, 'Failed to save file.', err))
     	else 
        	res =Files.insert {name : file.name , type : file.type, size : file.size,path : fileManager.path, publish: secure, hash : file.hash, blob :false }
    return 0;
#delete a file on local application
@delFile=()->
#Save a file on remote application
@remoteSaveFile=(file, remote, secure=null)->


@remoteDelFile=()->


#Check there are no corruptions of the file.
checkHash=(file)->
	return file.hash == CryptoJS.MD5(file.content).toString()

#Check if remote server work.
checkRemote=()->

#