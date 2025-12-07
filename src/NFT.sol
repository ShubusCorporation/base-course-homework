// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/*
ERC-1155 — это стандарт токенов на блокчейне Ethereum, который позволяет создавать
взаимозаменяемые (fungible), невзаимозаменяемые (non-fungible) и полувзаимозаменяемые (semi-fungible) токены в одном смарт-контракте.
Его ключевые преимущества — оптимизация транзакций, снижение затрат на газ за счет пакетных операций и повышенная безопасность переводов. 

Ключевые особенности ERC-1155

    Мультитокенность: Возможность выпускать несколько разных типов токенов (например, игровую валюту и уникальные скины) в рамках одного смарт-контракта, что упрощает разработку приложений.
    Пакетные операции: Позволяет выполнять массовые транзакции (перевод, выпуск, сжигание) сразу для нескольких токенов за одну операцию, что значительно снижает комиссии за газ.
    Безопасные переводы: Реализован механизм безопасной передачи, который предотвращает случайную отправку токенов на неправильный адрес, в отличие от некоторых старых стандартов, таких как ERC-721.
    Гибкость: Поддерживает создание как взаимозаменяемых, так и уникальных (невзаимозаменяемых) активов в одном контракте. Также позволяет использовать полувзаимозаменяемые токены, которые ведут себя как взаимозаменяемые до момента погашения.
    Эффективность: Объединение разных типов активов в одном контракте снижает сложность и стоимость разработки, а также потребление сетевых ресурсов. 
*/

/*
Полный спектр услуг включает в себя:

• Концептуализация, упаковка проекта
• Отрисовка "main character", NFT коллекции
• Генерация .json метадаты, выгрузка в IPFS
• Разработка, деплой смарт контракта
• Реализация минтинг функцонала
• Cоздание маркетинг стратегии
• Макертинг и продвижение
• Сопровождение минта
*/

contract NFT is ERC721, Ownable {
    uint256 private _nextTokenId;
    // uint256 private _priceInWei;
    uint256 private immutable _maxSupply; // immutable to optimize gas
    uint256 public constant PRICE = 0.01 ether;

    constructor(address initialOwner, uint256 _supply)
        ERC721("SolidityDev", "SD")
        Ownable(initialOwner)
    {
        _maxSupply = _supply;
    }

    // forge-lint: disable-next-line(mixed-case-function)
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmPMc4tcBsMqLRuCQtPmPe84bpSjrC3Ky7t3JWuHXYB4aS/";
    }

    function safeMint(address to) public onlyOwner {
        require(_nextTokenId < _maxSupply, "max supply reached");
        require(balanceOf(to) == 0, "user already have NFT");

        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    function buy() public payable {
        require(_nextTokenId < _maxSupply, "max supply reached");
        require(balanceOf(msg.sender) == 0, "user already have NFT");
        require(msg.value >= PRICE, "insufficient funds");

        uint256 tokenId = _nextTokenId++;
        _safeMint(msg.sender, tokenId);
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "nothing to withdraw");
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "withdraw failed");
    }
}
