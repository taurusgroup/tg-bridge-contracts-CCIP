// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "openzeppelin-contracts/access/AccessControl.sol";


abstract contract AuthorizationModule is AccessControl{
    /**
    * @notice Can manage the different chain allowed by our bridge
    */
    bytes32 public constant BRIDGE_ALLOWLISTED_CHAIN_MANAGER_ROLE = keccak256("BRIDGE_ALLOWLISTED_CHAIN_MANAGER_ROLE");
    
    /**
    * @notice This role can transfers tokens through the bridge
    */
    bytes32 public constant BRIDGE_USER_ROLE = keccak256("BRIDGE_USER_ROLE");

    /**
    * @notice This role can transfers tokens through the bridge
    */
    bytes32 public constant BRIDGE_OPERATOR_ROLE = keccak256("BRIDGE_OPERATOR_ROLE");


    /**
    * @notice This role can deposit native tokens
    */
    bytes32 public constant BRIDGE_DEPOSITOR_ROLE = keccak256("BRIDGE_DEPOSITOR_ROLE");
    
    /*
    * @dev Returns `true` if `account` has been granted `role`.
    */
    function hasRole(
        bytes32 role,
        address account
    ) public view virtual override(AccessControl) returns (bool) {
        // The Default Admin has all roles
        if (AccessControl.hasRole(DEFAULT_ADMIN_ROLE, account)) {
            return true;
        }
        return AccessControl.hasRole(role, account);
    }
}