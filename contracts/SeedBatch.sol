// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract SeedBatch is ERC1155, Ownable, ERC1155Supply {
    mapping (uint256 => string) private _tokenURIs;

    constructor() ERC1155("https://seedBatch.com/") {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 tokenId) override public view returns (string memory) { 
        return(_tokenURIs[tokenId]); 
    } 

    function setTokenUri(uint256 tokenId, string memory tokenURI) public onlyOwner {
         _tokenURIs[tokenId] = tokenURI;
    } 

    function mint(address account, uint256 id, uint256 amount, bytes memory data) public onlyOwner {
        _mint(account, id, amount, data);
    }

    function bulk_mint(address[] memory accounts, uint256 id, bytes memory data) public onlyOwner {
        uint256 n = accounts.length;

        for (uint i=0; i<n; ) {
            _mint(accounts[i], id, 1, data);
            
            unchecked{++i;}
        }
    }

    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public onlyOwner {
        _mintBatch(to, ids, amounts, data);
    }

    // The following functions are overrides required by Solidity.
    function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) internal override(ERC1155, ERC1155Supply) {
        require(from == address(0) || to == address(0), "Not allowed to transfer token");
    }
}