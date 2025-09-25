// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import "forge-std/console.sol";
import "forge-std/console2.sol";
import {MyToken} from "../src/MyToken.sol";

// forge test --match-contract MyTokenTest
contract MyTokenTest is Test {
    MyToken public nft;
    string constant name = "My NFT";

    function setUp() public {
        nft = new MyToken(address(this), name);
    }

    // forge test --match-test test_Name
    function test_Name() public view {
        string memory _name = nft.name();
        assertEq(name, _name);

        console.log(_name);
    }

    // forge test --match-test test_Symbol
    function test_Symbol() public view {
        string memory symbol = nft.symbol();
        assertNotEq("23", symbol);
    }

    // forge test --match-test test_Mint
    function test_Mint() public {
        address receiver = address(0x01);

        nft.safeMint(receiver, "https");
        nft.safeMint(receiver, "https");
        nft.safeMint(receiver, "https");
        nft.safeMint(receiver, "https");

        uint256 balance = nft.balanceOf(receiver);

        assertEq(balance, 4);

        address owner = nft.ownerOf(0);
        assertEq(owner, receiver);
        owner = nft.ownerOf(1);
        assertEq(owner, receiver);
        owner = nft.ownerOf(3);
        assertEq(owner, receiver);

        vm.startPrank(receiver);
        nft.transferFrom(receiver, address(this), 0);
        nft.transferFrom(receiver, address(this), 1);
        vm.stopPrank();

        balance = nft.balanceOf(address(this));
        assertEq(balance, 2);
        owner = nft.ownerOf(0);
        assertEq(owner, address(this));
        owner = nft.ownerOf(1);
        assertEq(owner, address(this));
    }

    // forge test --match-test test_Fork --fork-url https://ethereum.public.blockpi.network/v1/rpc/public
    function test_Fork() public {
        address USDT = 0xdAC17F958D2ee523a2206206994597C13D831ec7;

        bytes32 balance = vm.load(
            USDT, keccak256(abi.encodePacked(uint256(uint160(0x4945cE2d1B5BD904CAc839b7FDAbAfd19Cab982b)), uint256(2)))
        );

        console.log(uint256(balance));
        console.logBytes32(vm.load(USDT, 0));
        console.log(uint256(vm.load(USDT, bytes32(uint256(1)))));
        console.logBytes32(vm.load(USDT, bytes32(uint256(2))));
    }
}
