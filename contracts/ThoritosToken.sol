// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ThoritosToken is ERC20, ERC20Burnable, Ownable(msg.sender) {

    uint256 public constant initialSupply = 100000 * (10**8);

    struct Lock {
        uint256 amount;
        uint256 releaseTime;
    }

    mapping(address => Lock[]) private _locks;

    constructor() ERC20("Thoritos", "THOR") {
        _mint(msg.sender, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function lockTokens(
        address beneficiary,
        uint256 amount,
        uint256 releaseTime
    ) external onlyOwner {
        require(
            releaseTime > block.timestamp,
            "Release time must be in the future"
        );
        _locks[beneficiary].push(Lock(amount, releaseTime));
        _transfer(msg.sender, address(this), amount);
    }

    function withdrawLockedTokens() external {
        uint256 unlockedAmount = 0;
        Lock[] storage locks = _locks[msg.sender];

        for (uint256 i = 0; i < locks.length; i++) {
            if (
                block.timestamp >= locks[i].releaseTime && locks[i].amount > 0
            ) {
                unlockedAmount += locks[i].amount;
                locks[i].amount = 0;
            }
        }

        require(unlockedAmount > 0, "No tokens available for withdrawal");
        _transfer(address(this), msg.sender, unlockedAmount);
    }

    function getLockedTokens(address account)
        external
        view
        returns (uint256 totalAmount)
    {
        Lock[] storage locks = _locks[account];
        for (uint256 i = 0; i < locks.length; i++) {
            totalAmount += locks[i].amount;
        }
    }
}
