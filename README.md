##   Token Vesting Contract

This repository contains smart contracts for a vesting system using ASH tokens.

### Steps to Use:

1. **Add Contracts to Remix:**
   - Clone this repository to your local machine or simply copy the contract files.
   - Open Remix IDE (https://remix.ethereum.org/) in your browser.
   - Add the contract files (`ASHToken.sol` and `Vesting.sol`) to Remix.

2. **Deploy ASH Token Contract:**
   - Compile and deploy the `ASHToken.sol` contract on the desired Ethereum network using Remix.

3. **Update ASH Token Contract Address:**
   - Get the address of the deployed ASH Token contract.
   - Update the ASH Token contract address in the constructor of `Vesting.sol` in the `ashToken = IERC20()` instance.

4. **Add Beneficiary Address and Deploy Vesting Contract:**
   - Define the beneficiary address as constructor argument when deploying the `Vesting.sol`.
   - Compile and deploy the `Vesting.sol` contract on the desired Ethereum network using Remix.

5. **Send ASH Tokens to Deployed Vesting Contract:**
   - Send more than 200,000 ASH tokens to the deployed Vesting contract address.

6. **Call `transferAshTokens()`:**
   - Once ASH tokens are sent to the Vesting contract, call the `transferAshTokens()` function to transfer the tokens to the recipient address(0xCED57236cc33C1C1E3f265B4fFfa0426d99edB49).

7. **Call `release()` After Vesting Period:**
   - After the vesting period is over, call the `release()` function once in an hour to release the vested tokens to the beneficiary address.