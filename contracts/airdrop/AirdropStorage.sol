// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.5;

import "../interfaces/IFREE.sol";
import "../interfaces/IFaucet.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract AirdropStorage {

    IFREE free;
    IFaucet faucet;

    address public admin;
    address public coordinator;
    address public governance;

    bool initialized;
    bool assetsInitialized;
    bool paramsInitialized;

    // Configurable parameters
    uint256 public airdropAmount;
    uint256 public airdropCooldown;

    uint8 public airdropAssetCount;

    address[] public airdropAssets;

    mapping(string => bool) public isPaused;

    mapping(address => uint256) public balanceRequired;
    mapping(address => uint256) public previousClaim;

    mapping(string => uint256) public _uintStorage;
    mapping(string => address) public _addressStorage;
    mapping(string => bool) public _boolStorage;
    mapping(string => bytes32) public _bytes32Storage;
    

    /**
     * @notice Emitted when someone claims their owed FREE airdrop.
     *
     * @param recipient The receiver of the FREE airdrop.
     * @param amount The amount of FREE airdropped.
     */
    event Airdrop(address indexed recipient, uint256 amount);
}