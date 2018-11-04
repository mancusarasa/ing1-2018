!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Tests'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Tests'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 19:48:13'!
test01

	| theGame | 
	
	theGame := TerniLapilli new.
	self deny: (theGame began).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 19:48:58'!
test02

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	self assert: (theGame began).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 19:52:00'!
test03

	| theGame | 
	
	theGame := TerniLapilli new.
	self deny: (theGame positionIsTaken: (1@1)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 19:53:14'!
test04

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	self assert: (theGame positionIsTaken: (1@1)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 19:59:45'!
test05

	| theGame | 
	
	theGame := TerniLapilli new.
	self deny: (theGame positionIsTakenByPlayerOne: (1@1)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 19:59:33'!
test06

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	self assert: (theGame positionIsTakenByPlayerOne: (1@1)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:15:09'!
test07

	| theGame | 
	
	theGame := TerniLapilli new.
	self should: [theGame playerTwoPlacesTokenAt: (1@1).] raise: Error withExceptionDo: [:anError |
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorTurnoIncorrecto .
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:18:03'!
test08

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	self assert: (theGame positionIsTaken: (1@2)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:23:38'!
test09

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	self assert: (theGame positionIsTakenByPlayerTwo: (1@2)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:28:52'!
test10PlayerTwoShouldntBeAbleToPlaceTokenOnPositionAlreadyTaken

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	
	self should: [theGame playerTwoPlacesTokenAt: (1@1).] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorPosicionTomada.
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:30:52'!
test11PlayerOneShouldntBeAbleToPlaceTokenOnPositionAlreadyTaken

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	
	self should: [theGame playerOnePlacesTokenAt: (1@2).] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorPosicionTomada.
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 11:26:35'!
test12PlayerOneCannotPlayMoreThanThreeTokens

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@1).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	
	self should: [theGame playerOnePlacesTokenAt: (3@1).] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorCantidadDeFichasExcedida.
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:04:36'!
test13PlayerOneDidntWin

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (3@3).
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (3@2).

	self deny: theGame playerOneWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:02:00'!
test14PlayerOneCanWinHorizontally

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (3@3).
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (3@1).

	self assert: theGame playerOneWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:02:14'!
test15PlayerOneCanWinVertically

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (1@1).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (2@3).

	self assert: theGame playerOneWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:05:53'!
test16PlayerOneCanWinDiagonally

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (3@3).

	self assert: theGame playerOneWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:37:43'!
test17PlayerOneCanWinDiagonally2

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (3@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (1@3).

	self assert: theGame playerOneWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:25:25'!
test18PlayerTwoDidntWin

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (3@3).
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (3@2).

	self deny: theGame playerTwoWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:29:32'!
test19PlayerTwoCanWinHorizontally

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (3@3).
	theGame playerTwoPlacesTokenAt: (1@1).
	theGame playerOnePlacesTokenAt: (1@2).
	theGame playerTwoPlacesTokenAt: (2@1).
	theGame playerOnePlacesTokenAt: (3@2).
	theGame playerTwoPlacesTokenAt: (3@1).

	self assert: theGame playerTwoWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:38:03'!
test20PlayerTwoCanWinVertically

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (2@1).
	theGame playerOnePlacesTokenAt: (3@1).
	theGame playerTwoPlacesTokenAt: (2@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	self assert: theGame playerTwoWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:34:33'!
test21PlayerTwoCanWinDiagonally

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (1@1).
	theGame playerOnePlacesTokenAt: (3@2).
	theGame playerTwoPlacesTokenAt: (2@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (3@3).
	self assert: theGame playerTwoWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:49:06'!
test22PlayerTwoCanWinDiagonally2

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (3@1).
	theGame playerOnePlacesTokenAt: (1@2).
	theGame playerTwoPlacesTokenAt: (2@2).
	theGame playerOnePlacesTokenAt: (3@2).
	theGame playerTwoPlacesTokenAt: (1@3).
	self assert: theGame playerTwoWon. 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:35:07'!
test23PlayerOneCanMoveATokenOnlyIfAllTokensHaveBeenPlayed

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).

	self should: [theGame playerOneMoves: (1@1) to: (2@1)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorTodaviaNoSeUsaronTodasLasFichas.
	].
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:38:41'!
test24PlayerOneCanMoveATokenOnlyIfItsHisTurn

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (3@3).
	
	self should: [theGame playerOneMoves: (1@1) to: (2@1)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorTurnoIncorrecto .
	].
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:38:47'!
test25PlayerOneCanMoveAToken

	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	theGame playerOneMoves: (1@1) to: (2@1).

	self assert: (theGame positionIsTakenByPlayerOne: (2@1)).
	self deny: (theGame positionIsTakenByPlayerOne: (1@1)).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:42:16'!
test26PlayerOneCanMoveATokenOnlyIfHeOwnsTheToken
	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	self should: [theGame playerOneMoves: (2@3) to: (3@3)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorMovimientoInvalido .
	].
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:44:47'!
test27PlayerOneCanMoveATokenOnlyIfTheNewPositionIsFree
	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	self should: [theGame playerOneMoves: (1@1) to: (1@2)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorMovimientoInvalido .
	].
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:08:15'!
test28PlayerOneCanWinByMovingAToken
	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (2@3).
	theGame playerOnePlacesTokenAt: (3@2).
	theGame playerTwoPlacesTokenAt: (3@3).
	
	theGame playerOneMoves: (3@2) to: (3@1).
	self assert: theGame playerOneWon.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:08:12'!
test29TheGameIsntOverIfNobodyWon
	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).

	self deny: theGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:08:09'!
test30TheGameIsOverIfPlayerOneWon
	| theGame | 
	
	theGame := TerniLapilli new.
	
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (3@3).
	theGame playerOnePlacesTokenAt: (2@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (3@1).

	self assert: theGame isOver.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:08:06'!
test31TheGameIsOverIfPlayerTwoWon
	| theGame | 
	
	theGame := TerniLapilli new.
	
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (2@1).
	theGame playerOnePlacesTokenAt: (3@1).
	theGame playerTwoPlacesTokenAt: (2@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).

	self assert: theGame isOver.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:10:19'!
test32PlayerOneCannotAddATokenIfTheGameIsOver
	| theGame | 
	
	theGame := TerniLapilli new.
	
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (2@1).
	theGame playerOnePlacesTokenAt: (3@1).
	theGame playerTwoPlacesTokenAt: (2@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).

	self should: [theGame playerOnePlacesTokenAt: (1@2).] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorJuegoFinalizado .
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:12:32'!
test33PlayerOneCannotMoveATokenIfTheGameIsOver
	| theGame | 
	
	theGame := TerniLapilli new.
	
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (2@1).
	theGame playerOnePlacesTokenAt: (3@1).
	theGame playerTwoPlacesTokenAt: (2@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).

	self should: [theGame playerOneMoves: (1@1) to: (1@2).] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorJuegoFinalizado .
	].! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:57:05'!
test34PlayerOneCanMoveATokenOnlyIfTheNewPositionIsInTheBoard
	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	self should: [theGame playerOneMoves: (1@1) to: (-1@1)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorMovimientoInvalido .
	].
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:07:09'!
test35PlayerOneCanMoveATokenOnlyIfTheNewPositionIsReachable
	| theGame | 
	
	theGame := TerniLapilli new.
	theGame playerOnePlacesTokenAt: (1@1).
	theGame playerTwoPlacesTokenAt: (1@2).
	theGame playerOnePlacesTokenAt: (2@2).
	theGame playerTwoPlacesTokenAt: (3@2).
	theGame playerOnePlacesTokenAt: (1@3).
	theGame playerTwoPlacesTokenAt: (2@3).
	
	self should: [theGame playerOneMoves: (1@1) to: (3@1)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorMovimientoInvalido .
	].
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:20:02'!
test36PlayerOneCannotPlaceATokenOutsideTheBoard
	| theGame | 
	
	theGame := TerniLapilli new.
	
	self should: [theGame playerOnePlacesTokenAt: (-1@1)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorPosicionInvalida .
	].
	self should: [theGame playerOnePlacesTokenAt: (4@1)] raise: Error withExceptionDo: [ :anError|
		self assert: anError messageText equals: TerniLapilli mensajeDeErrorPosicionInvalida .
	].
! !
