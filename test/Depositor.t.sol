// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { Test } from '@std/Test.sol';

import { LibStub } from '@stub/helper/LibStub.sol';
import { Stub } from '@stub/Stub.sol';

import { IERC20 } from '@oz/interfaces/IERC20.sol';
import { IERC2612 } from '@oz/interfaces/IERC2612.sol';

import { IMitosisVault } from '@protocol/interfaces/branch/IMitosisVault.sol';
import { IMitosisVaultEOL } from '@protocol/interfaces/branch/IMitosisVaultEOL.sol';
import { IMitosisVaultMatrix } from '@protocol/interfaces/branch/IMitosisVaultMatrix.sol';

import { WETH } from '@solady/tokens/WETH.sol';

import { Depositor } from 'src/Depositor.sol';
import { LibStubMitosisVault } from 'test/stub/LibStubMitosisVault.sol';

contract DepositorTest is Test {
  using LibStub for address;
  using LibStubMitosisVault for address;

  Depositor internal depositor;
  WETH internal token;
  address internal vault;

  address internal owner = makeAddr('owner');
  address internal user = makeAddr('user');
  address internal otherUser = makeAddr('otherUser');

  function setUp() public {
    vm.label(owner, 'Owner');
    vm.label(user, 'User');
    vm.label(otherUser, 'OtherUser');

    token = new WETH();
    vault = address(new Stub('Mock Vault'));
    LibStubMitosisVault.initStubMitosisVault(vault);

    depositor = new Depositor(owner, vault, address(token));

    vm.deal(owner, 1000 ether);
    vm.prank(owner);
    token.deposit{ value: 1000 ether }();
  }

  function test_executeWith_Success() public {
    uint256 amount = 100 ether;

    vm.startPrank(owner);
    token.transfer(user, amount);
    depositor.setAllowance(IMitosisVault.deposit.selector, true);
    depositor.setAllowance(IMitosisVaultEOL.depositWithSupplyEOL.selector, true);
    depositor.setAllowance(IMitosisVaultMatrix.depositWithSupplyMatrix.selector, true);
    vm.stopPrank();

    vault.setRetDeposit(address(token), user, amount / 3);
    vault.setRetDepositWithSupplyEOL(address(token), user, address(vault), amount / 3);
    vault.setRetDepositWithSupplyMatrix(address(token), user, address(vault), amount / 3);

    vm.startPrank(user);

    {
      token.approve(address(depositor), amount / 3);
      bytes memory data = _encodeDeposit(address(token), user, amount / 3);
      bytes memory result = depositor.executeWith(amount / 3, data);
      assertEq(result.length, 0, 'Return data should be empty');
    }

    {
      token.approve(address(depositor), amount / 3);
      bytes memory data = _encodeDepositWithSupplyEOL(address(token), user, amount / 3);
      bytes memory result = depositor.executeWith(amount / 3, data);
      assertEq(result.length, 0, 'Return data should be empty');
    }

    {
      token.approve(address(depositor), amount / 3);
      bytes memory data = _encodeDepositWithSupplyMatrix(address(token), user, amount / 3);
      bytes memory result = depositor.executeWith(amount / 3, data);
      assertEq(result.length, 0, 'Return data should be empty');
    }

    vm.stopPrank();

    vault.assertDeposit(address(token), user, amount);
    vault.assertDepositWithSupplyEOL(address(token), user, address(vault), amount);
    vault.assertDepositWithSupplyMatrix(address(token), user, address(vault), amount);
  }

  function _encodeDeposit(address token_, address user_, uint256 amount)
    internal
    pure
    returns (bytes memory)
  {
    return abi.encodeCall(IMitosisVault.deposit, (address(token_), user_, amount));
  }

  function _encodeDepositWithSupplyEOL(address token_, address user_, uint256 amount)
    internal
    view
    returns (bytes memory)
  {
    return abi.encodeCall(
      IMitosisVaultEOL.depositWithSupplyEOL, (address(token_), user_, address(vault), amount)
    );
  }

  function _encodeDepositWithSupplyMatrix(address token_, address user_, uint256 amount)
    internal
    view
    returns (bytes memory)
  {
    return abi.encodeCall(
      IMitosisVaultMatrix.depositWithSupplyMatrix, (address(token_), user_, address(vault), amount)
    );
  }
}
