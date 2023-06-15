pragma solidity 0.8.9;
import "@openzeppelin/contracts/access/AccessControl.sol";
contract AuthenticationLayer is AccessControl{

    constructor (address root)  {
    _setupRole(DEFAULT_ADMIN_ROLE, root);
    }

    modifier isOwner(){
        require(hasRole(DEFAULT_ADMIN_ROLE , msg.sender)  , "You dont have the required role");
        _;
    }
}