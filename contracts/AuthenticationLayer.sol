// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/access/AccessControl.sol";
contract AuthenticationLayer is AccessControl{
    bytes32 public constant USER_ROLE = keccak256("USER");
    bytes32 public constant MINER_ROLE = keccak256("MINER");
    constructor (address root)  {
    _setupRole(DEFAULT_ADMIN_ROLE, root);
    }

    modifier isOwner(){
        require(hasRole(DEFAULT_ADMIN_ROLE , msg.sender)  , "You dont have the required role");
        _;
    }

    modifier isMiner(){
        require(hasRole(MINER_ROLE , msg.sender)  , "You dont have the required role");
        _;
    } 

    modifier isUser(){
        require(hasRole(USER_ROLE , msg.sender)  , "You dont have the required role");
        _;
    } 
}