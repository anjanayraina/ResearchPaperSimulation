// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;
import "@openzeppelin/contracts/access/AccessControl.sol";
contract DataLayer is AccessControl {
    address router;
    constructor(){
        grantRole(DEFAULT_ADMIN_ROLE , msg.sender);
    }
    function changeRouter(address _router) external {
        require(hasRole(DEFAULT_ADMIN_ROLE , msg.sender) , "You are not the owner");
        router = _router;
    }

   

    

}