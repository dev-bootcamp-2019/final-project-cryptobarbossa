var Web3 = require('web3');
var web3 = new Web3();

// Rinkeby ETH_AGENT_1 @ litecoin_official
// const walletAddress = '0xc01Af5741c52eA8dDa9166030a104f86CF181622';
// web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Rinkeby ETH_AGENT_2 @ monerocurrency
const walletAddress = '0x7c2968a3402641fafcA01d11E3824ce10460ABCc';
web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Rinkeby ETH_AGENT_3 @ bitcoin_page
// const walletAddress = '0x58C57FB44cC4AF39C951DB2E06c1C6081Bd6efC8';
// web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Used for local testing only
// const walletAddress = '0xE5d210b3EC941C71C20096Dde60eE0e6dB74C0cC';
// web3.setProvider(new web3.providers.HttpProvider('http://127.0.0.1:7545'));


web3.eth.getBalance(walletAddress)
.then(function (balance) {
    console.log(balance);
}).catch(function(e) {
    console.log(e);
});
