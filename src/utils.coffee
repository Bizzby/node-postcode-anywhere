url = require 'url'

exports.buildUrl = (protocol, host, servicePath, version, formatEndPoint, key, query = {}) ->

  query.key = key
  return url.format {
    protocol, 
    host,
    pathname : [servicePath, version, formatEndPoint].join '/'
    query
  }

