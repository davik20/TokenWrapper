pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TCG is ERC20 {
    constructor() ERC20("TCG", "The Creators Galaxy") {
        _mint(msg.sender, 1000000000000000000000000000);
    }
}
