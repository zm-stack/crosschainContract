// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import './IEthenaMintingEvents.sol';

interface IEthenaMinting is IEthenaMintingEvents {
  enum Role {
    Minter,
    Redeemer
  }

  enum OrderType {
    MINT,
    REDEEM
  }

  enum SignatureType {
    EIP712
  }

  struct Signature {
    SignatureType signature_type;
    bytes signature_bytes;
  }

  struct Route {
    address[] addresses;
    uint256[] ratios;
  }

  struct Order {
    OrderType order_type;
    uint256 expiry;
    uint256 nonce;
    address benefactor;
    address beneficiary;
    address collateral_asset;
    uint256 collateral_amount;
    uint256 usde_amount;
  }

  error Duplicate();
  error InvalidAddress();
  error InvalidUSDeAddress();
  error InvalidZeroAddress();
  error InvalidAssetAddress();
  error InvalidOrder();
  error InvalidAffirmedAmount();
  error InvalidAmount();
  error InvalidRoute();
  error UnsupportedAsset();
  error NoAssetsProvided();
  error InvalidSignature();
  error InvalidSignatureLength();
  error SignatureExpired();
  error TransferFailed();
  error MaxMintPerBlockExceeded();
  error MaxRedeemPerBlockExceeded();

  function hashOrder(Order memory order) external view returns (bytes32);

  function verifyOrder(Order memory order, Signature memory signature) external view returns (bool, bytes32);

  function verifyRoute(Route memory route, OrderType order_type) external view returns (bool);

  function mint(Order memory order, Route memory route, Signature memory signature) external;

  function redeem(Order memory order, Signature memory signature) external;

}
