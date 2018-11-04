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

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:06:38'!
isOver
	 ^ self playerOneWon or: [self playerTwoWon ].! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:06:11'!
playerOneMoves: currentPosition to: newPosition.
	
	(playerOneTakenPositions size < 3) ifTrue: [^self error: self class mensajeDeErrorTodaviaNoSeUsaronTodasLasFichas ].
	turnPlayerOne ifFalse: [^self error: self class mensajeDeErrorTurnoIncorrecto].
	(self isOver) ifTrue:[^self error: self class mensajeDeErrorJuegoFinalizado].
	(self positionIsTakenByPlayerOne: currentPosition) ifFalse: [^self error: self class mensajeDeErrorMovimientoInvalido].
	((self positionIsInsideTheBoard: newPosition) and: [self position: newPosition isAdjacentTo: currentPosition]) ifFalse: [^self error: self class mensajeDeErrorMovimientoInvalido].
	(self positionIsTaken: newPosition ) ifTrue: [^self error: self class mensajeDeErrorMovimientoInvalido].
	
	turnPlayerOne := turnPlayerOne not.
	playerOneTakenPositions remove: currentPosition.
	playerOneTakenPositions add: newPosition.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:20:45'!
playerOnePlacesTokenAt: aPoint 
	
	(self isOver) ifTrue:[^self error: self class mensajeDeErrorJuegoFinalizado].
	(playerOneTakenPositions size >= 3) ifTrue: [^self error: self class mensajeDeErrorCantidadDeFichasExcedida].
	turnPlayerOne ifFalse: [^self error: self class mensajeDeErrorTurnoIncorrecto].
	(self positionIsInsideTheBoard: aPoint ) ifFalse: [^self error: self class mensajeDeErrorPosicionInvalida].
	(self positionIsTaken: aPoint) ifTrue: [^self error: self class mensajeDeErrorPosicionTomada].

	
	turnPlayerOne := turnPlayerOne not.
	playerOneTakenPositions add: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:10:25'!
playerOneWon
	 #(1,2,3) do:[:index | ((playerOneTakenPositions select: [:e| (e y) = index]) size = 3) ifTrue:[^true]].
	 #(1,2,3) do:[:index | ((playerOneTakenPositions select: [:e| (e x) = index]) size = 3) ifTrue:[^true]].
	 ((playerOneTakenPositions select: [:e| (e x) = (e y)]) size = 3) ifTrue:[^true].
	 ((playerOneTakenPositions select: [:e| 4-(e x) = (e y)]) size = 3) ifTrue:[^true].
	 ^false.
		! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:21:50'!
playerTwoPlacesTokenAt: aPoint 
	
	(self isOver) ifTrue:[^self error: self class mensajeDeErrorJuegoFinalizado].
	(playerTwoTakenPositions size >= 3) ifTrue: [^self error: self class mensajeDeErrorCantidadDeFichasExcedida].
	turnPlayerOne ifTrue: [^self error: self class mensajeDeErrorTurnoIncorrecto].
	(self positionIsInsideTheBoard: aPoint ) ifFalse: [^self error: self class mensajeDeErrorPosicionInvalida].
	(self positionIsTaken: aPoint) ifTrue: [^self error: self class mensajeDeErrorPosicionTomada].

	
	turnPlayerOne := turnPlayerOne not.
	playerTwoTakenPositions add: aPoint.! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 12:27:29'!
playerTwoWon
	 #(1,2,3) do:[:index | ((playerTwoTakenPositions select: [:e| (e y) = index]) size = 3) ifTrue:[^true]].
	 #(1,2,3) do:[:index | ((playerTwoTakenPositions select: [:e| (e x) = index]) size = 3) ifTrue:[^true]].
	 ((playerTwoTakenPositions select: [:e| (e x) = (e y)]) size = 3) ifTrue:[^true].
	 ((playerTwoTakenPositions select: [:e| 4-(e x) = (e y)]) size = 3) ifTrue:[^true].
	 ^false.
		! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:11:26'!
position: newPosition isAdjacentTo: currentPosition
	
	^ (((newPosition x)-(currentPosition x)) abs < 2) and: [(((newPosition y)-(currentPosition y)) abs < 2)].
	! !

!TerniLapilli methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:18:30'!
positionIsInsideTheBoard: position 

	^ (((position x) > 0) and: [(position y) > 0]) and: [(((position x) < 4) and: [(position y) < 4])].
	! !

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

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 11:26:03'!
mensajeDeErrorCantidadDeFichasExcedida

	^ 'cantidadDeFichasExcedida'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 14:10:31'!
mensajeDeErrorJuegoFinalizado

	^ 'elJuegoTermino'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:42:41'!
mensajeDeErrorMovimientoInvalido

	^ 'movimientoInvalido'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 15:19:48'!
mensajeDeErrorPosicionInvalida

	^ 'laPosicionEsInvalida'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:28:15'!
mensajeDeErrorPosicionTomada

	^ 'laPosicionYaEstabaTomada'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'd 11/4/2018 13:33:26'!
mensajeDeErrorTodaviaNoSeUsaronTodasLasFichas

	^ 'quedanFichasSinUsar'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'ps 11/1/2018 20:14:52'!
mensajeDeErrorTurnoIncorrecto

	^ 'noEsTuTurno'! !
