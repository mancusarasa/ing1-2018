!classDefinition: #TerniLapilliConsoleTests category: #TerniLapilliConsoleTests!
TestCase subclass: #TerniLapilliConsoleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilliConsoleTests'!

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 19:35:23'!
test01PonerUnaSolaFichaEnElTableroSeReflejaEnLaConsola

	| game console lines |

	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.
	game putXAt: 1@1.
	lines := console lines.
	self assert: (lines at: 1) equals: 'X marco en 1@1'.
	self assert: (lines at: 2) equals: 'Estado: Jugando O'.! !

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 19:40:52'!
test02PonerDosFichasEnElTableroSeReflejaEnLaConsola

	| game console lines |

	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.
	game putXAt: 1@1.
	game putOAt: 1@2.
	lines := console lines.
	self assert: (lines at: 1) equals: 'X marco en 1@1'.
	self assert: (lines at: 2) equals: 'Estado: Jugando O'.
	self assert: (lines at: 3) equals: 'O marco en 1@2'.
	self assert: (lines at: 4) equals: 'Estado: Jugando X'.! !

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 20:11:50'!
test03AlGanarELJugadorXLaConsolaReportaAlJugadorQueGano

	| game console lines |

	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 1@2.
	game putXAt: 3@1.

	lines := console lines.
	self assert: (lines at: 1) equals: 'X marco en 2@2'.
	self assert: (lines at: 2) equals: 'Estado: Jugando O'.
	self assert: (lines at: 3) equals: 'O marco en 1@1'.
	self assert: (lines at: 4) equals: 'Estado: Jugando X'.
	self assert: (lines at: 5) equals: 'X marco en 1@3'.
	self assert: (lines at: 6) equals: 'Estado: Jugando O'.
	self assert: (lines at: 7) equals: 'O marco en 1@2'.
	self assert: (lines at: 8) equals: 'Estado: Jugando X'.
	self assert: (lines at: 9) equals: 'X marco en 3@1'.
	self assert: (lines at: 10) equals: 'Estado: Juego terminado - ¡Gano X!!'.! !

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 20:14:29'!
test04AlGanarElJugadorOLaConsolaReportaAlJugadorQueGano

	| game console lines |

	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.

	game putXAt: 3@3.
	game putOAt: 2@2.
	game putXAt: 1@1.
	game putOAt: 1@3.
	game putXAt: 1@2.
	game putOAt: 3@1.
	lines := console lines.

	self assert: (lines at: 1) equals: 'X marco en 3@3'.
	self assert: (lines at: 2) equals: 'Estado: Jugando O'.
	self assert: (lines at: 3) equals: 'O marco en 2@2'.
	self assert: (lines at: 4) equals: 'Estado: Jugando X'.
	self assert: (lines at: 5) equals: 'X marco en 1@1'.
	self assert: (lines at: 6) equals: 'Estado: Jugando O'.
	self assert: (lines at: 7) equals: 'O marco en 1@3'.
	self assert: (lines at: 8) equals: 'Estado: Jugando X'.
	self assert: (lines at: 9) equals: 'X marco en 1@2'.
	self assert: (lines at: 10) equals: 'Estado: Jugando O'.
	self assert: (lines at: 11) equals: 'O marco en 3@1'.
	self assert: (lines at: 12) equals: 'Estado: Juego terminado - ¡Gano O!!'.! !

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 20:31:34'!
test05LaConsolaRegistraDesplazamientos

	| game console lines | 
	
	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.

	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 2@1.
	game putOAt: 2@3.	
	
	game slideXFrom: 1@3 to: 1@2. 
	game slideOFrom: 3@1 to: 3@2. 
	game slideXFrom: 2@2 to: 3@3. 
	
	lines := console lines.
	self assert: (lines at:1) equals: 'X marco en 2@2'.
	self assert: (lines at:2) equals: 'Estado: Jugando O'.
	self assert: (lines at:3) equals: 'O marco en 1@1'.
	self assert: (lines at:4) equals: 'Estado: Jugando X'.
	self assert: (lines at:5) equals: 'X marco en 1@3'.
	self assert: (lines at:6) equals: 'Estado: Jugando O'.
	self assert: (lines at:7) equals: 'O marco en 3@1'.
	self assert: (lines at:8) equals: 'Estado: Jugando X'.
	self assert: (lines at:9) equals: 'X marco en 2@1'.
	self assert: (lines at:10) equals: 'Estado: Jugando O'.
	self assert: (lines at:11) equals: 'O marco en 2@3'.
	self assert: (lines at:12) equals: 'Estado: Jugando X'.
	self assert: (lines at:13) equals: 'X deslizo hasta 1@2 desde 1@3'.
	self assert: (lines at:14) equals: 'Estado: Jugando O'.
	self assert: (lines at:15) equals: 'O deslizo hasta 3@2 desde 3@1'.
	self assert: (lines at:16) equals: 'Estado: Jugando X'.
	self assert: (lines at:17) equals: 'X deslizo hasta 3@3 desde 2@2'.
	self assert: (lines at:18) equals: 'Estado: Jugando O'.! !

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 20:59:30'!
test06LaConsolaRegistraCuandoElJugadorOGanaElPartidoConDesplazamientos

	| game console lines | 
	
	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.

	game putXAt: 3@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt: 3@3.
	game putOAt: 2@2.	
	
	game slideXFrom: 1@3 to: 1@2.
	game slideOFrom: 2@2 to: 2@1.
	
	lines := console lines.
	self assert: (lines at:1) equals: 'X marco en 3@2'.
	self assert: (lines at:2) equals: 'Estado: Jugando O'.
	self assert: (lines at:3) equals: 'O marco en 1@1'.
	self assert: (lines at:4) equals: 'Estado: Jugando X'.
	self assert: (lines at:5) equals: 'X marco en 1@3'.
	self assert: (lines at:6) equals: 'Estado: Jugando O'.
	self assert: (lines at:7) equals: 'O marco en 3@1'.
	self assert: (lines at:8) equals: 'Estado: Jugando X'.
	self assert: (lines at:9) equals: 'X marco en 3@3'.
	self assert: (lines at:10) equals: 'Estado: Jugando O'.
	self assert: (lines at:11) equals: 'O marco en 2@2'.
	self assert: (lines at:12) equals: 'Estado: Jugando X'.
	self assert: (lines at:13) equals: 'X deslizo hasta 1@2 desde 1@3'.
	self assert: (lines at:14) equals: 'Estado: Jugando O'.
	self assert: (lines at:15) equals: 'O deslizo hasta 2@1 desde 2@2'.
	self assert: (lines at:16) equals: 'Estado: Juego terminado - ¡Gano O!!'.! !

!TerniLapilliConsoleTests methodsFor: 'as yet unclassified' stamp: 'ps 11/8/2018 21:08:33'!
test07LaConsolaRegistraCuandoElJugadorXGanaElPartidoConDesplazamientos

	| game console lines | 
	
	game := TerniLapilli new.
	console := TerniLapilliConsole for: game.

	game putXAt: 1@1.
	game putOAt: 2@2.
	game putXAt: 3@1.
	game putOAt: 1@3.
	game putXAt: 1@2.
	game putOAt: 3@3.

	game slideXFrom: 3@1 to: 2@1.
	game slideOFrom: 2@2 to: 2@3.
	
	lines := console lines.
	self assert: (lines at:1) equals: 'X marco en 1@1'.
	self assert: (lines at:2) equals: 'Estado: Jugando O'.
	self assert: (lines at:3) equals: 'O marco en 2@2'.
	self assert: (lines at:4) equals: 'Estado: Jugando X'.
	self assert: (lines at:5) equals: 'X marco en 3@1'.
	self assert: (lines at:6) equals: 'Estado: Jugando O'.
	self assert: (lines at:7) equals: 'O marco en 1@3'.
	self assert: (lines at:8) equals: 'Estado: Jugando X'.
	self assert: (lines at:9) equals: 'X marco en 1@2'.
	self assert: (lines at:10) equals: 'Estado: Jugando O'.
	self assert: (lines at:11) equals: 'O marco en 3@3'.
	self assert: (lines at:12) equals: 'Estado: Jugando X'.
	self assert: (lines at:13) equals: 'X deslizo hasta 2@1 desde 3@1'.
	self assert: (lines at:14) equals: 'Estado: Jugando O'.
	self assert: (lines at:15) equals: 'O deslizo hasta 2@3 desde 2@2'.
	self assert: (lines at:16) equals: 'Estado: Juego terminado - ¡Gano O!!'.! !
