var Web3 = require('web3');
var web3 = new Web3();
const walletAddress = '0x45539C89A9836399C45C3a8c0F01e8ae4EB43dFD';
web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

web3.eth.getBalance(walletAddress)
.then(function (balance) {
    console.log(balance);
}).catch(function(e) {
    console.log(e);
});

