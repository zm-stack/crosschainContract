pragma solidity ^0.8.0;

import "@layerzerolabs/solidity-examples/contracts/token/oft/v1/ProxyOFT.sol";

contract AntfarmTokenProxyOFT is ProxyOFT {
    constructor(address _lzEndpoint, address _token) ProxyOFT(_lzEndpoint, _token){}
}