var Web3 = require('web3');
var web3 = new Web3();

// Rinkeby ETH_AGENT_1 @ litecoin_official
// const walletAddress = '0xc01Af5741c52eA8dDa9166030a104f86CF181622';
// web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Rinkeby ETH_AGENT_2 @ monerocurrency
// const walletAddress = '0x7c2968a3402641fafcA01d11E3824ce10460ABCc';
// web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Rinkeby ETH_AGENT_3 @ bitcoin_page
// const walletAddress = '0x01D563609e1fA074CD1dE7039D5D29d4F1A8d9dC';
// web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Rinkeby ETH_AGENT_4 @ loloapparel
const walletAddress = '0x06e1BEEc1AA0Cb4F843Edc49E4301611671fDD84';
web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));


// Used for local testing only
// const walletAddress = '0xE5d210b3EC941C71C20096Dde60eE0e6dB74C0cC';
// web3.setProvider(new web3.providers.HttpProvider('http://127.0.0.1:7545'));


web3.eth.getBalance(walletAddress)
.then(function (balance) {
    console.log(balance);
}).catch(function(e) {
    console.log(e);
});
