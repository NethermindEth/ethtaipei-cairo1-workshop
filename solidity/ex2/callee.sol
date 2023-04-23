// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

interface ICallee {
    function getNumber() external view returns (uint256);
}

contract Callee is ICallee {
    function getNumber() public pure returns (uint256) {
        return 1234;
    }
}
