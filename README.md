# node postcode anywere

[Postcode Anywhere](http://www.postcodeanywhere.co.uk/support/webservices.aspx) Web Service node.js wrapper

## Installation

```bash
npm install postcode-anywhere
```

## Usage

So far this module only supports the bank account validation service as thats all we've needed but we're looking to add more endpoints as we need them or people send in PRs

```javascript

var key = '<YOUR_API_KEY_OBTAINED_FROM_THE_POSTCODE_ANYWHERE>'

var gateway = new Gateway( key );

gateway.bankAccountValidationInteractiveValidate( '<YOUR_ACCOUNT_NUMBER>', '<YOUR_SORT_CODE>', function(err, result) {
  console.log( 'ERR', err );
  //result is a plain js object as shown in the Postcode Anywhere docs
  console.log( 'RESULT', result);
});

```

## Development

The only dev dependencies are `coffee-script` which should get installed when you run 'npm install'. The coffeescript is compiled down to javascript automatically before publishing using the 'prepublish' script in 'package.json'. coffeescript file and test files are deliberately left out of the package via '.npmignore' 
because no one likes needlessly big modules.

Contributions are welcome!

## License

MIT
