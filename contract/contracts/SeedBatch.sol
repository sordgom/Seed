// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract SeedBatch is ERC1155, Ownable, ERC1155Supply {
    using Counters for Counters.Counter;

    //Counter to keep track of the number of NFT we minted and make sure we dont try to mint the same twice
    Counters.Counter private _tokenIds;
    uint256 private const _TIMELOCK = 1 days;

    //Map Uri & Time Locks with tokenId
    mapping (uint256 => string) public _tokenURIs;
    mapping (uint256 => uint256) private _timelock;

    //Time lock modifier
    modifier notLocked(uint256 tokenId)  {
        require(
            _timelock[tokenId] >= block.timestamp,
            "Function is timelocked"
        );
        _;
    }

    constructor() ERC1155("https://seedBatch.com/{id}.json") {}
  
    function setTimePeriod(uint256 tokenId, uint256 timePeriod) public onlyOwner {
        _timelock[tokenId] = block.timestamp + timePeriod ;
    } 

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 tokenId) override public view returns (string memory) { 
        return(_tokenURIs[tokenId]); 
    } 

    function setTokenUri(uint256 tokenId, string memory tokenURI) public onlyOwner {
         _tokenURIs[tokenId] = tokenURI;
    } 

    //Create a new NFT
    function create(address account, uint256 amount, string memory tokenURI, uint256 timePeriod) 
    public onlyOwner {
        uint256 newItemId = _tokenIds.current();
        setTimePeriod(newItemId, timePeriod);
        setTokenUri(newItemId, tokenURI);
        _mint(account, newItemId, amount, "");        
        _tokenIds.increment();
    }

    //Mint function with Time Lock
    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner notLocked(id){
        _mint(account, id, amount, data);
    }

    function bulk_mint(address[] memory accounts, uint256 id, bytes memory data) public onlyOwner notLocked(id){
        uint256 n = accounts.length;

        for (uint i=0; i<n; ) {
            _mint(accounts[i], id, 1, data);
            
            unchecked{++i;}
        }
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner notLocked(id){
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) internal override(ERC1155, ERC1155Supply) {
        require(from == address(0) || to == address(0), "Not allowed to transfer token");
    }
}