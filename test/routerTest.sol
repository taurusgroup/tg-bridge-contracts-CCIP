// SPDX-License-Identifier: MPL-2.0
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "./HelperContract.sol";
import "./utils/router.sol";
import {IERC20} from "ccip-v08/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import {ERC20Mock} from "openzeppelin-contracts/mocks/token/ERC20Mock.sol";
import {Client} from "ccip/libraries/Client.sol";
contract RouterTest is HelperContract {
    struct FEE_PAYMENT_TOKEN {
        uint256 id;
        string label;
        bool isActivate;
        IERC20 tokenAddress;
    }
    ERC20Mock private erc20;
    
    uint64 private AVALANCHE_SELECTOR = 6433500567565415381;
    IERC20 private AVALANCHE_USDC = IERC20(0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E);
    MockCCIPRouter private ROUTER;
     // Arrange
    function setUp() public {
        erc20 = new ERC20Mock();
        address[] memory supportedTokens = new address[](1);
        supportedTokens[0] = address(erc20);
        ROUTER = new MockCCIPRouter( supportedTokens );

        // Deploy CCIP Sender
        CCIPSENDER_CONTRACT = new CCIPSender(
            CCIPSENDER_ADMIN,
            address(ROUTER),
            ZERO_ADDRESS
        );
    }
    /*********** Get Router ***********/
    function testCanGetRouter() public  view {
        address router = CCIPSENDER_CONTRACT.getRouter();
        assertEq(router,  address(ROUTER)); 
    }

    function testCanGetSupportedTokens() public  view {
        address[] memory tokens = CCIPSENDER_CONTRACT.getSupportedTokens(0);
        assertEq(tokens[0], address(erc20)); 
    }
}