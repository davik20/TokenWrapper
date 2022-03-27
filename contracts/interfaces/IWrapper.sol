pragma solidity ^0.8.0;

interface IWrapper {
    function wrap(uint256 _amount) external;

    function unwrap(uint256 _amount) external;
}
