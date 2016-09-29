@getHash=(file)->
 	@CryptoJS.MD5(file.content).toString()

@defaultSecurity=(secure) ->
	return true