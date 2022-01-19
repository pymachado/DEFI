// SPDX-License-Identifier: MIT
/**
    @author Pedro Machado.
    @title DEFI Library.
    @notice Library based on ABDKMath64x64 library to calculate some financing variables. It is based in time not in block.
*/

pragma solidity ^0.8.0;

import "./ABDKMath64x64";
library DEFI {


function _compoundReward(uint amount, uint stakePeriod, int128 mir) private pure returns(uint) {
    return ABDKMath64x64.mulu(_compoundRatio(mir, stakePeriod), amount);
} 

function _compoundRatio(int128 mir, uint stakePeriod) private pure returns(int128) {
    return ABDKMath64x64.sub(ABDKMath64x64.exp_2(ABDKMath64x64.mul(ABDKMath64x64.divu(stakePeriod, 365), ABDKMath64x64.log_2(_air(mir)))), ABDKMath64x64.fromUInt(1));
    }

function _dir(int128 mir) private pure  returns (int128) {
    return ABDKMath64x64.sub(ABDKMath64x64.exp_2(ABDKMath64x64.mul(ABDKMath64x64.inv(ABDKMath64x64.fromUInt(365)), ABDKMath64x64.log_2(_air(mir)))), ABDKMath64x64.fromUInt(1));
    }

function _air(int128 mir) private pure returns (int128) {
    return ABDKMath64x64.pow(ABDKMath64x64.add(ABDKMath64x64.fromUInt(1), mir), 12);
    }

}