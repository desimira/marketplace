pragma solidity ^0.5.0;

import "./SharedStorage.sol";
import "../Marketplace/Ownable.sol";


contract OwnableUpgradeableImplementation is SharedStorage, Ownable {

    /**
    * @dev Initializes the contract and inits with the msg sender as an owner
    * account.
    */
    function init() public {
        require(owner == address(0), "Contract already has owner");
        owner = msg.sender;
    }

    event UpgradedContract(address indexed _newImpl);

    function upgradeImplementation(address payable _newImpl) public onlyOwner {
        contractImplementation = _newImpl;
        emit UpgradedContract(_newImpl);
    }

    function getImplementation() public view returns (address) {
        return contractImplementation;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}