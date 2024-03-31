// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import  "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title ASHToken
 * @dev An ERC20 token contract with additional functionality.
 */
contract ASHToken is ERC20, Ownable {
    constructor() ERC20("ASHToken", "ASH") Ownable(msg.sender) {
        // Mint initial supply to the contract deployer
        _mint(msg.sender, 10000000 * 10**18);
    }
}