// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/access/AccessControl.sol";
contract AuthenticationLayer is AccessControl{
    bytes32 public constant USER_ROLE = keccak256("USER");
    bytes32 public constant MINER_ROLE = keccak256("MINER");
    constructor ()  {
    grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    grantRole(MINER_ROLE , msg.sender);
    grantRole(USER_ROLE , msg.sender);
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

    modifier hasViewRole(){
        require(hasRole(USER_ROLE , msg.sender) || hasRole(MINER_ROLE , msg.sender) || hasRole(DEFAULT_ADMIN_ROLE , msg.sender) , "You dont have the required role");
        _;
    }

    modifier sendTransaction(){
        require(hasRole(MINER_ROLE , msg.sender) , "You dont have the required role");
        _;
        
    }

    function viewData() hasViewRole public  {
    }
}