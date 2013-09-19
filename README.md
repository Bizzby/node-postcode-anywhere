# node postcode anywere

[Postcode Anywhere](http://www.postcodeanywhere.co.uk/support/webservices.aspx) Web Service node.js wrapper

## install
```bash
npm install postcode-anywhere
```

## usage
```javascript

var key '<YOUR_API_KEY_OBTAINED_FROM_THE_POSTCODE_ANYWHERE>'

var gateway = new Gateway( key );

gateway.bankAccountValidationInteractiveValidate( '<YOUR_ACCOUNT_NUMBER>', '<YOUR_SORT_CODE>', function(err, result) {
  console.log( 'ERR', err );
  console.log( 'RESULT', JSON.parse( result ) );
});

```

