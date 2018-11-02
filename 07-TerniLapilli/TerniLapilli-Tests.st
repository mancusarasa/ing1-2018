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
