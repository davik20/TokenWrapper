pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../interfaces/IERC20Mintable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WTCG is ERC20, IERC20Mintable, Ownable {
    address public allowedMinter;

    modifier isAllowedMinter() {
        require(msg.sender == allowedMinter, "You are not allowed to mint");
        _;
    }

    constructor() ERC20("WTCG", "Wrapped The Creators Galaxy") {}

    function mint(address _to, uint256 _amount)
        external
        override
        isAllowedMinter
    {
        _mint(_to, _amount);
    }

    function burn(address _from, uint256 _amount)
        external
        override
        isAllowedMinter
    {
        _burn(_from, _amount);
    }

    function setAllowedMinter(address _minterAddress) public onlyOwner {
        allowedMinter = _minterAddress;
    }
}
