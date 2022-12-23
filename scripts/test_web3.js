// "use strict";
// import Web3 from 'web3';

// const Web3 = require('web3');
// const web3 = new Web3();

console.log(window.ethereum);

if (window.ethereum) {
    console.log("You are connected");
}
else{
    console.log('Please Connect your browser to a wallet extension, if connected, check that it is enabled.')
}