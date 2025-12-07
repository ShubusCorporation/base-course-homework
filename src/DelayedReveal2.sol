// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;


/*
remappings = [
    ...
    "ERC721A/=lib/ERC721A/contracts/",
    ...
]
*/
import "ERC721A/ERC721A.sol"; // forge install chiru-labs/ERC721A
import "@openzeppelin/contracts/access/Ownable.sol";

/*
Ниже — оптимизированный Delayed Reveal NFT на ERC721A
(использует Azuki ERC721A для дешёвого минтинга + ленивый reveal через baseURI).

🧠 Как это работает
До reveal:

tokenURI(id) отдаёт hiddenURI
(это обычно /metadata/hidden.json)

После reveal:

админ вызывает reveal("https://real-metadata/")

теперь tokenURI(id) будет https://real-metadata/{id}.json

Почему ERC721A быстрее?

_safeMint(to, quantity) записывает владение только для первого токена в пачке

остальные выводит “лениво” → минт ~в 3–10 раз дешевле
*/

contract DelayedRevealERC721A is ERC721A, Ownable(msg.sender) {
    string private _baseTokenURI;     // реальный baseURI после reveal
    string public hiddenURI;          // скрытый URI
    bool public revealed = false;

    constructor(
        string memory _hiddenURI
    ) ERC721A("DelayedRevealA", "DRA") {
        hiddenURI = _hiddenURI;
    }

    /// @dev mint пачками (ERC721A сильно оптимизирован)
    function mint(address to, uint256 quantity) external onlyOwner {
        _safeMint(to, quantity);
    }

    /// @dev включить reveal и установить реальный baseURI
    function reveal(string calldata newBaseURI) external onlyOwner {
        require(!revealed, "Already revealed");
        revealed = true;
        _baseTokenURI = newBaseURI;
    }

    // ——————————————————————————————
    //           METADATA LOGIC
    // ——————————————————————————————

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        if (!revealed) {
            return hiddenURI;
        }

        return string(
            abi.encodePacked(
                _baseTokenURI,
                _toString(tokenId),
                ".json"
            )
        );
    }

    /// @dev переопределяем baseURI хук ERC721A
    function _baseURI() internal view override returns (string memory) {
        return _baseTokenURI;
    }
}
