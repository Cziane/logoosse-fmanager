@FileSchemas={}

Files= new SimpleSchema
	name :
		type :String
		label :"name"
		optional : false
		index : 1
	type :
		type String
		label :"file type"
		optional:false
	size :
		type : Number
		label : "Byte size"
		optional:false;
		decimal : true
	path :
		type : String
		label :"file path to reach it"
		optional:true;
	publish :
		type : Boolean
		label :"Private file or not"
		optional:false
		defaultValue : true
	hash :
		type : String
		label : "file hash to secure no contamination"
		optional:false
	blob :
		type :Boolean
		label:"Store in db or not"
		optional :false
		defaultValue:false
	content :
		type : String
		optional:true
