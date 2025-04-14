// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { IMitosisVault } from '@protocol/interfaces/branch/IMitosisVault.sol';
import { IMitosisVaultEOL } from '@protocol/interfaces/branch/IMitosisVaultEOL.sol';
import { IMitosisVaultMatrix } from '@protocol/interfaces/branch/IMitosisVaultMatrix.sol';

import { IStubInspector } from '@stub/interface/IStubInspector.sol';
import { IStubManager } from '@stub/interface/IStubManager.sol';

// Use remappings

library LibStubMitosisVault {
  function _tom(address stub) private pure returns (IStubManager) {
    return IStubManager(stub);
  }

  function _toi(address stub) private pure returns (IStubInspector) {
    return IStubInspector(stub);
  }

  function initStubMitosisVault(address stub) internal {
    // Register IMitosisVault view functions
    _tom(stub).regF(IMitosisVault.isAssetInitialized.selector, false, 'isAssetInitialized');
    _tom(stub).regF(IMitosisVault.entrypoint.selector, false, 'entrypoint');

    // Register IMitosisVault mutative functions
    _tom(stub).regF(IMitosisVault.initializeAsset.selector, true, 'initializeAsset');
    _tom(stub).regF(IMitosisVault.deposit.selector, true, 'deposit');
    _tom(stub).regF(IMitosisVault.withdraw.selector, true, 'withdraw');
    _tom(stub).regF(IMitosisVault.setEntrypoint.selector, true, 'setEntrypoint');

    // Register IMitosisVaultMatrix view functions
    _tom(stub).regF(IMitosisVaultMatrix.isMatrixInitialized.selector, false, 'isMatrixInitialized');
    _tom(stub).regF(IMitosisVaultMatrix.availableMatrix.selector, false, 'availableMatrix');
    _tom(stub).regF(
      IMitosisVaultMatrix.matrixStrategyExecutor.selector, false, 'matrixStrategyExecutor'
    );

    // Register IMitosisVaultMatrix mutative functions
    _tom(stub).regF(
      IMitosisVaultMatrix.depositWithSupplyMatrix.selector, true, 'depositWithSupplyMatrix'
    );
    _tom(stub).regF(IMitosisVaultMatrix.initializeMatrix.selector, true, 'initializeMatrix');
    _tom(stub).regF(IMitosisVaultMatrix.allocateMatrix.selector, true, 'allocateMatrix');
    _tom(stub).regF(IMitosisVaultMatrix.deallocateMatrix.selector, true, 'deallocateMatrix');
    _tom(stub).regF(IMitosisVaultMatrix.fetchMatrix.selector, true, 'fetchMatrix');
    _tom(stub).regF(IMitosisVaultMatrix.returnMatrix.selector, true, 'returnMatrix');
    _tom(stub).regF(IMitosisVaultMatrix.settleMatrixYield.selector, true, 'settleMatrixYield');
    _tom(stub).regF(IMitosisVaultMatrix.settleMatrixLoss.selector, true, 'settleMatrixLoss');
    _tom(stub).regF(
      IMitosisVaultMatrix.settleMatrixExtraRewards.selector, true, 'settleMatrixExtraRewards'
    );
    _tom(stub).regF(
      IMitosisVaultMatrix.setMatrixStrategyExecutor.selector, true, 'setMatrixStrategyExecutor'
    );

    // Register IMitosisVaultEOL view functions
    _tom(stub).regF(IMitosisVaultEOL.isEOLInitialized.selector, false, 'isEOLInitialized');

    // Register IMitosisVaultEOL mutative functions
    _tom(stub).regF(IMitosisVaultEOL.depositWithSupplyEOL.selector, true, 'depositWithSupplyEOL');
    _tom(stub).regF(IMitosisVaultEOL.initializeEOL.selector, true, 'initializeEOL');
  }

  // ================================================= VIEW FUNCTIONS ================================================= //
  // ====================================== IMitosisVault Specific ===================================== //

  function setRetIsAssetInitialized(address stub, address asset, bool isInitialized)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVault.isAssetInitialized, (asset));
    _tom(stub).setOk(data, abi.encode(isInitialized));
    return stub;
  }

  function setRetEntrypoint(address stub, address entrypointAddr) internal returns (address) {
    bytes memory data = abi.encodeCall(IMitosisVault.entrypoint, ());
    _tom(stub).setOk(data, abi.encode(entrypointAddr));
    return stub;
  }

  // ==================================== IMitosisVaultMatrix Specific =================================== //

  function setRetIsMatrixInitialized(address stub, address hubMatrixVault, bool isInitialized)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVaultMatrix.isMatrixInitialized, (hubMatrixVault));
    _tom(stub).setOk(data, abi.encode(isInitialized));
    return stub;
  }

  // Add setRet... for availableMatrix, matrixStrategyExecutor if needed

  // ====================================== IMitosisVaultEOL Specific ====================================== //

  function setRetIsEOLInitialized(address stub, address hubEOLVault, bool isInitialized)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVaultEOL.isEOLInitialized, (hubEOLVault));
    _tom(stub).setOk(data, abi.encode(isInitialized));
    return stub;
  }

  // ================================================= MUTATIVE FUNCTIONS ================================================= //

  // Note: Most MitosisVault mutative functions don't return values.
  // These `setRet...` functions primarily register the call pattern as successful (`setOk` without return data).

  // ====================================== IMitosisVault Specific ===================================== //

  function setRetInitializeAsset(address stub, address asset) internal returns (address) {
    bytes memory data = abi.encodeCall(IMitosisVault.initializeAsset, (asset));
    _tom(stub).setOk(data, abi.encode()); // No return value
    return stub;
  }

  function setRetDeposit(address stub, address asset, address to, uint256 amount)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVault.deposit, (asset, to, amount));
    _tom(stub).setOk(data, abi.encode()); // No return value
    return stub;
  }

  function setRetWithdraw(address stub, address asset, address to, uint256 amount)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVault.withdraw, (asset, to, amount));
    _tom(stub).setOk(data, abi.encode()); // No return value
    return stub;
  }

  function setRetSetEntrypoint(address stub, address entrypointAddr) internal returns (address) {
    bytes memory data = abi.encodeCall(IMitosisVault.setEntrypoint, (entrypointAddr));
    _tom(stub).setOk(data, abi.encode()); // No return value
    return stub;
  }

  // ==================================== IMitosisVaultMatrix Specific =================================== //

  function setRetInitializeMatrix(address stub, address hubMatrixVault, address asset)
    internal
    returns (address)
  {
    bytes memory data =
      abi.encodeCall(IMitosisVaultMatrix.initializeMatrix, (hubMatrixVault, asset));
    _tom(stub).setOk(data, abi.encode());
    return stub;
  }

  function setRetDepositWithSupplyMatrix(
    address stub,
    address asset,
    address to,
    address hubMatrixVault,
    uint256 amount
  ) internal returns (address) {
    bytes memory data = abi.encodeCall(
      IMitosisVaultMatrix.depositWithSupplyMatrix, (asset, to, hubMatrixVault, amount)
    );
    _tom(stub).setOk(data, abi.encode());
    return stub;
  }

  function setRetFetchMatrix(address stub, address hubMatrixVault, uint256 amount)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVaultMatrix.fetchMatrix, (hubMatrixVault, amount));
    _tom(stub).setOk(data, abi.encode());
    return stub;
  }

  function setRetSettleMatrixYield(address stub, address hubMatrixVault, uint256 amount)
    internal
    returns (address)
  {
    bytes memory data =
      abi.encodeCall(IMitosisVaultMatrix.settleMatrixYield, (hubMatrixVault, amount));
    _tom(stub).setOk(data, abi.encode());
    return stub;
  }

  // Add other setRet... functions for Matrix mutative methods as needed

  // ====================================== IMitosisVaultEOL Specific ====================================== //

  function setRetInitializeEOL(address stub, address hubEOLVault, address asset)
    internal
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVaultEOL.initializeEOL, (hubEOLVault, asset));
    _tom(stub).setOk(data, abi.encode());
    return stub;
  }

  function setRetDepositWithSupplyEOL(
    address stub,
    address asset,
    address to,
    address hubEOLVault,
    uint256 amount
  ) internal returns (address) {
    bytes memory data =
      abi.encodeCall(IMitosisVaultEOL.depositWithSupplyEOL, (asset, to, hubEOLVault, amount));
    _tom(stub).setOk(data, abi.encode());
    return stub;
  }

  // ================================================= ASSERT FUNCTIONS ================================================= //
  // ====================================== IMitosisVault Specific ===================================== //

  function assertInitializeAsset(address stub, address asset) internal view returns (address) {
    bytes memory data = abi.encodeCall(IMitosisVault.initializeAsset, (asset));
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertDeposit(address stub, address asset, address to, uint256 amount)
    internal
    view
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVault.deposit, (asset, to, amount));
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertWithdraw(address stub, address asset, address to, uint256 amount)
    internal
    view
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVault.withdraw, (asset, to, amount));
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertSetEntrypoint(address stub, address entrypointAddr)
    internal
    view
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVault.setEntrypoint, (entrypointAddr));
    _toi(stub).expectOk(data);
    return stub;
  }

  // ==================================== IMitosisVaultMatrix Specific =================================== //

  function assertInitializeMatrix(address stub, address hubMatrixVault, address asset)
    internal
    view
    returns (address)
  {
    bytes memory data =
      abi.encodeCall(IMitosisVaultMatrix.initializeMatrix, (hubMatrixVault, asset));
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertDepositWithSupplyMatrix(
    address stub,
    address asset,
    address to,
    address hubMatrixVault,
    uint256 amount
  ) internal view returns (address) {
    bytes memory data = abi.encodeCall(
      IMitosisVaultMatrix.depositWithSupplyMatrix, (asset, to, hubMatrixVault, amount)
    );
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertFetchMatrix(address stub, address hubMatrixVault, uint256 amount)
    internal
    view
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVaultMatrix.fetchMatrix, (hubMatrixVault, amount));
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertSettleMatrixYield(address stub, address hubMatrixVault, uint256 amount)
    internal
    view
    returns (address)
  {
    bytes memory data =
      abi.encodeCall(IMitosisVaultMatrix.settleMatrixYield, (hubMatrixVault, amount));
    _toi(stub).expectOk(data);
    return stub;
  }

  // Add other assert... functions for Matrix mutative methods as needed

  // ====================================== IMitosisVaultEOL Specific ====================================== //

  function assertInitializeEOL(address stub, address hubEOLVault, address asset)
    internal
    view
    returns (address)
  {
    bytes memory data = abi.encodeCall(IMitosisVaultEOL.initializeEOL, (hubEOLVault, asset));
    _toi(stub).expectOk(data);
    return stub;
  }

  function assertDepositWithSupplyEOL(
    address stub,
    address asset,
    address to,
    address hubEOLVault,
    uint256 amount
  ) internal view returns (address) {
    bytes memory data =
      abi.encodeCall(IMitosisVaultEOL.depositWithSupplyEOL, (asset, to, hubEOLVault, amount));
    _toi(stub).expectOk(data);
    return stub;
  }

  // Add more assert... functions for other mutative methods as needed
}
