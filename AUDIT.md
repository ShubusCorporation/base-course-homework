$ slither .
'forge clean' running (wd: D:\Sources\SOLIDITY\homework)
'forge config --json' running
'forge build --build-info --skip */test/** */script/** --force' running (wd: D:\Sources\SOLIDITY\homework)
---> out\build-info\c24f75ebd7782499.json
---> out\build-info\bf916c85f8ec31e9.json
INFO:SlitherSolcParsing:No contracts were found in None, check the correct compilation
INFO:Detectors:
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) has bitwise-xor operator ^ instead of the exponentiation operator **: 
         - inverse = (3 * denominator) ^ 2 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#254)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-exponentiation
INFO:Detectors:
Store.findProduct(uint256).product (src/Store.sol#127) is a storage variable never initialized
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#uninitialized-storage-variables
INFO:Detectors:
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse = (3 * denominator) ^ 2 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#254)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#257)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:        
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#259)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:        
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#259-260)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:        
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#260-261)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:        
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#261-262)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:        
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#237)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#262-263)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) performs a multiplication on the result of a division:        
        - low = low / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#239)
        - result = low * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#269)
Math.invMod(uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#308-352) performs a multiplication on the result of a division:
        - quotient = gcd / remainder (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#326-327)
        - (gcd,remainder) = (remainder,gcd - remainder * quotient) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#327-340)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply
INFO:Detectors:
Election.vote(uint256) (src/Election.sol#42-54) should emit an event for:
        - leader = _candidateIndex (src/Election.sol#54)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-events-arithmetic
INFO:Detectors:
Election.vote(uint256) (src/Election.sol#42-54) uses timestamp for comparisons
        Dangerous comparisons:
        - require(bool,error)(block.timestamp < electionEndTime,Errors.ElectionIsOver()) (src/Election.sol#46-47)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp
INFO:Detectors:
ERC721Utils.checkOnERC721Received(address,address,address,uint256,bytes) (lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Utils.sol#23-46) uses assembly        - INLINE ASM (lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Utils.sol#42-44)
Panic.panic(uint256) (lib/openzeppelin-contracts/contracts/utils/Panic.sol#49-53) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Panic.sol#50-53)
Strings.toString(uint256) (lib/openzeppelin-contracts/contracts/utils/Strings.sol#43-59) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#48-51)
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#53-56)
Strings.toChecksumHexString(address) (lib/openzeppelin-contracts/contracts/utils/Strings.sol#108-124) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#112-115)
Strings.escapeJSON(string) (lib/openzeppelin-contracts/contracts/utils/Strings.sol#440-462) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#459-461)
Strings._unsafeReadBytesOffset(bytes,uint256) (lib/openzeppelin-contracts/contracts/utils/Strings.sol#470-481) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#479-481)
Math.add512(uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#23-28) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#25-28)
Math.mul512(uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#35-44) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#40-44)
Math.tryMul(uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#71-81) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#73-78)
Math.tryDiv(uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#87-93) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#89-93)
Math.tryMod(uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#100-106) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#102-106)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199-269) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#222-229)
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#236-244)
Math.tryModExp(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#404-423) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#405-422)
Math.tryModExp(bytes,bytes,bytes) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#436-462) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#447-462)
Math.log2(uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#592-640) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#638-640)
SafeCast.toUint(bool) (lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#1120-1124) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#1122-1123)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Election.vote(uint256) (src/Election.sol#42-54) compares to a boolean constant:
        -require(bool,error)(stopped == false,Errors.VotingIsStopped()) (src/Election.sol#47-48)
Election.vote(uint256) (src/Election.sol#42-54) compares to a boolean constant:
        -require(bool,error)(alreadyVoted[msg.sender] == false,Errors.ElectorAlreadyVoted()) (src/Election.sol#45-46)
Election.getElectionWinner() (src/Election.sol#55-63) compares to a boolean constant:
        -require(bool,error)(stopped == true,Errors.VotingIsNotStopped()) (src/Election.sol#59-60)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#boolean-equality
INFO:Detectors:
8 different versions of Solidity are used:
        - Version constraint ^0.8.20 is used by:
                -^0.8.20 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Utils.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Panic.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Strings.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#2-4)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#3-5)
                -^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#2-4)
        - Version constraint >=0.8.4 is used by:
                ->=0.8.4 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#2-3)
        - Version constraint >=0.6.2 is used by:
                ->=0.6.2 (lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#2-4)
                ->=0.6.2 (lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#2-4)
        - Version constraint >=0.5.0 is used by:
                ->=0.5.0 (lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#2-4)
        - Version constraint >=0.4.16 is used by:
                ->=0.4.16 (lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#2-4)
        - Version constraint ^0.8.30 is used by:
                -^0.8.30 (src/Election.sol#1-2)
                -^0.8.30 (src/ElectionErrors.sol#1-2)
        - Version constraint ^0.8.22 is used by:
                -^0.8.22 (src/NFT.sol#2-3)
        - Version constraint ^0.8.28 is used by:
                -^0.8.28 (src/Store.sol#1-2)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Version constraint ^0.8.20 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - VerbatimInvalidDeduplication
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess.
It is used by:
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC721/utils/ERC721Utils.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Panic.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Strings.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#2-4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol#3-5)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#2-4)
Version constraint >=0.8.4 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - FullInlinerNonExpressionSplitArgumentEvaluationOrder
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - DataLocationChangeInInternalOverride
        - NestedCalldataArrayAbiReencodingSizeValidation
        - SignedImmutables.
It is used by:
        - >=0.8.4 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#2-3)
Version constraint >=0.6.2 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - MissingSideEffectsOnSelectorAccess
        - AbiReencodingHeadOverflowWithStaticArrayCleanup
        - DirtyBytesArrayToStorage
        - NestedCalldataArrayAbiReencodingSizeValidation
        - ABIDecodeTwoDimensionalArrayMemory
        - KeccakCaching
        - EmptyByteArrayCopy
        - DynamicArrayCleanup
        - MissingEscapingInFormatting
        - ArraySliceDynamicallyEncodedBaseType
        - ImplicitConstructorCallvalueCheck
        - TupleAssignmentMultiStackSlotComponents
        - MemoryArrayCreationOverflow.
It is used by:
        - >=0.6.2 (lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#2-4)
        - >=0.6.2 (lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#2-4)
Version constraint >=0.5.0 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - DirtyBytesArrayToStorage
        - ABIDecodeTwoDimensionalArrayMemory
        - KeccakCaching
        - EmptyByteArrayCopy
        - DynamicArrayCleanup
        - ImplicitConstructorCallvalueCheck
        - TupleAssignmentMultiStackSlotComponents
        - MemoryArrayCreationOverflow
        - privateCanBeOverridden
        - SignedArrayStorageCopy
        - ABIEncoderV2StorageArrayWithMultiSlotElement
        - DynamicConstructorArgumentsClippedABIV2
        - UninitializedFunctionPointerInConstructor
        - IncorrectEventSignatureInLibraries
        - ABIEncoderV2PackedStorage.
It is used by:
        - >=0.5.0 (lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#2-4)
Version constraint >=0.4.16 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - DirtyBytesArrayToStorage
        - ABIDecodeTwoDimensionalArrayMemory
        - KeccakCaching
        - EmptyByteArrayCopy
        - DynamicArrayCleanup
        - ImplicitConstructorCallvalueCheck
        - TupleAssignmentMultiStackSlotComponents
        - MemoryArrayCreationOverflow
        - privateCanBeOverridden
        - SignedArrayStorageCopy
        - ABIEncoderV2StorageArrayWithMultiSlotElement
        - DynamicConstructorArgumentsClippedABIV2
        - UninitializedFunctionPointerInConstructor_0.4.x
        - IncorrectEventSignatureInLibraries_0.4.x
        - ExpExponentCleanup
        - NestedArrayFunctionCallDecoder
        - ZeroFunctionSelector.
It is used by:
        - >=0.4.16 (lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#2-4)
Version constraint ^0.8.22 contains known severe issues (https://solidity.readthedocs.io/en/latest/bugs.html)
        - VerbatimInvalidDeduplication.
It is used by:
        - ^0.8.22 (src/NFT.sol#2-3)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Parameter Election.vote(uint256)._candidateIndex (src/Election.sol#42-43) is not in mixedCase
Parameter Store.buy(uint256,uint256)._id (src/Store.sol#30) is not in mixedCase
Parameter Store.buy(uint256,uint256)._quantity (src/Store.sol#31-32) is not in mixedCase
Parameter Store.batchBuy(uint256[],uint256[])._ids (src/Store.sol#43-46) is not in mixedCase
Parameter Store.batchBuy(uint256[],uint256[])._quantitys (src/Store.sol#47) is not in mixedCase
Parameter Store.addProduct(string,uint256,uint256,uint256)._name (src/Store.sol#88-90) is not in mixedCase
Parameter Store.addProduct(string,uint256,uint256,uint256)._id (src/Store.sol#90) is not in mixedCase
Parameter Store.addProduct(string,uint256,uint256,uint256)._stock (src/Store.sol#90) is not in mixedCase
Parameter Store.addProduct(string,uint256,uint256,uint256)._price (src/Store.sol#90-92) is not in mixedCase
Parameter Store.deleteProduct(uint256)._id (src/Store.sol#95-96) is not in mixedCase
Parameter Store.updatePrice(uint256,uint256)._id (src/Store.sol#103) is not in mixedCase
Parameter Store.updatePrice(uint256,uint256)._price (src/Store.sol#103) is not in mixedCase
Parameter Store.updateStock(uint256,uint256)._id (src/Store.sol#108) is not in mixedCase
Parameter Store.updateStock(uint256,uint256)._stock (src/Store.sol#108) is not in mixedCase
Parameter Store.getPrice(uint256)._id (src/Store.sol#117) is not in mixedCase
Parameter Store.getStock(uint256)._id (src/Store.sol#121-122) is not in mixedCase
Parameter Store.findProduct(uint256)._id (src/Store.sol#126-127) is not in mixedCase
Parameter Store.isIdExist(uint256)._id (src/Store.sol#134-135) is not in mixedCase
Parameter Store.findIndexById(uint256)._id (src/Store.sol#143) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Math.log2(uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#592-640) uses literals with too many digits:
        - r = r | byte(uint256,uint256)(x >> r,0x0000010102020202030303030303030300000000000000000000000000000000) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#638-640)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#too-many-digits
INFO:Detectors:
NFT._priceInWei (src/NFT.sol#9-10) is never used in NFT (src/NFT.sol#6-44)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#unused-state-variable
INFO:Detectors:
Loop condition i < products.length (src/Store.sol#128-131) should use cached array length instead of referencing `length` member of the storage array.
 Loop condition i < products.length (src/Store.sol#137-138) should use cached array length instead of referencing `length` member of the storage array.
 Loop condition i < products.length (src/Store.sol#145-147) should use cached array length instead of referencing `length` member of the storage array.
 Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#cache-array-length
INFO:Detectors:
NFT._priceInWei (src/NFT.sol#9-10) should be constant
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-constant
INFO:Detectors:
NFT._maxSupply (src/NFT.sol#10-11) should be immutable
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
INFO:Slither:. analyzed (20 contracts with 100 detectors), 65 result(s) found
