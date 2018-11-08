!classDefinition: #AdjacentPositionInTheBoard category: #TerniLapilli!
Object subclass: #AdjacentPositionInTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AdjacentPositionInTheBoard methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:52:57'!
assertPositionsAreAdjacent

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AdjacentPositionInTheBoard class' category: #TerniLapilli!
AdjacentPositionInTheBoard class
	instanceVariableNames: ''!

!AdjacentPositionInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:52:19'!
matches: aPosition and: anotherPosition

	self subclassResponsibility ! !

!AdjacentPositionInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:55:15'!
position: newPosition isAdjacentTo: currentPosition
	
	^ (((newPosition x)-(currentPosition x)) abs < 2) and: [(((newPosition y)-(currentPosition y)) abs < 2)]! !

!AdjacentPositionInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:52:39'!
with: aPosition and: anotherPosition

	^ (self subclasses detect: [ :aSubclass | aSubclass matches: aPosition and: anotherPosition]) new! !


!classDefinition: #PositionIsAdjacent category: #TerniLapilli!
AdjacentPositionInTheBoard subclass: #PositionIsAdjacent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionIsAdjacent methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:53:04'!
assertPositionsAreAdjacent! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionIsAdjacent class' category: #TerniLapilli!
PositionIsAdjacent class
	instanceVariableNames: ''!

!PositionIsAdjacent class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:55:43'!
matches: aPosition and: anotherPosition

	^ super position: aPosition isAdjacentTo: anotherPosition! !


!classDefinition: #PositionIsNotAdjacent category: #TerniLapilli!
AdjacentPositionInTheBoard subclass: #PositionIsNotAdjacent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionIsNotAdjacent methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:53:49'!
assertPositionsAreAdjacent

	^ self error: TerniLapilli mensajeDeErrorMovimientoInvalido! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionIsNotAdjacent class' category: #TerniLapilli!
PositionIsNotAdjacent class
	instanceVariableNames: ''!

!PositionIsNotAdjacent class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:55:53'!
matches: aPosition and: anotherPosition

	^ (super position: aPosition isAdjacentTo: anotherPosition) not! !


!classDefinition: #AmountOfPlayedTokensStatus category: #TerniLapilli!
Object subclass: #AmountOfPlayedTokensStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AmountOfPlayedTokensStatus methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:18:24'!
assertAllTokensWherePlayed

	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AmountOfPlayedTokensStatus class' category: #TerniLapilli!
AmountOfPlayedTokensStatus class
	instanceVariableNames: ''!

!AmountOfPlayedTokensStatus class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:15:47'!
matches: aTerniLapilli

	^ self subclassResponsibility ! !

!AmountOfPlayedTokensStatus class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:15:32'!
with: aTerniLapilli

	^ (self subclasses detect: [ :aSubclass | aSubclass matches: aTerniLapilli]) new! !


!classDefinition: #AmountReached category: #TerniLapilli!
AmountOfPlayedTokensStatus subclass: #AmountReached
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!AmountReached methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:18:34'!
assertAllTokensWherePlayed! !

!AmountReached methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:20:54'!
assertThereAreRemainingTokensToPlay

	self error: TerniLapilli mensajeDeErrorCantidadDeFichasExcedida ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AmountReached class' category: #TerniLapilli!
AmountReached class
	instanceVariableNames: ''!

!AmountReached class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:18:01'!
matches: aTerniLapilli

	^ ((aTerniLapilli positionsTakenByPlayerTwo size) + (aTerniLapilli positionsTakenByPlayerTwo size)) >= 6! !


!classDefinition: #UnplayedTokens category: #TerniLapilli!
AmountOfPlayedTokensStatus subclass: #UnplayedTokens
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!UnplayedTokens methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:20:25'!
assertAllTokensWherePlayed

	^ self error: TerniLapilli mensajeDeErrorTodaviaNoSeUsaronTodasLasFichas ! !

!UnplayedTokens methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:19:39'!
assertThereAreRemainingTokensToPlay! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'UnplayedTokens class' category: #TerniLapilli!
UnplayedTokens class
	instanceVariableNames: ''!

!UnplayedTokens class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:17:56'!
matches: aTerniLapilli

	^ ((aTerniLapilli positionsTakenByPlayerTwo size) + (aTerniLapilli positionsTakenByPlayerTwo size)) < 6! !


!classDefinition: #FromAndToPositionsInTheBoard category: #TerniLapilli!
Object subclass: #FromAndToPositionsInTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!FromAndToPositionsInTheBoard methodsFor: 'validation' stamp: 'ps 11/7/2018 19:03:06'!
assertPositionsAreDifferent

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FromAndToPositionsInTheBoard class' category: #TerniLapilli!
FromAndToPositionsInTheBoard class
	instanceVariableNames: ''!

!FromAndToPositionsInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 19:05:09'!
matches: aPosition and: anotherPosition

	self subclassResponsibility ! !

!FromAndToPositionsInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 19:04:51'!
with: aPosition and: anotherPosition

	^ (self subclasses detect: [ :aSubclass | aSubclass matches: aPosition and: anotherPosition]) new! !


!classDefinition: #DifferentFromAndToPositionsInTheBoard category: #TerniLapilli!
FromAndToPositionsInTheBoard subclass: #DifferentFromAndToPositionsInTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!DifferentFromAndToPositionsInTheBoard methodsFor: 'validation' stamp: 'ps 11/7/2018 19:03:25'!
assertPositionsAreDifferent! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DifferentFromAndToPositionsInTheBoard class' category: #TerniLapilli!
DifferentFromAndToPositionsInTheBoard class
	instanceVariableNames: ''!

!DifferentFromAndToPositionsInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 19:06:03'!
matches: aPosition and: anotherPosition

	^ (aPosition = anotherPosition) not! !


!classDefinition: #EqualFromAndToPositionsInTheBoard category: #TerniLapilli!
FromAndToPositionsInTheBoard subclass: #EqualFromAndToPositionsInTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!EqualFromAndToPositionsInTheBoard methodsFor: 'validation' stamp: 'ps 11/7/2018 19:12:43'!
assertPositionsAreDifferent

	^ self error: TerniLapilli mensajeDeErrorPosicionesDeOrigenYDestinoIguales! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EqualFromAndToPositionsInTheBoard class' category: #TerniLapilli!
EqualFromAndToPositionsInTheBoard class
	instanceVariableNames: ''!

!EqualFromAndToPositionsInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 19:06:45'!
matches: aPosition and: anotherPosition

	^ (aPosition = anotherPosition)! !


!classDefinition: #GameEndingStatus category: #TerniLapilli!
Object subclass: #GameEndingStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!GameEndingStatus methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:06:33'!
assertNotOver

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameEndingStatus class' category: #TerniLapilli!
GameEndingStatus class
	instanceVariableNames: ''!

!GameEndingStatus class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 18:52:22'!
matches: aTerniLapilli

	self subclassResponsibility ! !

!GameEndingStatus class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 18:52:55'!
with: aTerniLapilli

	^ (self subclasses detect: [ :aSubClass | aSubClass matches: aTerniLapilli]) new! !


!classDefinition: #Over category: #TerniLapilli!
GameEndingStatus subclass: #Over
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Over methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:07:18'!
assertNotOver

	^ self error: TerniLapilli mensajeDeErrorJuegoFinalizado! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Over class' category: #TerniLapilli!
Over class
	instanceVariableNames: ''!

!Over class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 18:52:32'!
matches: aTerniLapilli

	^ aTerniLapilli isOver! !


!classDefinition: #Playing category: #TerniLapilli!
GameEndingStatus subclass: #Playing
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Playing methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:06:21'!
assertNotOver! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Playing class' category: #TerniLapilli!
Playing class
	instanceVariableNames: ''!

!Playing class methodsFor: 'instance creation' stamp: 'ps 11/7/2018 18:52:41'!
matches: aTerniLapilli

	^ aTerniLapilli isOver not! !


!classDefinition: #PlayValidator category: #TerniLapilli!
Object subclass: #PlayValidator
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayValidator methodsFor: 'as yet unclassified' stamp: 'd 11/8/2018 13:55:05'!
initializeWith: aTerniLapili
	
	terniLapilli := aTerniLapili .! !

!PlayValidator methodsFor: 'as yet unclassified' stamp: 'd 11/8/2018 14:13:30'!
validateMovementFrom: oldPosition to: newPosition onTurn: aTurn

	(GameEndingStatus with: terniLapilli) assertNotOver.
	aTurn perform: ('assert', self class player, 'CanPlay') asSymbol.
	(AmountOfPlayedTokensStatus with: terniLapilli) assertAllTokensWherePlayed.
	(PositionTakenByPlayer with: terniLapilli and: oldPosition) perform: ('assertPositionIsTakenBy', self class player) asSymbol.
	(PositionInTheBoard with: newPosition) assertPositionInsideTheBoard.
	(FromAndToPositionsInTheBoard with: oldPosition and: newPosition) assertPositionsAreDifferent.
	(AdjacentPositionInTheBoard with: newPosition and: oldPosition) assertPositionsAreAdjacent.
	(PositionTakenStatus with: terniLapilli and: newPosition) assertPositionNonTaken.! !

!PlayValidator methodsFor: 'as yet unclassified' stamp: 'd 11/8/2018 14:14:41'!
validateTokenPlacementAt: aPosition  onTurn: aTurn.

	(GameEndingStatus with: terniLapilli ) assertNotOver.
	aTurn perform: ('assert', self class player, 'CanPlay') asSymbol.
	(AmountOfPlayedTokensStatus with: terniLapilli ) assertThereAreRemainingTokensToPlay.
	(PositionInTheBoard with: aPosition) assertPositionInsideTheBoard.
	(PositionTakenStatus with: terniLapilli and: aPosition) assertPositionNonTaken.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayValidator class' category: #TerniLapilli!
PlayValidator class
	instanceVariableNames: ''!

!PlayValidator class methodsFor: 'as yet unclassified' stamp: 'd 11/8/2018 13:56:33'!
for: aTerniLapilli

	^ self new initializeWith: aTerniLapilli .! !


!classDefinition: #PlayerOnePlayValidator category: #TerniLapilli!
PlayValidator subclass: #PlayerOnePlayValidator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerOnePlayValidator class' category: #TerniLapilli!
PlayerOnePlayValidator class
	instanceVariableNames: ''!

!PlayerOnePlayValidator class methodsFor: 'as yet unclassified' stamp: 'd 11/8/2018 14:09:26'!
player
	^ 'PlayerOne'! !


!classDefinition: #PlayerTwoPlayValidator category: #TerniLapilli!
PlayValidator subclass: #PlayerTwoPlayValidator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayerTwoPlayValidator class' category: #TerniLapilli!
PlayerTwoPlayValidator class
	instanceVariableNames: ''!

!PlayerTwoPlayValidator class methodsFor: 'as yet unclassified' stamp: 'd 11/8/2018 14:09:46'!
player
	^ 'PlayerTwo'! !


!classDefinition: #PositionInTheBoard category: #TerniLapilli!
Object subclass: #PositionInTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionInTheBoard methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:32:49'!
assertPositionInsideTheBoard

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionInTheBoard class' category: #TerniLapilli!
PositionInTheBoard class
	instanceVariableNames: ''!

!PositionInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:42:46'!
matches: aPosition

	^ self subclassResponsibility! !

!PositionInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:36:49'!
positionIsInsideTheBoard: position 

	^ (((position x) > 0) and: [(position y) > 0]) and: [(((position x) < 4) and: [(position y) < 4])]! !

!PositionInTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:42:15'!
with: aPosition

	^ (self subclasses detect:[ :aSubclass | aSubclass matches: aPosition]) new! !


!classDefinition: #PositionInsideTheBoard category: #TerniLapilli!
PositionInTheBoard subclass: #PositionInsideTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionInsideTheBoard methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:32:57'!
assertPositionInsideTheBoard! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionInsideTheBoard class' category: #TerniLapilli!
PositionInsideTheBoard class
	instanceVariableNames: ''!

!PositionInsideTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:43:02'!
matches: aPosition

	^ self positionIsInsideTheBoard: aPosition ! !


!classDefinition: #PositionOutsideTheBoard category: #TerniLapilli!
PositionInTheBoard subclass: #PositionOutsideTheBoard
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionOutsideTheBoard methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 20:45:27'!
assertPositionInsideTheBoard

	^ self error: TerniLapilli mensajeDeErrorPosicionFueraDelTablero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionOutsideTheBoard class' category: #TerniLapilli!
PositionOutsideTheBoard class
	instanceVariableNames: ''!

!PositionOutsideTheBoard class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 20:43:28'!
matches: aPosition

	^ (self positionIsInsideTheBoard: aPosition) not! !


!classDefinition: #PositionTakenByPlayer category: #TerniLapilli!
Object subclass: #PositionTakenByPlayer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionTakenByPlayer methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:34:07'!
assertPositionIsTakenByPlayerOne

	^ self subclassResponsibility ! !

!PositionTakenByPlayer methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:34:11'!
assertPositionIsTakenByPlayerTwo

	^ self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionTakenByPlayer class' category: #TerniLapilli!
PositionTakenByPlayer class
	instanceVariableNames: ''!

!PositionTakenByPlayer class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:33:09'!
matches: aTerniLapilli and: aPosition

	^ self subclassResponsibility ! !

!PositionTakenByPlayer class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:38:00'!
with: aTerniLapilli and: aPosition

	^ (self subclasses detect: [ :aSubclass | aSubclass matches: aTerniLapilli and: aPosition]) new! !


!classDefinition: #PositionTakenByPlayerOne category: #TerniLapilli!
PositionTakenByPlayer subclass: #PositionTakenByPlayerOne
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionTakenByPlayerOne methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:34:48'!
assertPositionIsTakenByPlayerOne! !

!PositionTakenByPlayerOne methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:35:58'!
assertPositionIsTakenByPlayerTwo

	^ self error: TerniLapilli mensajeDeErrorMovimientoInvalido ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionTakenByPlayerOne class' category: #TerniLapilli!
PositionTakenByPlayerOne class
	instanceVariableNames: ''!

!PositionTakenByPlayerOne class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:33:31'!
matches: aTerniLapilli and: aPosition

	^ aTerniLapilli positionIsTakenByPlayerOne: aPosition! !


!classDefinition: #PositionTakenByPlayerTwo category: #TerniLapilli!
PositionTakenByPlayer subclass: #PositionTakenByPlayerTwo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionTakenByPlayerTwo methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:36:06'!
assertPositionIsTakenByPlayerOne

	^ self error: TerniLapilli mensajeDeErrorMovimientoInvalido ! !

!PositionTakenByPlayerTwo methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:34:55'!
assertPositionIsTakenByPlayerTwo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionTakenByPlayerTwo class' category: #TerniLapilli!
PositionTakenByPlayerTwo class
	instanceVariableNames: ''!

!PositionTakenByPlayerTwo class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:33:39'!
matches: aTerniLapilli and: aPosition

	^ aTerniLapilli positionIsTakenByPlayerTwo: aPosition! !


!classDefinition: #PositionTakenStatus category: #TerniLapilli!
Object subclass: #PositionTakenStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PositionTakenStatus methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:02:37'!
assertPositionNonTaken

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositionTakenStatus class' category: #TerniLapilli!
PositionTakenStatus class
	instanceVariableNames: ''!

!PositionTakenStatus class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:00:55'!
matches: aTerniLapilli and: aPosition

	^ self subclassResponsibility! !

!PositionTakenStatus class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:01:09'!
with: aTerniLapilli and: aPosition

	^ (self subclasses detect: [ :aSubclass | aSubclass matches: aTerniLapilli and: aPosition]) new! !


!classDefinition: #NonTakenPosition category: #TerniLapilli!
PositionTakenStatus subclass: #NonTakenPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!NonTakenPosition methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:03:10'!
assertPositionNonTaken! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonTakenPosition class' category: #TerniLapilli!
NonTakenPosition class
	instanceVariableNames: ''!

!NonTakenPosition class methodsFor: 'instance creation' stamp: 'ps 11/5/2018 21:01:54'!
matches: aTerniLapilli and: aPosition

	^ (aTerniLapilli positionIsTaken: aPosition) not! !


!classDefinition: #TakenPosition category: #TerniLapilli!
PositionTakenStatus subclass: #TakenPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TakenPosition methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:03:19'!
assertPositionNonTaken

	^ self error: TerniLapilli mensajeDeErrorPosicionTomada! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TakenPosition class' category: #TerniLapilli!
TakenPosition class
	instanceVariableNames: ''!

!TakenPosition class methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 21:02:04'!
matches: aTerniLapilli and: aPosition

	^ aTerniLapilli positionIsTaken: aPosition! !


!classDefinition: #TerniLapilli category: #TerniLapilli!
Object subclass: #TerniLapilli
	instanceVariableNames: 'playerOneTakenPositions playerTwoTakenPositions turn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!TerniLapilli methodsFor: 'inicializacion' stamp: 'ps 11/5/2018 19:57:27'!
initialize

	playerOneTakenPositions := OrderedCollection new.
	playerTwoTakenPositions := OrderedCollection new.
	turn := PlayerOneTurn new.! !


!TerniLapilli methodsFor: 'jugada' stamp: 'd 11/8/2018 14:12:50'!
playerOneMoves: currentPosition to: newPosition.
	
	(PlayerOnePlayValidator for: self) validateMovementFrom: currentPosition to: newPosition  onTurn: turn.
	
	turn := PlayerTwoTurn new.
	self executeMoveByPlayerOneFrom: currentPosition to: newPosition.! !

!TerniLapilli methodsFor: 'jugada' stamp: 'd 11/8/2018 14:15:47'!
playerOnePlacesTokenAt: aPosition 
	
	(PlayerOnePlayValidator for: self) validateTokenPlacementAt: aPosition  onTurn: turn.
	
	turn := PlayerTwoTurn new.
	self markPositionAsTakenByPlayerOne: aPosition.! !

!TerniLapilli methodsFor: 'jugada' stamp: 'd 11/8/2018 14:15:25'!
playerTwoMoves: currentPosition to: newPosition.

	(PlayerTwoPlayValidator for: self) validateMovementFrom: currentPosition to: newPosition  onTurn: turn.

	turn := PlayerOneTurn new.
	self executeMoveByPlayerTwoFrom: currentPosition to: newPosition.! !

!TerniLapilli methodsFor: 'jugada' stamp: 'd 11/8/2018 14:15:57'!
playerTwoPlacesTokenAt: aPosition
	
	(PlayerTwoPlayValidator for: self) validateTokenPlacementAt: aPosition  onTurn: turn.

	turn := PlayerOneTurn new.
	self markPositionAsTakenByPlayerTwo: aPosition.! !


!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/1/2018 20:01:37'!
began

	^ playerOneTakenPositions isEmpty not! !

!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/5/2018 20:09:46'!
isOver
	 ^ self playerOneWon or: [self playerTwoWon]! !

!TerniLapilli methodsFor: 'observadores' stamp: 'd 11/8/2018 13:23:45'!
playerOneWon

	 ^self playerWithTheseTokensWon: playerOneTakenPositions.
		! !

!TerniLapilli methodsFor: 'observadores' stamp: 'd 11/8/2018 13:24:09'!
playerTwoWon

	 ^self playerWithTheseTokensWon: playerTwoTakenPositions.! !

!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/1/2018 20:23:18'!
positionIsTaken: aPoint 

	^ (self positionIsTakenByPlayerOne: aPoint) or: [self positionIsTakenByPlayerTwo: aPoint].! !

!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/1/2018 20:01:53'!
positionIsTakenByPlayerOne: aPoint 

	^ playerOneTakenPositions includes: aPoint ! !

!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/1/2018 20:22:45'!
positionIsTakenByPlayerTwo: aPoint 

	^ playerTwoTakenPositions includes: aPoint ! !

!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/5/2018 21:11:38'!
positionsTakenByPlayerOne

	^ playerOneTakenPositions copy! !

!TerniLapilli methodsFor: 'observadores' stamp: 'ps 11/5/2018 21:11:31'!
positionsTakenByPlayerTwo

	^ playerTwoTakenPositions copy! !


!TerniLapilli methodsFor: 'privados' stamp: 'ps 11/7/2018 19:19:50'!
executeMoveByPlayerOneFrom: currentPosition to: newPosition

	playerOneTakenPositions remove: currentPosition.
	playerOneTakenPositions add: newPosition.! !

!TerniLapilli methodsFor: 'privados' stamp: 'ps 11/7/2018 19:19:47'!
executeMoveByPlayerTwoFrom: currentPosition to: newPosition

	playerTwoTakenPositions remove: currentPosition.
	playerTwoTakenPositions add: newPosition.! !

!TerniLapilli methodsFor: 'privados' stamp: 'ps 11/7/2018 19:25:50'!
markPositionAsTakenByPlayerOne: aPosition

	playerOneTakenPositions add: aPosition! !

!TerniLapilli methodsFor: 'privados' stamp: 'ps 11/7/2018 19:26:01'!
markPositionAsTakenByPlayerTwo: aPosition

	playerTwoTakenPositions add: aPosition! !

!TerniLapilli methodsFor: 'privados' stamp: 'd 11/8/2018 13:22:42'!
playerWithTheseTokensWon: tokens
	| won |
	
	won := false.

	 #(1,2,3) do:[:index | won:= won or:[(tokens select: [:e| (e y) = index]) size = 3]].
	 #(1,2,3) do:[:index | won:= won or:[(tokens select: [:e| (e x) = index]) size = 3]].
	 won:= won or:[(tokens select: [:e| (e x) = (e y)]) size = 3].
	 won:= won or:[(tokens select: [:e| 4-(e x) = (e y)]) size = 3].
	
	 ^won.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #TerniLapilli!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'd 11/4/2018 11:26:03'!
mensajeDeErrorCantidadDeFichasExcedida

	^ 'cantidadDeFichasExcedida'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'd 11/4/2018 14:10:31'!
mensajeDeErrorJuegoFinalizado

	^ 'elJuegoTermino'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'd 11/4/2018 13:42:41'!
mensajeDeErrorMovimientoInvalido

	^ 'movimientoInvalido'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'ps 11/5/2018 20:45:08'!
mensajeDeErrorPosicionFueraDelTablero

	^ 'posicionFueraDelTablero'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'd 11/4/2018 15:19:48'!
mensajeDeErrorPosicionInvalida

	^ 'laPosicionEsInvalida'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'ps 11/1/2018 20:28:15'!
mensajeDeErrorPosicionTomada

	^ 'laPosicionYaEstabaTomada'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'ps 11/7/2018 19:12:06'!
mensajeDeErrorPosicionesDeOrigenYDestinoIguales

	^ 'lasPosicionesDeOrigenYDestinoSonIguales'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'd 11/4/2018 13:33:26'!
mensajeDeErrorTodaviaNoSeUsaronTodasLasFichas

	^ 'quedanFichasSinUsar'! !

!TerniLapilli class methodsFor: 'mensajes de error' stamp: 'ps 11/1/2018 20:14:52'!
mensajeDeErrorTurnoIncorrecto

	^ 'noEsTuTurno'! !


!classDefinition: #Turn category: #TerniLapilli!
Object subclass: #Turn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!Turn methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 19:52:17'!
assertPlayerOneCanPlay

	self subclassResponsibility ! !

!Turn methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 19:54:06'!
assertPlayerTwoCanPlay

	self subclassResponsibility ! !


!classDefinition: #PlayerOneTurn category: #TerniLapilli!
Turn subclass: #PlayerOneTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerOneTurn methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 19:52:25'!
assertPlayerOneCanPlay! !

!PlayerOneTurn methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 19:53:46'!
assertPlayerTwoCanPlay

	^self error: TerniLapilli mensajeDeErrorTurnoIncorrecto! !


!classDefinition: #PlayerTwoTurn category: #TerniLapilli!
Turn subclass: #PlayerTwoTurn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli'!

!PlayerTwoTurn methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 19:53:27'!
assertPlayerOneCanPlay

	^self error: TerniLapilli mensajeDeErrorTurnoIncorrecto! !

!PlayerTwoTurn methodsFor: 'as yet unclassified' stamp: 'ps 11/5/2018 19:53:56'!
assertPlayerTwoCanPlay! !
