// SPDX-License-Identifier: GPL-3.0

// pragma solidity  >=0.7.0 <0.9.0

pragma solidity 0.8.17;

contract Ecommerce{
    struct Product {
        string title;
        string desc;
        uint productId;
        address payable seller;
        address buyer;
        uint price;
        bool delivered;
    }
    uint counter = 1;
    Product[] public products;
    event registered(string title, uint productId, address seller);
    event bought(uint productId, address buyer);
    event delivered(uint productId);

    function registeredProduct(string memory _title, string memory _desc, uint _price) public{
        require(_price > 0, "Price should be greater than zero");
        Product memory tempProduct;
        tempProduct.title = _title;
        tempProduct.desc = _desc;
        tempProduct.price = _price * 10**18;
        tempProduct.seller = payable(msg.sender);
        tempProduct.productId = counter;
        products.push(tempProduct);
        counter++;
        emit registered(_title, tempProduct.productId, msg.sender);
    }

    function buy(uint _productId) payable public {
        require(products[_productId-1].price==msg.value, "Please pay the exact amount");
        require(products[_productId-1].seller!=msg.sender, "Seller cannot be a buyer");
        products[_productId-1].buyer = msg.sender;
        emit bought(_productId, msg.sender);
    }

    function delivery(uint _productId) public {
        require(products[_productId-1].buyer==msg.sender, "Only buyer can confirm it");
        products[_productId-1].delivered = true;
        products[_productId-1].seller.transfer(products[_productId-1].price);
        emit delivered(_productId);
    }
}