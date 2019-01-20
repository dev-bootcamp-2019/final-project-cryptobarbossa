var Web3 = require('web3');
var web3 = new Web3();
const walletAddress = 'INSERT_ADDRESS_HERE';
web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

web3.eth.getBalance(walletAddress)
.then(function (balance) {
    console.log(balance);
}).catch(function(e) {
    console.log(e);
});

