// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
📝 Как работает

До раскрытия (reveal):

Все токены имеют одинаковый URI hiddenURI (например /metadata/hidden.json).

После вызова reveal():

Коллекция становится раскрытой.

Каждый токен получает реальный URI вида:
baseURI + tokenId + ".json"

Функцию reveal может вызвать только владелец контракта.
*/

contract DelayedRevealNFT is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;

    string public hiddenURI;      // URI пока NFT скрыт
    string public baseURI;        // Настоящий baseURI после reveal
    bool public revealed = false; // Флаг — раскрыта ли коллекция

    constructor(string memory _hiddenURI) ERC721("DelayedReveal NFT", "DRNFT") Ownable(msg.sender) {
        hiddenURI = _hiddenURI;
    }

    function mint(address to) external onlyOwner {
        uint256 tokenId = nextTokenId++;
        _mint(to, tokenId);

        // Пока не раскрыто — ставим скрытый URI
        _setTokenURI(tokenId, hiddenURI);
    }

    /// @notice Включить reveal, указав реальный baseURI
    function reveal(string memory _baseURI) external onlyOwner {
        require(!revealed, "Already revealed");
        baseURI = _baseURI;
        revealed = true;

        // Обновить URI каждого токена
        for (uint256 i = 0; i < nextTokenId; i++) {
            _setTokenURI(i, string(abi.encodePacked(baseURI, _uint2str(i), ".json")));
        }
    }

    // Внутренний хелпер для uint → string
    function _uint2str(uint256 _i) internal pure returns (string memory) {
        if (_i == 0) return "0";
        uint256 j = _i;
        uint256 length;
        while (j != 0) { length++; j /= 10; }
        bytes memory bstr = new bytes(length);
        uint256 k = length;
        j = _i;
        while (j != 0) {
            bstr[--k] = bytes1(uint8(48 + j % 10));
            j /= 10;
        }
        return string(bstr);
    }
}
