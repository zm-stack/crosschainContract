// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

interface IEthenaMintingEvents {
  /// @notice Event emitted when USDe is minted
  event Mint(
    address minter,
    address benefactor,
    address beneficiary,
    address indexed collateral_asset,
    uint256 indexed collateral_amount,
    uint256 indexed usde_amount
  );

  /// @notice Event emitted when funds are redeemed
  event Redeem(
    address redeemer,
    address benefactor,
    address beneficiary,
    address indexed collateral_asset,
    uint256 indexed collateral_amount,
    uint256 indexed usde_amount
  );

  /// @notice Event emitted when custody wallet is added
  event CustodyWalletAdded(address wallet);

  /// @notice Event emitted when a custody wallet is removed
  event CustodyWalletRemoved(address wallet);

  /// @notice Event emitted when a supported asset is added
  event AssetAdded(address indexed asset);

  /// @notice Event emitted when a supported asset is removed
  event AssetRemoved(address indexed asset);

  /// @notice Event emitted when assets are moved to custody provider wallet
  event CustodyTransfer(address indexed wallet, address indexed asset, uint256 amount);

  /// @notice Event emitted when USDe is set
  event USDeSet(address indexed USDe);

  /// @notice Event emitted when USDe is changed
  event USDeChanged(address indexed oldUSDe, address indexed newUSDe);

  /// @notice Event emitted when the max mint per block is changed
  event MaxMintPerBlockChanged(uint256 indexed oldMaxMintPerBlock, uint256 indexed newMaxMintPerBlock);

  /// @notice Event emitted when the max redeem per block is changed
  event MaxRedeemPerBlockChanged(uint256 indexed oldMaxRedeemPerBlock, uint256 indexed newMaxRedeemPerBlock);
}
