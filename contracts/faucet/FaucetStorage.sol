// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.5;

import "../interfaces/IFREE.sol";
import "../interfaces/IFMN.sol";


contract FaucetStorage {

    IFREE free;
    IFMN fmn;

    address public admin;
    address public coordinator;
    address public governance;

    bool initialized;
    bool paramsInitialized;

    uint8 constant CATEGORIES = 8;
    uint256 constant MAX_UINT256 = 2 ** 256 - 1;

    // Configurable parameters
    uint256 public subscriptionCost;
    uint256 public cooldownTime;
    uint256 public payoutThreshold;
    uint256 public payoutAmount;
    uint256 public hotWalletLimit;

    uint256 public subscribers;
    uint256 public winners;
    uint256 public claims;
    uint256 public claimsSinceLastWin;

    mapping(string => bool) public isPaused;

    mapping(address => bool) public isSubscribed;
    mapping(address => uint256) public previousEntry;
    mapping(address => uint256) public payoutStatus;
    mapping(address => address) public subscribedFor;

    mapping(uint8 => uint256) public categories;
    mapping(uint8 => uint256) public odds;

    mapping(string => uint256) public _uintStorage;
    mapping(string => address) public _addressStorage;
    mapping(string => bool) public _boolStorage;
    mapping(string => bytes32) public _bytes32Storage;

    /**
     * @notice Emitted whenever an address enters the FMN draw.
     *
     * @param entrant The address entering the FMN draw.
     * @param baseAddress The address who the claimant is entering for.
     * @param lottery The category determining the entrant's odds of success, this is determined by their FREE balance.
     *
     * @dev A listener for this event responds by rewarding FMN to the entrant if successful in the lottery category.
     */
    event Entry(address indexed entrant, address indexed baseAddress, uint8 indexed lottery);

    /**
     * @notice Emitted when an entry wins the lottery and the address is awarded a FMN.
     *
     * @param entrant The address who entered the FMN draw.
     * @param baseAddress The address that entrant is subscribed for.
     * @param lottery The category that the address entered into.
     * @param txHash The transaction hash of the "enter" function call.
     * @param blockHash The block hash of the "enter" function call.
     * @param claimsTaken The total number of claims since the previous win.
     */
    event Win(address indexed entrant, address indexed baseAddress, uint8 indexed lottery, bytes32 txHash, bytes32 blockHash, uint256 claimsTaken);
}
