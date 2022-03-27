pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IERC20Mintable.sol";
import "./interfaces/IWrapper.sol";

contract Wrapper is IWrapper {
    IERC20Mintable WTCG;
    IERC20 TCG;

    constructor(address _tcgAddress, address _wtcgAddress) {
        WTCG = IERC20Mintable(_wtcgAddress);
        TCG = IERC20(_tcgAddress);
    }

    // WTCG is minted one to one for every TCG wrapped
    function wrap(uint256 _amount) external override {
        require(
            TCG.balanceOf(msg.sender) >= _amount,
            "Error: Your balance is not enough"
        );
        require(
            TCG.allowance(msg.sender, address(this)) >= _amount,
            "Error: Allowance not enough"
        );

        // transfer TCG into contract
        TCG.transferFrom(msg.sender, address(this), _amount);
        // mint Wrapped TCG to msg.sender
        WTCG.mint(msg.sender, _amount);
    }

    // WTCG is burned and TCG is sent to msg.sender, one to one ratio
    function unwrap(uint256 _amount) external override {
        require(
            WTCG.balanceOf(msg.sender) >= _amount,
            "Error: Your balance is not enough"
        );
        require(
            WTCG.allowance(msg.sender, address(this)) >= _amount,
            "Error: Allowance not enough"
        );
        // burn WTCG
        WTCG.burn(msg.sender, _amount);
        // burn Wrapped WTC
        require(
            TCG.balanceOf(address(this)) >= _amount,
            "Error: Contract TCG Balance is not enough"
        );
        TCG.transfer(msg.sender, _amount);
    }
}
