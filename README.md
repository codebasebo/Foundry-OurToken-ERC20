# OurToken ERC20 Token

## Overview

This Solidity contract implements an ERC20 token named **OurToken (OT)** using OpenZeppelin's ERC20 standard. Upon deployment, the specified initial supply of tokens is minted to the deployer's address.

### Code Explanation

- The contract inherits from the OpenZeppelin `ERC20` contract.
- The constructor takes an `initialSupply` parameter and mints that amount of tokens to the deployer's address using `_mint`.

## Project Structure

- **contracts/OurToken.sol**: Contains the ERC20 token implementation.
- **script/DeployOurToken.s.sol**: The deployment script for the contract.
- **test/OurTokenTest.sol**: Test suite for the token functionality.
