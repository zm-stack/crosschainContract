// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.22;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { OFT } from "@layerzerolabs/lz-evm-oapp-v2/contracts/oft/OFT.sol";

contract LzOFT is OFT {
    constructor(
        string memory _name,
        string memory _symbol,
        address _lzEndpoint,
        address _delegate
    ) OFT(_name, _symbol, _lzEndpoint, _delegate) Ownable(_delegate) {}
    
	// @dev Sets an implicit cap on the amount of tokens, over uint64.max() will need some sort of outbound cap / totalSupply cap
	// Lowest common decimal denominator between chains.
	// Defaults to 6 decimal places to provide up to 18,446,744,073,709.551615 units (max uint64).
	// For tokens exceeding this totalSupply(), they will need to override the sharedDecimals function with something smaller.
	// ie. 4 sharedDecimals would be 1,844,674,407,370,955.1615
	function sharedDecimals() public view virtual override returns (uint8) {
	    return 4;
	}
}
