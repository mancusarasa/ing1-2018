!classDefinition: #CashierTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 21:14:52'!
test01HacerCheckoutDeUnCarritoVacioFalla

	| aCashier aCart priceList aCreditCard preExpirationDate |

	aCart := ShoppingCart with: Set new.
	priceList := Dictionary new.
	priceList at: 'unISBN' put: 3.
	aCashier := Cashier withPriceList: priceList.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	self should: [aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: Cashier mensajeDeErrorCarritoVacio.
	]! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:36:42'!
test02HacerCheckoutDeUnCarritoConMultiplesItemsDevuelveLaSumaDeSusPrecios

	| aCashier aCart aCatalog aCreditCard preExpirationDate |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCatalog at: 'otroISBN' put: 20.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCart add: 3 of: 'otroISBN'.



	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	aCashier := Cashier withPriceList: aCatalog.
	self assert: (aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate) equals: 70.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:37:12'!
test03HacerCheckoutDeUnCarritoConUnItemDevuelveElValorDelItem

	| aCashier aCart aCatalog aCreditCard preExpirationDate |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	preExpirationDate := FixedGregorianDate year: 2016 month: January dayNumber: 3.
	
	aCashier := Cashier withPriceList: aCatalog.
	self assert: (aCashier checkout: aCart withCard: aCreditCard withCurrentDate: preExpirationDate) equals: 10.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:47:23'!
test04HacerCheckoutDeUnCarritoConUnaTarjetaVencidaFalla

	| aCashier aCart aCatalog aCreditCard postExpirationDate |

	aCatalog := Dictionary new.
	aCatalog at: 'unISBN' put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 'unISBN'.
	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	postExpirationDate := FixedGregorianDate year: 2016 month: March dayNumber: 3.
	aCashier := Cashier withPriceList: aCatalog.
	
	self should: [aCashier checkout: aCart withCard: aCreditCard withCurrentDate: postExpirationDate] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: Cashier mensajeDeErrorTarjetaExpirada.
	]! !


!classDefinition: #CreditCardTest category: #'TusLibros-Iteracion2'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:38:58'!
test01NoSePuedeCrearUnaTarjetaConNombreVacio

	self should: [CreditCard of: '' withNumber: '1111222233334444' withExpirationDate: (January ofYear: 2016)] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: CreditCard mensajeDeErrorNombreDeClienteVacio.
	]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:41:58'!
test02NoSePuedeCrearUnaTarjetaConNumeroConLongitudDistintaA16

	self should: [CreditCard of: 'Juan Perez' withNumber: '' withExpirationDate: (January ofYear: 2016)] raise: Error withExceptionDo: [
		:anError |
		self assert: anError messageText equals: CreditCard mensajeDeErrorNumeroDeTarjetaInvalido.
	]! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:53:25'!
test03UnaTarjetaConFechaDeExpiracionDeFebreroNoEstaVencidaEnEnero

	| aCreditCard  |

	aCreditCard := CreditCard of: 'Juan Perez' withNumber: '1111222233334444' withExpirationDate: (February ofYear: 2016).
	self deny: (aCreditCard isExpiredAsFrom: (FixedGregorianDate year: 2016 month: January dayNumber: 1)).! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:53:52'!
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

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:11:07'!
test01AlCrearUnCarritoEstaVacio

	| aCart |
	
	aCart := ShoppingCart with: Dictionary new.
	self assert: (aCart isEmpty).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:11:34'!
test02AlAgregarUnLibroAlCarritoNoEstaVacio

	| aCart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at:'978-3-16-148410-0' put: 10.
	
	aCart := ShoppingCart with: aCatalog.
	aCart add: '978-3-16-148410-0'.
	self deny: (aCart isEmpty).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:14:36'!
test03AlAgregarUnLibroAlCarritoElLibroEstaEnElCarrito

	| aCart aBook aCatalog|
	
	aCatalog := Dictionary new.
	aCatalog at: '978-3-16-148410-0' put: 10.

	aCart := ShoppingCart with: aCatalog.
	aBook := '978-3-16-148410-0'.
	aCart add: aBook.
	self assert: (aCart contains: aBook).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:15:13'!
test04UnLibroQueNoFueAgregadoAlCarritoNoEstaEnElCarrito

	| aCart aBook anotherBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: 10.
	aCart := ShoppingCart with: aCatalog.
	anotherBook :=  '978-3-16-148410-1'.
	aCart add: aBook.
	self deny: (aCart content includes: anotherBook).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:15:43'!
test05AlAgregarXVecesElMismoItemElCarritoLoContieneXVeces

	| aCart aBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Dictionary new.
	aCatalog at: aBook put: 10.
	aCart := ShoppingCart with: aCatalog.
	aCart add: 4 of: aBook.
	self assert: (aCart quantityOf: aBook) equals: 4.! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:16:10'!
test06NoSePuedeAgregarUnLibroQueNoPertenezcaAlCatalogo

	| aCart aCatalog |
	
	aCatalog := Dictionary new.
	aCatalog at: '978-3-16-148410-1' put: 10.
	aCart := ShoppingCart with: aCatalog.
	self should: [aCart add: '978-3-16-148410-0'] raise: Error withExceptionDo: [
		:anError | 
		self assert: (anError messageText) equals: (ShoppingCart mensajeDeErrorLibroNoPerteneceAlCatalogo).
	].! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:16:37'!
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

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:17:01'!
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


!classDefinition: #Cashier category: #'TusLibros-Iteracion2'!
Object subclass: #Cashier
	instanceVariableNames: 'priceList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 21:05:49'!
assertCardNotExpired: aCreditCard onCurrentDate: aGregorianDate

	(aCreditCard isExpiredAsFrom: aGregorianDate) ifTrue: [self error: self class mensajeDeErrorTarjetaExpirada]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:59:35'!
assertCartNotEmpty: aCart.

	aCart isEmpty ifTrue: [self error: self class mensajeDeErrorCarritoVacio ] ! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 19:18:51'!
assertEveryItemHasItsPrice: aCart

	aCart content do: [
		:anItem |
		priceList at: anItem ifAbsent: [self error: self class mensajeDeErrorProductoSinPrecio].
	]! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 19:16:13'!
calculateSumOfItemsPricesIn: aCart

	^ aCart content inject: 0 into: [
		:aSubTotal :anItem |
		aSubTotal + priceList at: anItem.
	].! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 21:06:12'!
checkout: aCart withCard: aCreditCard withCurrentDate: aFixedGregorianDate

	self assertCartNotEmpty: aCart.
	self assertEveryItemHasItsPrice: aCart.
	self assertCardNotExpired: aCreditCard onCurrentDate: aFixedGregorianDate.
	^ self calculateSumOfItemsPricesIn: aCart.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:58:16'!
initializeWithPriceList: aPriceList

	priceList := aPriceList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Iteracion2'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 19:27:11'!
assertPriceListIsNotEmpty: aPriceList

	aPriceList isEmpty ifTrue: [self error: self mensajeDeErrorListaDePreciosVacia]! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:40:49'!
mensajeDeErrorCarritoVacio

	^ 'elCarritoEstaVacio'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 19:26:30'!
mensajeDeErrorListaDePreciosVacia

	^ 'laListaDePreciosEstaVacia'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 19:14:49'!
mensajeDeErrorProductoSinPrecio

	^ 'elItemNoTienePrecio'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 21:02:46'!
mensajeDeErrorTarjetaExpirada

	^ 'laTarjetaEstaExpirada'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 19:26:49'!
withPriceList: aPriceList 

	self assertPriceListIsNotEmpty: aPriceList.
	^ self new initializeWithPriceList: aPriceList ! !


!classDefinition: #CreditCard category: #'TusLibros-Iteracion2'!
Object subclass: #CreditCard
	instanceVariableNames: 'clientName clientNumber expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:29:54'!
initializeOf: aClientName withNumber: aClientNumber withExpirationDate: aGregorianMonthOfYear

	clientName := aClientName.
	clientNumber := aClientNumber.
	expirationDate := aGregorianMonthOfYear.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:43:08'!
isExpiredAsFrom: aGregorianDate

	^ expirationDate < aGregorianDate ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Iteracion2'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:41:15'!
assertClientNumberHasTheAppropriateLength: aClientNumber

	(aClientNumber size = 16) ifFalse: [self error: self mensajeDeErrorNumeroDeTarjetaInvalido]! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:41:09'!
assertNameIsNotEmpty: aClientName

	(aClientName size = 0) ifTrue: [self error: self mensajeDeErrorNombreDeClienteVacio].! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:33:20'!
mensajeDeErrorNombreDeClienteVacio

	^ 'elNombreDelClienteNoPuedeSerVacio'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:35:07'!
mensajeDeErrorNumeroDeTarjetaInvalido

	^ 'elNumeroDeTarjetaDebeTener16Numeros'! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 20:33:50'!
of: aClientName withNumber: aClientNumber withExpirationDate: aGregorianMonthOfYear

	self assertNameIsNotEmpty: aClientName.
	self assertClientNumberHasTheAppropriateLength: aClientNumber.
	^ self new initializeOf: aClientName withNumber: aClientNumber withExpirationDate: aGregorianMonthOfYear! !


!classDefinition: #ShoppingCart category: #'TusLibros-Iteracion2'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion2'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:25:33'!
add: aBook

	self add: 1 of: aBook 
! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:23:43'!
add: anInteger of: aBook

	self assertIsValidBook: aBook.
	self assertIsValidQuantity: anInteger.
	books add: aBook withOccurrences: anInteger 
! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:13:41'!
assertIsValidBook: aBook

	(catalog includesKey: aBook) ifFalse: [self error: (self class mensajeDeErrorLibroNoPerteneceAlCatalogo)]! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:24:57'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class mensajeDeErrorCantidadInvalida ]! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/16/2018 11:13:50'!
contains: aBook

	^ books includes: aBook! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:11:21'!
content

	^ books copy! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:14:02'!
initializeWith: aCatalog

	books := Bag new.
	catalog := aCatalog.! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:07:25'!
isEmpty

	^ books isEmpty ! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:40:48'!
quantityOf: aBook

	^ books occurrencesOf: aBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Iteracion2'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'ps 11/15/2018 18:24:51'!
mensajeDeErrorCantidadInvalida

	^ 'laCantidadIndicadaEsInvalida'! !

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:54:39'!
mensajeDeErrorLibroNoPerteneceAlCatalogo

	^ 'elLibroNoPerteneceAlCatalogo'! !

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:53:26'!
with: aCatalog

	^ self new initializeWith: aCatalog! !
