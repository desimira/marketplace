pragma solidity ^0.5.0;
import './SafeMath.sol';

library ProductLib {
    using SafeMath for uint;
        
    struct Product {
        string name;
        uint256 price;
        uint256 quantity;
        uint256 IDindex;
        bool wasIncreased;
    }
        
    function canBeBought(Product storage self, uint amount, uint quantity) internal view returns (bool) {
        return self.price <= amount.div(quantity) && self.quantity >= quantity;
    }
    
    function productExist(Product storage self) internal view returns (bool) {
        bytes memory convertedName = bytes(self.name);
        return convertedName.length != 0;
    }
    
    function buyProduct(Product storage self, uint quantity) internal {
        self.quantity = self.quantity.sub(quantity);
    }
    
    function increasePriceOnLowQuantity (Product storage self) internal {
        self.price = self.price.add(10);
    }
    
    function restorePrice(Product storage self) internal {
        self.price = self.price.sub(10);
    }
    
    function regNewProduct(string memory name, uint price, uint quantity, uint IDindex, bool wasIncreased) internal pure returns(Product memory) {
        Product memory product = Product({name:name, price:price, quantity:quantity, IDindex:IDindex, wasIncreased: wasIncreased});
        
        return product;
    }
    
    function removeProduct(Product storage self) internal {
        self.name = '';
        self.price = 0;
        self.quantity = 0;
    }
        
}