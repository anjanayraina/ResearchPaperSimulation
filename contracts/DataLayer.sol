// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/access/AccessControl.sol";
contract DataLayer is AccessControl {
    address router;
    mapping(address => User) userToAddress;
    constructor(){
        _setupRole(DEFAULT_ADMIN_ROLE , msg.sender);
    }

    modifier isRouter(){
        require(msg.sender == router , "The caller is not the Router");
        _;
    }

    struct User{
        address userAddress;
        uint phoneNumber;
        string name;
        string imeiNumber;
        uint aadharCardNumber;
        bool isBlocked;

    }
    function changeRouter(address _router) external isRouter{
        require(hasRole(DEFAULT_ADMIN_ROLE , msg.sender) , "You are not the owner");
        router = _router;
    }

    function addUser(uint phoneNumber , string calldata name , string calldata imeiNumber , uint aadharCardNumber ) external isRouter {
        require(userToAddress[tx.origin].userAddress == address(0) , "The user is already present");
        userToAddress[tx.origin] = User(tx.origin , phoneNumber ,  name ,  imeiNumber ,  aadharCardNumber , false);
    }

    function viewData(address userAddress) external view isRouter returns(address  , uint , string memory , string memory , uint  , bool){
        User memory user = userToAddress[userAddress];
        return (user.userAddress , user.phoneNumber , user.name , user.imeiNumber , user.aadharCardNumber , user.isBlocked);
    }

    function blockUser(address _userAddress) external isRouter {
        userToAddress[_userAddress].isBlocked = true;
    }

    function isUserBlocked(address _userAddress) external view isRouter returns(bool){
        return userToAddress[_userAddress].isBlocked;
    }


    

}