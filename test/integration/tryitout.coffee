
Gateway = require '../../src/Gateway'

unless process.env.PA_KEY?
  console.log 'You need to set PA_KEY in oyur environment'
  process.exit 1

gw = new Gateway process.env.PA_KEY

gw.bankAccountValidationInteractiveValidate '00000000', '000000', (err, res) ->
  console.log 'ERR', err
  console.log 'RES', res
