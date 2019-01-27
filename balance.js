var Web3 = require('web3');
var web3 = new Web3();

// Rinkeby ETH_AGENT_1 @ litecoin_official
// const walletAddress = '0xffCD2130cb3DF4d55Df612BE664143EFcD0ff6B4';
// web3.setProvider(new web3.providers.HttpProvider('https://rinkeby.infura.io/'));

// Rinkeby ETH_AGENT_2 @ monerocurrency
const walletAddress = '0x80479A14AD36607662A2631fB06F8ABe38F5126a';
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
