// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/access/AccessControl.sol";
import './DataLayer.sol';
contract AuthenticationLayer is AccessControl{
    bytes32 public constant USER_ROLE = keccak256("USER");
    bytes32 public constant MINER_ROLE = keccak256("MINER");

    DataLayer dataLayer;
    constructor (address _dataLayer)  {
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _setupRole(MINER_ROLE , msg.sender);
    _setupRole(USER_ROLE , msg.sender);
    dataLayer = DataLayer(_dataLayer);
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

    modifier canAddUser(){
        require(hasRole(MINER_ROLE , msg.sender) , "You dont have the required role");
        _;

    }

    function viewData() hasViewRole public view returns(address  , uint , string memory , string memory , uint  , bool) {
        return dataLayer.viewData(msg.sender);
    }

    function addUser(uint phoneNumber , string calldata name , string calldata imeiNumber , uint aadharCardNumber ) isMiner external  {
        dataLayer.addUser( phoneNumber ,  name ,  imeiNumber ,  aadharCardNumber );
    }

    function blockUser(address _user) external isMiner{
        dataLayer.blockUser(_user);
    }

    function changeRouter(address newRouter) external isOwner{
        dataLayer.changeRouter(newRouter);
    }
}