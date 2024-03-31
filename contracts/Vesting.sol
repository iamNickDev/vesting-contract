// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import  "@openzeppelin/contracts/access/Ownable.sol";
import  "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title TokenVesting
 * @dev A contract for token vesting with additional functionality.
 */
contract TokenVesting is Ownable, ERC20, ReentrancyGuard {
    IERC20 public ashToken; // The ASH token contract
    address public beneficiary; // Address of the beneficiary
    address public constant ASH_RECIPIENT = 0xCED57236cc33C1C1E3f265B4fFfa0426d99edB49;
    uint256 public constant ASH_AMOUNT = 200000 * 10**18; // Amount of ASH tokens 200000000000000000000000
    uint256 public constant INITIAL_SUPPLY = 100000 * 10**18; // Initial token supply 100000000000000000000000
    uint256 public constant CLIFF_AMOUNT = 20000 * 10**18; // Tokens released per hour 20000000000000000000000
    uint256 public constant RELEASE_DURATION = 1 hours; // Duration between releases
    uint256 public constant VESTING_DURATION = 6 hours; // Vesting period
    uint256 public vestingStartTime; // Start time of vesting
    uint256 public releasedTokens; // Total tokens released

    constructor(address _beneficiary) ERC20("NDKToken", "NDK") {
        _mint(address(this), INITIAL_SUPPLY);
        beneficiary = _beneficiary;
        vestingStartTime = block.timestamp;
        releasedTokens = 0;
        ashToken = IERC20(0x6f8257AAFb38BBB0142929dd274d48f6C1744f5F);
    }

    /**
     * @dev Transfer ASH tokens to the specified recipient.
     */
    function transferAshTokens() public onlyOwner nonReentrant {
        ashToken.transfer(ASH_RECIPIENT, ASH_AMOUNT);
    }

    /**
     * @dev Release vested tokens to the beneficiary.
     */
    function release() external onlyOwner nonReentrant {
        require(
            block.timestamp >= vestingStartTime + VESTING_DURATION,
            "Vesting period has not ended yet"
        );

        uint256 elapsedTime = (block.timestamp -
            vestingStartTime -
            VESTING_DURATION) / RELEASE_DURATION; // Elapsed time in hours after vesting period
        uint256 tokensToRelease = CLIFF_AMOUNT * elapsedTime;
        require(tokensToRelease > releasedTokens, "No tokens left to release");

        uint256 newTokens = tokensToRelease - releasedTokens;
        releasedTokens = tokensToRelease;

        _transfer(address(this), beneficiary, newTokens);
    }
}
