# ETHgram Dapp: Allowing Ethereum users to initiate a paid action with a virtual Agent that generates Instagram engagement with human like feautures.

This visual agent is a WORK-IN-PROGRESS Visual AI. It depends on Ethereum for fueling its activities. It is built to mimic human online behaviour.
The core of the agent is written in C++ and is currently running live on remote servers.

The Core of the project has been worked at for 8 months. In the future it will develop more machine learning implementations to allow for adaptive behaviour.

This project is intented to serve the ETH community with a working virtual agent to help automate certain activities. Currently it runs efficiently on Instagram (a social media platform). The aim is to expand the service to multiple platforms where it can autonomously grow and fund its activities via user demand.

## Dependencies for the Front-end of the project

Install these prerequisites to follow along with the tutorial. See free video tutorial or a full explanation of each prerequisite.

- NPM: https://nodejs.org
- Truffle: https://github.com/trufflesuite/truffle
- Ganache: http://truffleframework.com/ganache/
- Metamask: https://metamask.io/

## Step 1. Clone the project

`git clone https://github.com/cryptobarbossa/ethgram`

## Step 2. Install dependencies (truffle included in package so no need to install it globally)
## Run truffle like -> $ ./node_modules/.bin/truffle
```
$ cd ethgram
$ npm install
$ npm install web3@1.0.0-beta.37
```

## Step 3. Start Ganache

Open the Ganache GUI.

## Step 4. Compile & Deploy Smart Contract

`$ truffle migrate --reset`
You must migrate the smart contract each time your restart ganache.

## Step 5. Configure Metamask

See free video tutorial for full explanation of these steps:

- Unlock Metamask
- Connect metamask to your local Etherum blockchain provided by Ganache.
- Import an account provided by ganache.

## Step 6. Run the Front End Application

`$ npm run dev`
Visit this URL in your browser: http://localhost:3000
