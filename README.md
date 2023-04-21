# EthTaipei "Warping" Solidity to Cairo1 Workshop
## Prerequisite
- In order to declare, deploy and interact with your contract, you will need some goerli ETH. If you don't have already, you will need to get some goerli Eth from a faucet.

### Goerli Eth on Starknet testnet
1. Get goerli Eth on Ethereum Goerli. My favourite go-to will be 
    - https://goerli-faucet.pk910.de/
    - https://goerlifaucet.com/
    Unfortunately, goerli ETH is getting rarer
2. Get a starknet wallet extension and setup your contract
    - https://braavos.app/download-braavos-wallet/
    - https://www.argent.xyz/argent-x/
3. Use Starkgate to bridge your goerli testnet token to L2
    - https://goerli.starkgate.starknet.io/
4. Check that your account is funded using https://goerli.voyager.online/

### Install Starknet CLI
- Follow instructions [here](https://docs.starknet.io/documentation/getting_started/environment_setup/)
- Note, for Windows users, the recommendation will be to use WSL2

### Setup local Starknet account (for declaring and deploying)
- Setup environment according to https://docs.starknet.io/documentation/getting_started/environment_setup/
- And then, deploy an account https://docs.starknet.io/documentation/getting_started/environment_setup/ 
- Fund this deployed account from your wallet which just got your goerli ETH from