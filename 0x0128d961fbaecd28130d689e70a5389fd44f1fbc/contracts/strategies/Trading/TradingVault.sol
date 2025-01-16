// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.18;

import { BaseTransfersNative } from "../../base/BaseTransfersNative/v1/BaseTransfersNative.sol";
import { BaseSimpleSwap, CoreSimpleSwapConfig } from "../../base/BaseSimpleSwap.sol";
import { BaseAccessControl, CoreAccessControlConfig } from "../../base/BaseAccessControl.sol";
import { BaseFees, CoreFeesConfig } from "../../base/BaseFees.sol";
import { CoreMulticall } from "../../core/CoreMulticall/v1/CoreMulticall.sol";
import {
    WETH9NativeWrapper,
    BaseNativeWrapperConfig
} from "../../modules/native-asset-wrappers/WETH9NativeWrapper.sol";
import { BaseNativeWrapperConfig } from "../../base/BaseNativeWrapper/v1/BaseNativeWrapper.sol";
import { BasePermissionedExecution } from "../../base/BasePermissionedExecution/BasePermissionedExecution.sol";

contract TradingVault is
    WETH9NativeWrapper,
    BaseTransfersNative,
    BaseSimpleSwap,
    BasePermissionedExecution,
    CoreMulticall
{
    constructor(
        BaseNativeWrapperConfig memory baseNativeWrapperConfig,
        CoreAccessControlConfig memory coreAccessControlConfig,
        CoreSimpleSwapConfig memory coreSimpleSwapConfig,
        CoreFeesConfig memory coreFeesConfig
    )
        WETH9NativeWrapper(baseNativeWrapperConfig)
        BaseAccessControl(coreAccessControlConfig)
        BaseSimpleSwap(coreSimpleSwapConfig)
        BaseFees(coreFeesConfig)
    {}
}
