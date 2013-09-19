querystring = require 'querystring'

hyperquest  = require 'hyperquest'


class Gateway


  @PROTOCOL = "http:"
  @DOMAIN = "//services.postcodeanywhere.co.uk/"
  @API_VERSION = "v2.00"
  @DEFAULT_FORMAT = "json3"


  constructor: (key, requestModule = hyperquest) ->
    throw new Error 'Invalid postcode anywhere key' unless typeof key is 'string'
    @key = key
    @request = requestModule


  _getPath: (path) ->
    throw new TypeError 'Invalid path' unless typeof path is 'string'
    query = querystring.stringify { "key": @key }
    
    return "#{Gateway.PROTOCOL}#{Gateway.DOMAIN}#{path}#{Gateway.API_VERSION}/#{Gateway.DEFAULT_FORMAT}.ws?#{query}"


  bankAccountValidationInteractiveValidate: (accountNumber, sortCode, callback) ->
    throw new TypeError unless callback instanceof Function

    return callback new TypeError 'Invalid sort code' unless sortCode? and /^[\d{2}-\d{2}-\d{2}]|[\d{8}]$/.test sortCode
    return callback new TypeError 'Invalid account number' unless accountNumber? and /^\d{8}$/.test accountNumber

    path = @_getPath 'BankAccountValidation/Interactive/Validate/'

    path += "&" + querystring.stringify { "AccountNumber": accountNumber, "SortCode": sortCode }

    req = @request.get path

    req.on 'error', callback

    req.on 'response', (res) ->

      res.on 'error', callback
      
      data = ''
      res.on 'data', (chunk) -> data += chunk
      res.on 'end', () -> callback null, data


module.exports = Gateway
