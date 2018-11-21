!classDefinition: #CashierTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 16:02:31'!
test01HacerCheckoutDeUnCarritoVacioFalla

	| aCashier aCart aCatalog aCreditCard preExpirationDate cashierSales aMerchantProcessor |

	aCart := ShoppingCart with: Set new.
	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 3.
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	cashierSales:= aCashier sales.
	
	self should: [aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: Cashier mensajeDeErrorCarritoVacio.
		self assert: (aCashier sales) equals: cashierSales .
	]! !

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 16:03:05'!
test02HacerCheckoutDeUnCarritoConMultiplesItemsDevuelveLaSumaDeSusPrecios

	| aCashier aCart aCatalog aCreditCard preExpirationDate cashierSales aMerchantProcessor |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCatalog at: 'otroISBN' put: 20.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCart add: 3 of: 'otroISBN'.

	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
	cashierSales:= aCashier sales .
		
	self assert: (aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate) equals: 70.
	self deny: (aCashier sales = cashierSales).
	self assert: aCashier lastSale equals: aCart .! !

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 16:03:19'!
test03HacerCheckoutDeUnCarritoConUnItemDevuelveElValorDelItem

	| aCashier aCart aCatalog aCreditCard preExpirationDate cashierSales aMerchantProcessor |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
	cashierSales:= aCashier sales.
		
	self assert: (aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate) equals: 10.
	self deny: (aCashier sales = cashierSales).
	self assert: aCashier lastSale equals: aCart .! !

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 16:03:42'!
test04HacerCheckoutDeUnCarritoConUnaTarjetaVencidaFalla

	| aCashier aCart aCatalog aCreditCard postExpirationDate cashierSales aMerchantProcessor |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	postExpirationDate := FixedGregorianDate year: 2016 month: March dayNumber: 3.
	
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
	cashierSales:= aCashier sales.
	
	self should: [aCashier checkout: aCart withCard: aCreditCard withCurrentDate: postExpirationDate] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: Cashier mensajeDeErrorTarjetaExpirada.
		self assert: (aCashier sales) equals: cashierSales .
	]! !

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 19:37:59'!
test05HacerCheckoutDeUnCarritoVacioFallaSinInteractuarConElMerchantProcessor

	| aCashier aCart aCatalog aCreditCard preExpirationDate aMerchantProcessor |

	aCart := ShoppingCart with: Set new.
	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 3.
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	self should: [aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: Cashier mensajeDeErrorCarritoVacio.
		self assert: (aMerchantProcessor noTransactionsWereMade)
	]! !

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 19:53:27'!
test06HacerCheckoutDeUnCarritoConMultiplesItemsLlegaAlMerchantProcessor

	| aCashier aCart aCatalog aCreditCard preExpirationDate aMerchantProcessor transactions |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCatalog at: 'otroISBN' put: 20.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCart add: 3 of: 'otroISBN'.

	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
		
	aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate.
	transactions := aMerchantProcessor transactions.
	self deny: aMerchantProcessor noTransactionsWereMade.
	self assert: transactions size equals: 1.

	self assert: (transactions at: 1) creditCardNumber equals: '1111222233334444'.
	self assert: (transactions at: 1) creditCardOwner equals: 'Juan Perez'.
	self assert: (transactions at: 1) transactionAmount equals: 70.! !

!CashierTest methodsFor: 'tests' stamp: 'ps 11/21/2018 19:57:21'!
test07HacerCheckoutDeUnCarritoConUnaTarjetaVencidaFallaSinLlegarAlMerchantProcessor

	| aCashier aCart aCatalog aCreditCard postExpirationDate cashierSales aMerchantProcessor |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	postExpirationDate := FixedGregorianDate year: 2016 month: March dayNumber: 3.
	
	aMerchantProcessor := SimulatedMerchantProcessor new.
	aCashier := Cashier withCatalog: aCatalog operatingWith: aMerchantProcessor.
	cashierSales:= aCashier sales.
	
	self should: [aCashier checkout: aCart withCard: aCreditCard withCurrentDate: postExpirationDate] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: Cashier mensajeDeErrorTarjetaExpirada.
		self assert: aMerchantProcessor noTransactionsWereMade.
	]! !


!classDefinition: #CreditCardTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CreditCardTest methodsFor: 'tests' stamp: 'ps 11/15/2018 20:38:58'!
test01NoSePuedeCrearUnaTarjetaConNombreVacio

	self should: [CreditCard of: '' withNumber: '1111222233334444' withExpirationDate: (January ofYear: 2016)] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: CreditCard mensajeDeErrorNombreDeClienteVacio.
	]! !

!CreditCardTest methodsFor: 'tests' stamp: 'ps 11/15/2018 20:41:58'!
test02NoSePuedeCrearUnaTarjetaConNumeroConLongitudDistintaA16

	self should: [CreditCard of: 'Juan Perez' withNumber: '' withExpirationDate: (January ofYear: 2016)] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: CreditCard mensajeDeErrorNumeroDeTarjetaInvalido.
	]! !

!CreditCardTest methodsFor: 'tests' stamp: 'ps 11/15/2018 20:53:25'!
test03UnaTarjetaConFechaDeExpiracionDeFebreroNoEstaVencidaEnEnero

	| aCreditCard  |

	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	self deny: (aCreditCard isExpiredAsFrom: (FixedGregorianDate year: 2016 month: January dayNumber: 1)).! !

!CreditCardTest methodsFor: 'tests' stamp: 'ps 11/15/2018 20:53:52'!
test04UnaTarjetaConFechaDeExpiracionDeFebreroEstaVencidaEnMarzo

	| aCreditCard  |

	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	self assert: (aCreditCard isExpiredAsFrom: (FixedGregorianDate year: 2016 month: March dayNumber: 1)).! !


!classDefinition: #ShoppingCartTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:11:07'!
test01AlCrearUnCarritoEstaVacio

	| aCart |
	
	aCart := ShoppingCart with: Dictionary new.
	self assert: (aCart isEmpty).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:11:34'!
test02AlAgregarUnLibroAlCarritoNoEstaVacio

	| aCart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at:'978-3-16-148410-0' put: 10.
	
	aCart := ShoppingCart with: aCatalog.
	aCart add: '978-3-16-148410-0'.
	self deny: (aCart isEmpty).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:14:36'!
test03AlAgregarUnLibroAlCarritoElLibroEstaEnElCarrito

	| aCart aBook aCatalog|
	
	aCatalog := Dictionary new.
	aCatalog at: '978-3-16-148410-0' put: 10.

	aCart := ShoppingCart with: aCatalog.
	aBook := '978-3-16-148410-0'.
	aCart add: aBook.
	self assert: (aCart contains: aBook).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:15:13'!
test04UnLibroQueNoFueAgregadoAlCarritoNoEstaEnElCarrito

	| aCart aBook anotherBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: 10.
	aCart := ShoppingCart with: aCatalog.
	anotherBook :=  '978-3-16-148410-1'.
	aCart add: aBook.
	self deny: (aCart content includes: anotherBook).! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:15:43'!
test05AlAgregarXVecesElMismoItemElCarritoLoContieneXVeces

	| aCart aBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 4 of: aBook.
	self assert: (aCart quantityOf: aBook) equals: 4.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:16:10'!
test06NoSePuedeAgregarUnLibroQueNoPertenezcaAlCatalogo

	| aCart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: '978-3-16-148410-1' put: 10.
	aCart := ShoppingCart with: aCatalog.
	self should: [aCart add: '978-3-16-148410-0'] raise: Error withExceptionDo: [
		:anError | 
		self assert: (anError messageText) equals: (ShoppingCart mensajeDeErrorLibroNoPerteneceAlCatalogo).
	].! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:16:37'!
test07AgregarUnLibroAlCarritoDebeReflejarseEnElListado

	| aCart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: '978-3-16-148410-1' put: 10.
	aCatalog at: '978-3-16-148410-2' put: 20.
	
	aCart := ShoppingCart with: aCatalog.
	aCart add: '978-3-16-148410-1'.
	aCart add: '978-3-16-148410-1'.
	aCart add: '978-3-16-148410-2'.
	self assert: (aCart content) equals: (Bag with: '978-3-16-148410-1' with: '978-3-16-148410-1' with: '978-3-16-148410-2').! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'ps 11/16/2018 11:17:01'!
test08NoSePuedeAgregarUnaCantidadNegativaDeLibros

	| aCart aBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: 10.

	aCart := ShoppingCart with: aCatalog.
	self should: [aCart add: -1 of: aBook.] raise: Error withExceptionDo: [ :anError |
		self assert: anError messageText equals: ShoppingCart mensajeDeErrorCantidadInvalida.
		self deny: (aCart contains: aBook)
	].! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'd 11/16/2018 17:10:54'!
test09ElValorDelContenidoDeUnCarritoVacioEs0

	| aCart aBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: 10.
	aCart := ShoppingCart with: aCatalog.
	
	self assert: aCart contentPrice equals: 0.
	! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'd 11/16/2018 17:14:24'!
test10ElValorDelContenidoDeUnCarritoConUnItemEsElPrecioDeEseItem

	| aCart aCatalog |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 15.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.

	self assert: aCart contentPrice equals: 15.! !

!ShoppingCartTest methodsFor: 'tests' stamp: 'd 11/16/2018 17:13:15'!
test11ElValorDelContenidoDeUnCarritoConMultiplesItemsEsLaSumaDeSusPrecios

	| aCart aCatalog |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCatalog at: 'otroISBN' put: 20.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCart add: 3 of: 'otroISBN'.

	self assert: aCart contentPrice equals: 70.! !


!classDefinition: #Cashier category: #'TusLibros-Iteracion2'!
Object subclass: #Cashier
	instanceVariableNames: 'catalog salesHistory merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!Cashier methodsFor: 'checkout' stamp: 'ps 11/21/2018 15:54:28'!
checkout: aCart withCard: aCreditCard withCurrentDate: aFixedGregorianDate

	self assertCartNotEmpty: aCart.
	self assertCardNotExpired: aCreditCard onCurrentDate: aFixedGregorianDate.
	salesHistory add: aCart.
	merchantProcessor debit: aCart contentPrice fromCreditCard: aCreditCard.
	
	^ aCart contentPrice.! !


!Cashier methodsFor: 'observadores' stamp: 'd 11/16/2018 17:34:30'!
lastSale
	^ salesHistory last.! !

!Cashier methodsFor: 'observadores' stamp: 'd 11/16/2018 17:34:20'!
sales
	^ salesHistory copy.! !


!Cashier methodsFor: 'asserts' stamp: 'ps 11/15/2018 21:05:49'!
assertCardNotExpired: aCreditCard onCurrentDate: aGregorianDate

	(aCreditCard isExpiredAsFrom: aGregorianDate) ifTrue: [self error: self class mensajeDeErrorTarjetaExpirada]! !

!Cashier methodsFor: 'asserts' stamp: 'ps 11/15/2018 18:59:35'!
assertCartNotEmpty: aCart.

	aCart isEmpty ifTrue: [self error: self class mensajeDeErrorCarritoVacio ] ! !


!Cashier methodsFor: 'inicializacion' stamp: 'ps 11/21/2018 15:49:49'!
initializeWithCatalog: aCatalog operatingWith: aMerchantProcessorInterface

	catalog := aCatalog.
	merchantProcessor := aMerchantProcessorInterface.
	salesHistory:= OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Iteracion2'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'mensajes de error' stamp: 'ps 11/15/2018 18:40:49'!
mensajeDeErrorCarritoVacio

	^ 'elCarritoEstaVacio'! !

!Cashier class methodsFor: 'mensajes de error' stamp: 'ps 11/15/2018 21:02:46'!
mensajeDeErrorTarjetaExpirada

	^ 'laTarjetaEstaExpirada'! !


!Cashier class methodsFor: 'creacion' stamp: 'ps 11/21/2018 15:47:30'!
withCatalog: aCatalog operatingWith: aMerchantProcessorInterface

	^ self new initializeWithCatalog: aCatalog operatingWith: aMerchantProcessorInterface! !


!classDefinition: #CreditCard category: #'TusLibros-Iteracion2'!
Object subclass: #CreditCard
	instanceVariableNames: 'clientName clientNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CreditCard methodsFor: 'observadores' stamp: 'ps 11/15/2018 20:43:08'!
isExpiredAsFrom: aGregorianDate

	^ expirationDate < aGregorianDate ! !


!CreditCard methodsFor: 'inicializacion' stamp: 'ps 11/15/2018 20:29:54'!
initializeOf: aClientName withNumber: aClientNumber withExpirationDate: aGregorianMonthOfYear

	clientName := aClientName.
	clientNumber := aClientNumber.
	expirationDate := aGregorianMonthOfYear.! !

!CreditCard methodsFor: 'inicializacion' stamp: 'ps 11/21/2018 19:54:13'!
number

	^ clientNumber! !

!CreditCard methodsFor: 'inicializacion' stamp: 'ps 11/21/2018 19:55:08'!
owner

	^ clientName! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Iteracion2'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'creacion' stamp: 'ps 11/15/2018 20:33:50'!
of: aClientName withNumber: aClientNumber withExpirationDate: aGregorianMonthOfYear

	self assertNameIsNotEmpty: aClientName.
	self assertClientNumberHasTheAppropriateLength: aClientNumber.
	^ self new initializeOf: aClientName withNumber: aClientNumber withExpirationDate: aGregorianMonthOfYear! !


!CreditCard class methodsFor: 'asserts' stamp: 'ps 11/15/2018 20:41:15'!
assertClientNumberHasTheAppropriateLength: aClientNumber

	(aClientNumber size = 16) ifFalse: [self error: self mensajeDeErrorNumeroDeTarjetaInvalido]! !

!CreditCard class methodsFor: 'asserts' stamp: 'ps 11/15/2018 20:41:09'!
assertNameIsNotEmpty: aClientName

	(aClientName size = 0) ifTrue: [self error: self mensajeDeErrorNombreDeClienteVacio].! !


!CreditCard class methodsFor: 'mensajes de error' stamp: 'ps 11/15/2018 20:33:20'!
mensajeDeErrorNombreDeClienteVacio

	^ 'elNombreDelClienteNoPuedeSerVacio'! !

!CreditCard class methodsFor: 'mensajes de error' stamp: 'ps 11/15/2018 20:35:07'!
mensajeDeErrorNumeroDeTarjetaInvalido

	^ 'elNumeroDeTarjetaDebeTener16Numeros'! !


!classDefinition: #MerchantProcessorInterface category: #'TusLibros-Iteracion2'!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!MerchantProcessorInterface methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 15:45:20'!
debit: anAmount fromCreditCard: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #SimulatedMerchantProcessor category: #'TusLibros-Iteracion2'!
MerchantProcessorInterface subclass: #SimulatedMerchantProcessor
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:49:57'!
debit: anAmount fromCreditCard: aCreditCard

	transactions add: (MerchantProcessorTransaction ofAmount: anAmount withCreditCard: aCreditCard)! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:47:05'!
initialize

	transactions := OrderedCollection new.! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:47:54'!
noTransactionsWereMade

	^ transactions isEmpty ! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:46:27'!
transactions

	^ transactions copy! !


!classDefinition: #MerchantProcessorTransaction category: #'TusLibros-Iteracion2'!
Object subclass: #MerchantProcessorTransaction
	instanceVariableNames: 'amount creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!MerchantProcessorTransaction methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:53:51'!
creditCardNumber

	^ creditCard number! !

!MerchantProcessorTransaction methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:54:38'!
creditCardOwner

	^ creditCard owner! !

!MerchantProcessorTransaction methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:52:12'!
initializeWithAmount: anAmount withCreditCard: aCreditCard

	amount := anAmount.
	creditCard := aCreditCard.! !

!MerchantProcessorTransaction methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:55:40'!
transactionAmount

	^ amount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorTransaction class' category: #'TusLibros-Iteracion2'!
MerchantProcessorTransaction class
	instanceVariableNames: ''!

!MerchantProcessorTransaction class methodsFor: 'as yet unclassified' stamp: 'ps 11/21/2018 19:50:54'!
ofAmount: anAmount withCreditCard: aCreditCard

	^ self new initializeWithAmount: anAmount withCreditCard: aCreditCard! !


!classDefinition: #ShoppingCart category: #'TusLibros-Iteracion2'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!ShoppingCart methodsFor: 'asserts' stamp: 'ps 11/16/2018 11:13:41'!
assertIsValidBook: aBook

	(catalog includesKey: aBook) ifFalse: [self error: (self class mensajeDeErrorLibroNoPerteneceAlCatalogo)]! !

!ShoppingCart methodsFor: 'asserts' stamp: 'ps 11/15/2018 18:24:57'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class mensajeDeErrorCantidadInvalida ]! !


!ShoppingCart methodsFor: 'observadores' stamp: 'ps 11/16/2018 11:13:50'!
contains: aBook

	^ books includes: aBook! !

!ShoppingCart methodsFor: 'observadores' stamp: 'ps 11/12/2018 20:11:21'!
content

	^ books copy! !

!ShoppingCart methodsFor: 'observadores' stamp: 'd 11/16/2018 17:09:13'!
contentPrice

	^ books inject: 0 into: [
		:aSubTotal :anItem |
		aSubTotal + catalog at: anItem.
	].! !

!ShoppingCart methodsFor: 'observadores' stamp: 'ps 11/12/2018 20:07:25'!
isEmpty

	^ books isEmpty ! !

!ShoppingCart methodsFor: 'observadores' stamp: 'ps 11/12/2018 20:40:48'!
quantityOf: aBook

	^ books occurrencesOf: aBook! !


!ShoppingCart methodsFor: 'inicializacion' stamp: 'ps 11/12/2018 21:14:02'!
initializeWith: aCatalog

	books := Bag new.
	catalog := aCatalog.! !


!ShoppingCart methodsFor: 'acceso' stamp: 'ps 11/15/2018 18:25:33'!
add: aBook

	self add: 1 of: aBook 
! !

!ShoppingCart methodsFor: 'acceso' stamp: 'ps 11/15/2018 18:23:43'!
add: anInteger of: aBook

	self assertIsValidBook: aBook.
	self assertIsValidQuantity: anInteger.
	books add: aBook withOccurrences: anInteger 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Iteracion2'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'mensajes de error' stamp: 'ps 11/15/2018 18:24:51'!
mensajeDeErrorCantidadInvalida

	^ 'laCantidadIndicadaEsInvalida'! !

!ShoppingCart class methodsFor: 'mensajes de error' stamp: 'ps 11/12/2018 20:54:39'!
mensajeDeErrorLibroNoPerteneceAlCatalogo

	^ 'elLibroNoPerteneceAlCatalogo'! !


!ShoppingCart class methodsFor: 'creacion' stamp: 'ps 11/12/2018 20:53:26'!
with: aCatalog

	^ self new initializeWith: aCatalog! !
