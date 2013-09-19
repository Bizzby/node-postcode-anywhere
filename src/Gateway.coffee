hyperquest  = require 'hyperquest'
utils = require './utils'

PROTOCOL = "https"
HOST = "services.postcodeanywhere.co.uk"
#Turns out these versions and formats are related to the service you are talking to 
API_VERSION = "v2.00"
DEFAULT_FORMAT = "json3.ws" #json2 is for JSONP


class Gateway


  constructor: (key, options = {}) ->
    throw new Error 'Invalid postcode anywhere key' unless typeof key is 'string'

    @key = key

    @request = options.requestModule || hyperquest
    @protocol = options.protocol || PROTOCOL
    @host = options.host || HOST
    @apiVersion = options.apiVersion || API_VERSION 


  _buildUrl : (servicePath, query) ->
    utils.buildUrl @protocol, @host, servicePath, @apiVersion, DEFAULT_FORMAT, @key, query


  bankAccountValidationInteractiveValidate: (accountNumber, sortCode, callback) ->
    throw new TypeError unless callback instanceof Function

    return callback new TypeError 'Invalid sort code' unless sortCode? and /^[\d{2}-\d{2}-\d{2}]|[\d{8}]$/.test sortCode
    return callback new TypeError 'Invalid account number' unless accountNumber? and /^\d{8}$/.test accountNumber
    
    url = @_buildUrl 'BankAccountValidation/Interactive/Validate', { "AccountNumber": accountNumber, "SortCode": sortCode }
    req = @request.get  url

    req.on 'error', callback

    req.on 'response', (res) ->

      res.on 'error', callback

      data = ''
      res.on 'data', (chunk) -> data += chunk
      res.on 'end', () -> 

        try data = JSON.parse data
        catch error
          #TODO make this error nicer - e.g error parsing json
          return callback error

        unless data.Items?[0]?
          return callback new Error 'Invalid response'

        if data.Items[0].Error?
          return callback new Error data.Items[0].Description

        return callback null, data.Items[0]


module.exports = Gateway
