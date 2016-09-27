@getHash=(file)->
 	@CryptoJS.MD5(file.content).toString()

@checkSecurity=(secure) ->
	return true