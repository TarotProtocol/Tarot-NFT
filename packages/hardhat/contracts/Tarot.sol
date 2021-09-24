// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Tarot is ERC721Enumerable, ReentrancyGuard, Ownable {

	uint256 private tarotSpreadPrice = 0.020 ether;

	uint256 private maxPublicTokenId = 7000;
	uint256 private maxTokenId = 7777;

	string[] private tarotCards = [
		"The Fool",
		"The Magician",
		"The High Pristess",
		"The Empress",
		"The Emperor",
		"The Heirophant",
		"The Lovers",
		"The Chariot",
		"Strength",
		"The Hermit",
		"The Wheel of Fortune",
		"Justice",
		"The Hanged Man",
		"Death",
		"Temperance",
		"The Devil",
		"The Tower",
		"The Star",
		"The Moon",
		"The Sun",
		"Judgement",
		"The World",
		"Ace of Wands",
		"Two of Wands",
		"Three of Wands",
		"Four of Wands",
		"Five of Wands",
		"Six of Wands",
		"Seven of Wands",
		"Eight of Wands",
		"Nine of Wands",
		"Ten of Wands",
		"Page of Wands",
		"Knight of Wands",
		"Queen of Wands",
		"King of Wands",
		"Ace of Cups",
		"Two of Cups",
		"Three of Cups",
		"Four of Cups",
		"Five of Cups",
		"Six of Cups",
		"Seven of Cups",
		"Eight of Cups",
		"Nine of Cups",
		"Ten of Cups",
		"Page of Cups",
		"Knight of Cups",
		"Queen of Cups",
		"King of Cups",
		"Ace of Swords",
		"Two of Swords",
		"Three of Swords",
		"Four of Swords",
		"Five of Swords",
		"Six of Swords",
		"Seven of Swords",
		"Eight of Swords",
		"Nine of Swords",
		"Ten of Swords",
		"Page of Swords",
		"Knight of Swords",
		"Queen of Swords",
		"King of Swords",
		"Ace of Pentacles",
		"Two of Pentacles",
		"Three of Pentacles",
		"Four of Pentacles",
		"Five of Pentacles",
		"Six of Pentacles",
		"Seven of Pentacles",
		"Eight of Pentacles",
		"Nine of Pentacles",
		"Ten of Pentacles",
		"Page of Pentacles",
		"Knight of Pentacles",
		"Queen of Pentacles",
		"King of Pentacles"
	];

	uint256 public nextTokenId;

	function random(bytes32 seed) private view returns (uint) {
		return uint(keccak256(abi.encodePacked(seed, block.difficulty, block.timestamp, msg.sender)));
	}

	function drawCard(bytes memory cardPos, uint256 tokenId, bool[78] memory cardDrawn) public view returns (string memory) {
		uint cardNum;

		// Draw card until the card drawn isn't drawn before
		do {
			cardNum = random(keccak256(abi.encodePacked(cardPos, tokenId))) % tarotCards.length;
		} while (cardDrawn[cardNum] == true);

		cardDrawn[cardNum] = true;
		string memory output = tarotCards[cardNum];

		if (random(keccak256(abi.encodePacked("orientation", cardPos, tokenId))) % 2 == 1) {
			output = string(abi.encodePacked(output, " (r)"));
		}
		return output;
	}

	function tokenURI(uint256 tokenId) override public view returns (string memory) {
		bool[78] memory cardDrawn;

		string[17] memory parts;
		parts[0]  = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; text-anchor: middle }</style><rect width="100%" height="100%" fill="black" /><polygon points="175,15 300,248 50,248" stroke="#444444" stroke-width="3" /><polygon points="175,310 50,95 300,95 " stroke="#444444" stroke-width="3" /><text x="175" y="21" class="base">'; // 1
		parts[1]  = drawCard("past", tokenId, cardDrawn);
		parts[2]  = '</text><text x="280" y="252" class="base">'; // 2
		parts[3]  = drawCard("present",	 tokenId, cardDrawn);
		parts[4]  = '</text><text x="70"  y="252" class="base">'; // 3
		parts[5]  = drawCard("future",	  tokenId, cardDrawn);
		parts[6]  = '</text><text x="175" y="319" class="base">'; // 4
		parts[7]  = drawCard("situation",   tokenId, cardDrawn);
		parts[8]  = '</text><text x="70"  y="98" class="base">'; // 5
		parts[9]  = drawCard("obstacle",	tokenId, cardDrawn);
		parts[10] = '</text><text x="280" y="98" class="base">'; // 6
		parts[11] = drawCard("opportunity", tokenId, cardDrawn);
		parts[12] = '</text><text x="175" y="175" class="base">'; // 7
		parts[13] = drawCard("advice",	  tokenId, cardDrawn);
		parts[14] = '</text></svg>';

		string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2], parts[3], parts[4], parts[5], parts[6], parts[7], parts[8]));
		output = string(abi.encodePacked(output, parts[9], parts[10], parts[11], parts[12], parts[13], parts[14]));

		string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Tarot Spread #', toString(tokenId), '", "description": "If there is such thing as destiny, one is destined to make one\'s own destiny.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
		output = string(abi.encodePacked('data:application/json;base64,', json));

		return output;
	}

	function claimNext() external payable nonReentrant {
		require(nextTokenId < maxPublicTokenId + 1, "Token ID invalid");
		require(msg.value == tarotSpreadPrice);
		_safeMint(_msgSender(), nextTokenId);
		nextTokenId++;
	}

	function ownerClaim(uint256 tokenId) external nonReentrant onlyOwner {
		require(tokenId > maxPublicTokenId && tokenId < maxTokenId + 1, "Token ID invalid");
		_safeMint(owner(), tokenId);
	}

	function remainingPublicTokens() external nonReentrant returns (uint256) {
		return maxPublicTokenId - nextTokenId + 1;
	}

	function withdraw(uint amount) external onlyOwner returns(bool) {
		require(amount <= address(this).balance);
		payable(owner()).transfer(amount);
		return true;

	}

	function toString(uint256 value) internal pure returns (string memory) {
	// Inspired by OraclizeAPI's implementation - MIT license
	// https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

		if (value == 0) {
			return "0";
		}
		uint256 temp = value;
		uint256 digits;
		while (temp != 0) {
			digits++;
			temp /= 10;
		}
		bytes memory buffer = new bytes(digits);
		while (value != 0) {
			digits -= 1;
			buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
			value /= 10;
		}
		return string(buffer);
	}

	constructor() ERC721("Tarot Protocol", "TAROT") Ownable() {
		nextTokenId = 1;
	}
}

/// [MIT License]
/// @title Base64
/// @notice Provides a function for encoding some bytes in base64
/// @author Brecht Devos <brecht@loopring.org>
library Base64 {
	bytes internal constant TABLE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

	/// @notice Encodes some bytes to the base64 representation
	function encode(bytes memory data) internal pure returns (string memory) {
		uint256 len = data.length;
		if (len == 0) return "";

		// multiply by 4/3 rounded up
		uint256 encodedLen = 4 * ((len + 2) / 3);

		// Add some extra buffer at the end
		bytes memory result = new bytes(encodedLen + 32);

		bytes memory table = TABLE;

		assembly {
			let tablePtr := add(table, 1)
			let resultPtr := add(result, 32)

			for {
				let i := 0
			} lt(i, len) {

			} {
				i := add(i, 3)
				let input := and(mload(add(data, i)), 0xffffff)

				let out := mload(add(tablePtr, and(shr(18, input), 0x3F)))
				out := shl(8, out)
				out := add(out, and(mload(add(tablePtr, and(shr(12, input), 0x3F))), 0xFF))
				out := shl(8, out)
				out := add(out, and(mload(add(tablePtr, and(shr(6, input), 0x3F))), 0xFF))
				out := shl(8, out)
				out := add(out, and(mload(add(tablePtr, and(input, 0x3F))), 0xFF))
				out := shl(224, out)

				mstore(resultPtr, out)

				resultPtr := add(resultPtr, 4)
			}

			switch mod(len, 3)
			case 1 {
				mstore(sub(resultPtr, 2), shl(240, 0x3d3d))
			}
			case 2 {
				mstore(sub(resultPtr, 1), shl(248, 0x3d))
			}

			mstore(result, encodedLen)
		}

		return string(result);
	}
}
