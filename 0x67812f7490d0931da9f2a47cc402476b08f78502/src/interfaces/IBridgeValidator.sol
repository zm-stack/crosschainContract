// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.23;

/// @title Bridge Validator Interface
/// @dev Interface all Bridge Validators must follow
/// @author Zeropoint Labs
interface IBridgeValidator {

    //////////////////////////////////////////////////////////////
    //                           STRUCTS                        //
    //////////////////////////////////////////////////////////////

    struct ValidateTxDataArgs {
        bytes txData;
        uint64 srcChainId;
        uint64 dstChainId;
        uint64 liqDstChainId;
        bool deposit;
        address superform;
        address receiverAddress;
        address liqDataToken;
        address liqDataInterimToken;
    }

    //////////////////////////////////////////////////////////////
    //              EXTERNAL VIEW FUNCTIONS                     //
    //////////////////////////////////////////////////////////////

    /// @dev validates the receiver of the liquidity request
    /// @param txData_ is the txData of the cross chain deposit
    /// @param receiver_ is the address of the receiver to validate
    /// @return valid_ if the address is valid
    function validateReceiver(bytes calldata txData_, address receiver_) external pure returns (bool valid_);

    /// @dev validates the txData of a cross chain deposit
    /// @param args_ the txData arguments to validate in txData
    /// @return hasDstSwap if the txData contains a destination swap
    function validateTxData(ValidateTxDataArgs calldata args_) external view returns (bool hasDstSwap);

    /// @dev decodes the txData and returns the amount of input token on source
    /// @param txData_ is the txData of the cross chain deposit
    /// @param genericSwapDisallowed_ true if generic swaps are disallowed
    /// @return amount_ the amount expected
    function decodeAmountIn(
        bytes calldata txData_,
        bool genericSwapDisallowed_
    )
        external
        pure
        returns (uint256 amount_);

    /// @dev decodes neccesary information for processing swaps on the destination chain
    /// @param txData_ is the txData to be decoded
    /// @return token_ is the address of the token
    /// @return amount_ the amount expected
    function decodeDstSwap(bytes calldata txData_) external pure returns (address token_, uint256 amount_);

    /// @dev decodes the final output token address (for only direct chain actions!)
    /// @param txData_ is the txData to be decoded
    /// @return token_ the address of the token
    function decodeSwapOutputToken(bytes calldata txData_) external pure returns (address token_);
}
