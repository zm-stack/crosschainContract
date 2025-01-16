// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @dev contains all the common struct and enums used for data communication between chains.

/// @dev There are two transaction types in Superform Protocol
enum TransactionType {
    DEPOSIT,
    WITHDRAW
}

/// @dev Message types can be INIT, RETURN (for successful Deposits) and FAIL (for failed withdraws)
enum CallbackType {
    INIT,
    RETURN,
    FAIL
}

/// @dev Payloads are stored, updated (deposits) or processed (finalized)
enum PayloadState {
    STORED,
    UPDATED,
    PROCESSED
}

/// @dev contains all the common struct used for interchain token transfers.
struct LiqRequest {
    /// @dev generated data
    bytes txData;
    /// @dev input token for deposits, desired output token on target liqDstChainId for withdraws. Must be set for
    /// txData to be updated on destination for withdraws
    address token;
    /// @dev intermediary token on destination. Relevant for xChain deposits where a destination swap is needed for
    /// validation purposes
    address interimToken;
    /// @dev what bridge to use to move tokens
    uint8 bridgeId;
    /// @dev dstChainId = liqDstchainId for deposits. For withdraws it is the target chain id for where the underlying
    /// is to be delivered
    uint64 liqDstChainId;
    /// @dev currently this amount is used as msg.value in the txData call.
    uint256 nativeAmount;
}

/// @dev main struct that holds required multi vault data for an action
struct MultiVaultSFData {
    // superformids must have same destination. Can have different underlyings
    uint256[] superformIds;
    uint256[] amounts; // on deposits, amount of token to deposit on dst, on withdrawals, superpositions to burn
    uint256[] outputAmounts; // on deposits, amount of shares to receive, on withdrawals, amount of assets to receive
    uint256[] maxSlippages;
    LiqRequest[] liqRequests; // if length = 1; amount = sum(amounts) | else  amounts must match the amounts being sent
    bytes permit2data;
    bool[] hasDstSwaps;
    bool[] retain4626s; // if true, we don't mint SuperPositions, and send the 4626 back to the user instead
    address receiverAddress;
    /// this address must always be an EOA otherwise funds may be lost
    address receiverAddressSP;
    /// this address can be a EOA or a contract that implements onERC1155Receiver. must always be set for deposits
    bytes extraFormData; // extraFormData
}

/// @dev main struct that holds required single vault data for an action
struct SingleVaultSFData {
    // superformids must have same destination. Can have different underlyings
    uint256 superformId;
    uint256 amount;
    uint256 outputAmount; // on deposits, amount of shares to receive, on withdrawals, amount of assets to receive
    uint256 maxSlippage;
    LiqRequest liqRequest; // if length = 1; amount = sum(amounts)| else  amounts must match the amounts being sent
    bytes permit2data;
    bool hasDstSwap;
    bool retain4626; // if true, we don't mint SuperPositions, and send the 4626 back to the user instead
    address receiverAddress;
    /// this address must always be an EOA otherwise funds may be lost
    address receiverAddressSP;
    /// this address can be a EOA or a contract that implements onERC1155Receiver. must always be set for deposits
    bytes extraFormData; // extraFormData
}

/// @dev overarching struct for multiDst requests with multi vaults
struct MultiDstMultiVaultStateReq {
    uint8[][] ambIds;
    uint64[] dstChainIds;
    MultiVaultSFData[] superformsData;
}

/// @dev overarching struct for single cross chain requests with multi vaults
struct SingleXChainMultiVaultStateReq {
    uint8[] ambIds;
    uint64 dstChainId;
    MultiVaultSFData superformsData;
}

/// @dev overarching struct for multiDst requests with single vaults
struct MultiDstSingleVaultStateReq {
    uint8[][] ambIds;
    uint64[] dstChainIds;
    SingleVaultSFData[] superformsData;
}

/// @dev overarching struct for single cross chain requests with single vaults
struct SingleXChainSingleVaultStateReq {
    uint8[] ambIds;
    uint64 dstChainId;
    SingleVaultSFData superformData;
}

/// @dev overarching struct for single direct chain requests with single vaults
struct SingleDirectSingleVaultStateReq {
    SingleVaultSFData superformData;
}

/// @dev overarching struct for single direct chain requests with multi vaults
struct SingleDirectMultiVaultStateReq {
    MultiVaultSFData superformData;
}

/// @dev struct for SuperRouter with re-arranged data for the message (contains the payloadId)
/// @dev realize that receiverAddressSP is not passed, only needed on source chain to mint
struct InitMultiVaultData {
    uint256 payloadId;
    uint256[] superformIds;
    uint256[] amounts;
    uint256[] outputAmounts;
    uint256[] maxSlippages;
    LiqRequest[] liqData;
    bool[] hasDstSwaps;
    bool[] retain4626s;
    address receiverAddress;
    bytes extraFormData;
}

/// @dev struct for SuperRouter with re-arranged data for the message (contains the payloadId)
struct InitSingleVaultData {
    uint256 payloadId;
    uint256 superformId;
    uint256 amount;
    uint256 outputAmount;
    uint256 maxSlippage;
    LiqRequest liqData;
    bool hasDstSwap;
    bool retain4626;
    address receiverAddress;
    bytes extraFormData;
}

/// @dev struct for Emergency Queue
struct QueuedWithdrawal {
    address receiverAddress;
    uint256 superformId;
    uint256 amount;
    uint256 srcPayloadId;
    bool isProcessed;
}

/// @dev all statuses of the timelock payload
enum TimelockStatus {
    UNAVAILABLE,
    PENDING,
    PROCESSED
}

/// @dev holds information about the timelock payload
struct TimelockPayload {
    uint8 isXChain;
    uint64 srcChainId;
    uint256 lockedTill;
    InitSingleVaultData data;
    TimelockStatus status;
}

/// @dev struct that contains the type of transaction, callback flags and other identification, as well as the vaults
/// data in params
struct AMBMessage {
    uint256 txInfo; // tight packing of  TransactionType txType,  CallbackType flag  if multi/single vault, registry id,
        // srcSender and srcChainId
    bytes params; // decoding txInfo will point to the right datatype of params. Refer PayloadHelper.sol
}

/// @dev struct that contains the information required for broadcasting changes
struct BroadcastMessage {
    bytes target;
    bytes32 messageType;
    bytes message;
}

/// @dev struct that contains info on returned data from destination
struct ReturnMultiData {
    uint256 payloadId;
    uint256[] superformIds;
    uint256[] amounts;
}

/// @dev struct that contains info on returned data from destination
struct ReturnSingleData {
    uint256 payloadId;
    uint256 superformId;
    uint256 amount;
}

/// @dev struct that contains the data on the fees to pay to the AMBs
struct AMBExtraData {
    uint256[] gasPerAMB;
    bytes[] extraDataPerAMB;
}

/// @dev struct that contains the data on the fees to pay to the AMBs on broadcasts
struct BroadCastAMBExtraData {
    uint256[] gasPerDst;
    bytes[] extraDataPerDst;
}
