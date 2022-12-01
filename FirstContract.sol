// SPDX-License-Identifier: GPL-3.0

// pragma solidity  >=0.7.0 <0.9.0

pragma solidity 0.8.17;

contract Property {
    address payable user = payable(0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db);

    function payEther() public payable{
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function payEtherToAccount() public{
        user.transfer(10 ether);
    }
}
