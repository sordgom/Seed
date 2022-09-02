// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "./SeedBatch.sol";
contract SeedNFT is SeedBatch{

    string private _eventName;
    string private _symbol;
    string private _baseUri;
     constructor(string memory eventName, string memory symbol, string memory Uri) {
        _eventName = eventName;
        _symbol = symbol;
        _baseUri = Uri;
    }

     function eventName() external view returns (string memory) {
        return _eventName;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function mint(address account, uint256 id, uint256 amount) override public onlyOwner {
        mint( account,  id,  amount, _baseUri);
    }

    function bulk_mint(address[] memory accounts, uint256 id) override public onlyOwner {
        bulk_mint( accounts,  id, _baseUri);
    }
}