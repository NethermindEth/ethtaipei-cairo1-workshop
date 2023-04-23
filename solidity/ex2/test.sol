// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

import "./callee.sol";

contract TestContract {
    address public owner;

    struct UserProperty {
        uint256 level;
    }

    mapping(address user => UserProperty userProperty) public userProperties;

    constructor(address _owner) {
        owner = _owner;
    }

    event NewLevel(address indexed user, uint256 level);
    event NewOwner(address indexed newOwner);
    error NotOwner();

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }

        _;
    }

    function changeOwner(address newOwner) external onlyOwner {
        owner = newOwner;
        emit NewOwner(newOwner);
    }

    // todo: add mapping
    function setLevel(address user, uint256 level) external onlyOwner {
        userProperties[user] = UserProperty({level: level});

        emit NewLevel(user, level);
    }

    // todo: call contract
    function getNumber(address targetAddress) public view returns (uint256) {
        return ICallee(targetAddress).getNumber();
    }
}
