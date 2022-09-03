// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "./SeedBatch.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
contract SeedNFT is SeedBatch {
    using SafeMath for uint256;

    string private _eventName;
    string private _symbol;
    bytes private _baseUri;
    uint256 private _currentTokenID = 0;
    uint256 private _timeCreated;
    uint256 private _timePeriod;

    constructor(
        string memory eventName,
        string memory symbol,
        string memory Uri,
        uint256 timePeriod
    ) {
        _eventName = eventName;
        _symbol = symbol;
        _baseUri = bytes(Uri);
        _timeCreated = block.timestamp;
        _timePeriod = timePeriod * 24 * 60 * 60;// days to seconds
    }

    function eventName() external view returns (string memory) {
        return _eventName;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }   

    function mint(address account, uint256 id, uint256 amount) public onlyOwner {
        require(
            block.timestamp <= _timeCreated + _timePeriod,
            "You can't mint this token anymore"
        );
        super.mint(account, id, amount, _baseUri);
    }

    function bulk_mint(address[] memory accounts, uint256 id)
        public
        
        onlyOwner
    {
        require(
            block.timestamp <= _timeCreated + _timePeriod,
            "You can't mint this token anymore"
        );
        super.bulk_mint(accounts, id, _baseUri);
    }

    function _getNextTokenID() private view returns (uint256) {
        return _currentTokenID.add(1);
    }

    function _incrementTokenTypeId() private {
        _currentTokenID++;
    }
}
