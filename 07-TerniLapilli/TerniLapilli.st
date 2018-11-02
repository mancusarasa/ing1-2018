!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playerOneTakenPositions playerTwoTakenPositions turnPlayerOne'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:01:37'!
began

	^ playerOneTakenPositions isEmpty not! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:21:38'!
initialize

	playerOneTakenPositions := OrderedCollection new.
	playerTwoTakenPositions := OrderedCollection new.
	turnPlayerOne := true.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:35:12'!
playerOnePlacesTokenAt: aPoint 
	
	turnPlayerOne ifFalse: [^self error: self class mensajeDeErrorTurnoIncorrecto].
	(self positionIsTaken: aPoint) ifTrue: [^self error: self class mensajeDeErrorPosicionTomada].
	turnPlayerOne := turnPlayerOne not.
	playerOneTakenPositions add: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:31:23'!
playerTwoPlacesTokenAt: aPoint 
	
	turnPlayerOne ifTrue: [^self error: self class mensajeDeErrorTurnoIncorrecto].
	(self positionIsTaken: aPoint) ifTrue: [^self error: self class mensajeDeErrorPosicionTomada].
	turnPlayerOne := turnPlayerOne not.
	playerTwoTakenPositions add: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:23:18'!
positionIsTaken: aPoint 

	^ (self positionIsTakenByPlayerOne: aPoint) or: [self positionIsTakenByPlayerTwo: aPoint].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:01:53'!
positionIsTakenByPlayerOne: aPoint 

	^ playerOneTakenPositions includes: aPoint ! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:22:45'!
positionIsTakenByPlayerTwo: aPoint 

	^ playerTwoTakenPositions includes: aPoint ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:28:15'!
mensajeDeErrorPosicionTomada

	^ 'laPosicionYaEstabaTomada'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:14:52'!
mensajeDeErrorTurnoIncorrecto

	^ 'noEsTuTurno'! !
