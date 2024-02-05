// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {DeployOurToken} from "script/DeployOurToken.s.sol";
import {OurToken} from "src/OurToken.sol";

contract DeployOurTokenTest is Test {
    DeployOurToken deployOurToken;
    error expectRevert();

    function setUp() public {
        deployOurToken = new DeployOurToken();
    }

    function testInitialSupply() public {
        OurToken token = deployOurToken.run();
        assertEq(token.totalSupply(), 1000000 ether);
    }

    function testPrivateKeyAssignmentOnChainID() public {
        // Set the chain ID to simulate a non-local blockchain environment
        block.chainid == 31337;
        OurToken token = deployOurToken.run();
        // Assert that the private key is set to the default value
        assertEq(
            deployOurToken.deployerKey(),
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );
    }

    function testPrivateKeyAssignmentOnLocalChain() public {
        // Set the chain ID to simulate a local blockchain environment
        block.chainid == 31337;
        OurToken token = deployOurToken.run();
        // Assert that the private key is set to the default value
        assertEq(
            deployOurToken.deployerKey(),
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );
    }

    function testContractDeployment() public {
        OurToken token = deployOurToken.run();
        assertTrue(address(token) != address(0)); // Ensure the contract address is valid
    }
}
