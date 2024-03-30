// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract TokenVesting is Ownable, ERC20, ReentrancyGuard {
    address public beneficiary;
    uint256 public constant INITIAL_SUPPLY = 1000000 * (10 ** 18); 
    uint256 public constant CLIFF_AMOUNT = 20000 * (10 ** 18); // Tokens released per minute
    uint256 public constant RELEASE_DURATION = 1 minutes; 
    uint256 public constant VESTING_DURATION = 6 minutes; // Vesting period
    uint256 public vestingStartTime;
    uint256 public constant TOTAL_TOKENS = 200000;

    constructor(
        address _beneficiary
    ) Ownable(msg.sender) ERC20("NDKToken", "NDK") {
        _mint(address(this), INITIAL_SUPPLY);
        beneficiary = _beneficiary;
        vestingStartTime = block.timestamp;
    }

    function release() external onlyOwner nonReentrant {
        require(block.timestamp >= vestingStartTime + VESTING_DURATION, "Vesting period has not ended yet");

        uint256 elapsedTime = (block.timestamp - vestingStartTime - VESTING_DURATION) / RELEASE_DURATION; // Elapsed time in minutes after vesting period
        uint256 releasedTokens = CLIFF_AMOUNT * elapsedTime;
        require(releasedTokens <= TOTAL_TOKENS, "All tokens have already vested");

        uint256 unreleasedTokens = TOTAL_TOKENS - releasedTokens;
        require(unreleasedTokens > 0, "No tokens left to release");

        _transfer(address(this), beneficiary, unreleasedTokens);
    }
}
