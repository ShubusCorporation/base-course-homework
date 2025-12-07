// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Store is Ownable {
    struct PurchaseItem {
        uint256 id;
        uint256 quantity;
    }
    struct ProductData {
        uint256 id;
        string name;
        uint256 stock;
        uint256 price;
        uint256 sold;
        bool exists;
    }
    struct Purchase {
        uint256 productId;
        uint256 quantity;
        uint256 pricePerUnit;
        uint256 timestamp;
        uint256 refunded; // how many products are refunded
    }

    /// @notice buyer => product_id => quantity
    mapping(address => mapping(uint256 => Purchase)) public userPurchase;

    /// @notice product_id => product data
    mapping(uint256 => ProductData) products;
    uint256[] private productIds;

    event EventPurchase(address buyer, uint256 id, uint256 quantity);
    event EventRefund(address buyer, uint256 id, uint256 quantity);

    error IdAlreadyExist();
    error IdDoesNotExist();
    error NotEnoughtFunds();
    error QuantityCantBeZero();
    error InvalidPrice();
    error TransactionFailed(address, uint256);
    error NotEnoughProduct(address, uint256, uint256, uint256);
    error NotEnoughMoney(uint256);

    constructor() Ownable(msg.sender) {}

    function buy(uint256 _id, uint256 _quantity) payable external {
        require(_quantity > 0, QuantityCantBeZero());
        ProductData storage product = products[_id];
        require(product.exists && product.stock >= _quantity, NotEnoughProduct(msg.sender, _id, product.stock, _quantity));

        uint256 totalPrice = product.price * _quantity;
        require(msg.value >= totalPrice, NotEnoughtFunds());

        _buyProcess(msg.sender, _id, _quantity);
        
        if(msg.value > totalPrice) {
            uint256 refundAmount = msg.value - totalPrice;
            (bool success, ) = payable(msg.sender).call{value: refundAmount}("");
            require(success, TransactionFailed(msg.sender, refundAmount));
        }
    }

    function batchBuy(PurchaseItem[] calldata items) payable external {
        uint256 totalPrice = 0;

        for(uint i = 0; i < items.length; i++) {
            uint256 q = items[i].quantity;
            uint256 id = items[i].id;

            require(q > 0, QuantityCantBeZero());
            require(products[id].exists && products[id].stock >= q, NotEnoughProduct(msg.sender, id, products[id].stock, q));

            totalPrice += products[id].price * q;
        }

        require(msg.value >= totalPrice, NotEnoughtFunds());

        for(uint i = 0; i < items.length; i++) {
            uint256 q = items[i].quantity;
            uint256 id = items[i].id;

            _buyProcess(msg.sender, id, q);
        }

        if(msg.value > totalPrice) {
            uint256 refundAmount = msg.value - totalPrice;
            (bool success, ) = payable(msg.sender).call{value: refundAmount}("");
            require(success, TransactionFailed(msg.sender, refundAmount));
        }
    }

    function _buyProcess(address buyer, uint256 _id, uint256 _quantity) internal {
        ProductData storage product = products[_id];
        product.stock -= _quantity;
        product.sold += _quantity;
        Purchase storage purchase = userPurchase[buyer][_id]; 
        purchase.productId = product.id;
        purchase.pricePerUnit = product.price;
        purchase.timestamp = block.timestamp;
        purchase.quantity += _quantity;
        emit EventPurchase(buyer, _id, _quantity);
    }

    function refund(uint256 _id, uint256 _quantity) external {
        // 1. Checks
        require(_quantity > 0, QuantityCantBeZero());
        Purchase storage purchase = userPurchase[msg.sender][_id];
        uint256 money = purchase.pricePerUnit * _quantity;
        require(address(this).balance >= money, NotEnoughMoney(money));
        require(purchase.timestamp > 0 && purchase.quantity > 0, IdDoesNotExist());
        require(purchase.quantity - purchase.refunded >= _quantity, NotEnoughProduct(msg.sender, _id, purchase.quantity, _quantity));

        // 2. Effects
        ProductData storage product = products[_id];
        product.stock += _quantity;
        product.sold -= _quantity;
        purchase.refunded += _quantity;

        // 3. Interactions
        emit EventRefund(msg.sender, _id, _quantity);
        (bool success, ) = payable(msg.sender).call{value: money}("");
        require(success, TransactionFailed(msg.sender, money));
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, NotEnoughtFunds());

        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, TransactionFailed(owner(), balance));
    }

    function addProduct(string calldata _name, uint256 _id, uint256 _stock, uint256 _price) external onlyOwner {
        require(!products[_id].exists, IdAlreadyExist());
        products[_id] = ProductData({
            id: _id,
            name: _name,
            stock: _stock,
            price: _price,
            sold: 0,
            exists: true
        });
        productIds.push(_id);
    }

    function deleteProduct(uint256 _id) external onlyOwner {
        require(products[_id].exists, IdDoesNotExist());

        delete products[_id];
    
        for (uint256 i = 0; i < productIds.length; i++) {
            if (productIds[i] == _id) {
                productIds[i] = productIds[productIds.length - 1];
                productIds.pop();
                break;
            }
        }
    }

    function updatePrice(uint256 _id, uint256 _price) external onlyOwner {
        require(_price > 0, InvalidPrice());
        require(products[_id].exists, IdDoesNotExist());

        products[_id].price = _price;
    }

    function updateStock(uint256 _id, uint256 _stock) external onlyOwner {
        require(products[_id].exists, IdDoesNotExist());
        products[_id].stock = _stock;
    }

    function getProducts() external view returns (ProductData[] memory list) {
        list = new ProductData[](productIds.length);

        for (uint i = 0; i < productIds.length; i++) {
            list[i] = products[productIds[i]];
        }
        return list;
    }

    function getPrice(uint256 _id) external view returns(uint256) {
        require(products[_id].exists, IdDoesNotExist());
        return products[_id].price;
    }

    function getStock(uint256 _id) external view returns(uint256) {
        require(products[_id].exists, IdDoesNotExist());
        return products[_id].stock;
    }

    //HOMEWORK
    // Add refund() function
    // Add topSellingProducts() function
    // Add getTotalRevenue() function

    // Add getUserPurchase(address) function

    // Add DISCOUNT_CODES functionality

    // Add Struct Purchase (if you want to)
}