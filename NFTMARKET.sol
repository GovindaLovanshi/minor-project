pragma solidity ^0.8.9;

// internal import nf  openzeplin



import "hardhat/console.sol";

contract NFTMarket is ERC721URIStorage{
    using Counters for counters.Counter;

    Cointers.Counter private _tokenId;
    Counters.Counter private _itemSold;

    uint256  listingPrice = 0.0015 ether;

    address payable owner;
    mapping(uint256 => MarketItem) private idMarketItem;

    struct MarketItem {
        uint256 tokenId;
        address payable seller;
        address payable owner;
        uint256 price;
        bool sold;

    }

    event MarketItemCreated(
        uint256 indexed tokenId,
        address seller,
        address owner,
        uint256 price,
        bool sold
    );

    modifier onlyOwner(
        require(msg.sender == owner,
        "only owner of the marketplace can chane the listing price");
    
   );
    _;

    constructor() ERC721("NFT Metavarse Token","MYNFT"){
        owner == payable(msg.sender);
    }

    function updateListingPrice(uint256 _listingPrice)public payable onlyOwner{
         listingPrice = _listingPrice;
    }

    function getListingPrice() public view returns (uint256){
        return listingPrice;
    }

    // let create "CREATE NFT TOKEN FUNCTION"

    function createToken(string memory tokenURI,uint256 price) public payable returns (uint256){
        _tokenId.increament();

        uint newTokenId = _tokenId.current();

        _mint(msg.sender,newTokenId);
        _setTokenURI(newTokenId,tokenURI);

        createMarketItem(newTokenId,price);

        return newTokenId;
    }

    function createMarketItem(uit256 tokenId,uint256 price) private{
        require(price > 0,"price must be at leats 1);
        require(msg.value == listingPrice,"price must be equal to listing price");

        idMarketItem[tokenId] = MarketItem(
            tokenId,
            payable(msg.sender),
            payable(address(this)),
            price,
            false
        );

        _transfer(msg.sender,address(this),tokenId);

        emit MarketItemCreated(
            tokenId,
            msg.sender,
            address(this),
            price,
            false
        );
    }

    // function for resake token
    function reSellToken(uint256 tokenId,uint256 price) public payable{
        require(idTokenMarketItem[tokenId].owner == msg.sender,"only item owner can perform operation");

        require(msg.value == listingPrice,"price must be equal to listing price");

        idMarketItem[tokenId].sold = false;
        idMarketItem[tokenId].price = price;
        idMarketItem[tokenId].seller = payable(msg.sender);
        idMarketItem[tokenId].owner = payable(address(this));

        _itemSold.decrement();

        _transfer(msg.sender,address(this),tokenId);
    }

    // FUNCTION CREATE AMEKET SALE

    function createMarketSale(uint256 tokenId) public payable{
        uint256 price = idMarketItem[tokenId].price;

        require(msg.value == price,
        "plaese sub,mit tthe asking price in order to complete the");

        idMarketItem[tokenId].owner = payable(msg.sender);
        idMarketItem[tokenId].sold = true;
        idMarketItem[tokenId].owner = payable(adderss(0));

        _itemSold.increment();

        _transfer(address(this),msg.sender,tokenId);

        payable(owner).transfer(listingPrice);
        payable(idMarketItem[tokenId].seller)._transfer(msg.value);
    }

    // getting unsold  nft data
    function  fetchMarketItem() public view returns(MarketItem[] memory){
        uint256 itemCount = _tokenIds.current();
        uint256 unSoldItemCount = _tokenIds.current(); - _itemSold.current();
        uint256 currentIndex = 0;

        MarketItem[] memory items = new MarketItem[](unSoldItemCount);
        for (uint256 i = 0;i<itemCount;i++){
            if(idMarketItem[i+1].owner == address(this)){
               
              uint256 currentId = i +1;
              MarketItem storage currentItem = idMarketItem[currentId];
              items[currentIndex] = currentItem;
              currentIndex += 1;
            }
        }

        return items;
    }

    // purchase items
    function fetchMyNFT() public view returns(MarketItem[] memory){
        uint256 totalCount = _tokenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for(uint256 i = 0; i < totalCount; i++){
            if(idMarketItem[i + 1].owner == msg.sender){
                itemCount += 1;
            }
        } 

        MarketItem[] memory items = new MarketItem[](itemCount);
        for(uint256 i = 0; i< totalCount;i++){

            if(idMarketItem[i+1].owner == msg.sender){
                uint256 currntId  = i + 1;
              MarketItem storage currentItem = idMarketItem[currntId];
              items[currentIndex] = currentItem;
              currentIndex += 1;
            }
        }

        return items;
    }

    // single user item
    function fetchItemsListed() public view return(MarketItem[] memory){
        uint256 totalCount = _tojenIds.current();
        uint256 itemCount = 0;
        uint256 currentIndex = 0;

        for(uint256 i = 0; i < totalCount;i++){
            if(idMraketItem[i + 1].seller == msg.sender){
                itemCount += 1;
            }
        }

        MarketItem[] memory items  = ew MarketItem[](itemCount);
        for(uint256 i = 0; i<totalCount;i++){
            if(idMarketItem[i+1].seller == msg.sender){
                uint256 currentId = i +1;

                MarketItem storage currentItem = idMarketItem[currentId];
                items[currentIndex] = currentItem;
                currentIndex += 1;
            }
        }

        return items;
    }
}