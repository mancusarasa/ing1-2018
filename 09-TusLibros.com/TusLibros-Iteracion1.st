!classDefinition: #ShoppingCartTest category: #'TusLibros-Iteracion1'!
TestCase subclass: #ShoppingCartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:14:34'!
test01AlCrearUnCarritoEstaVacio

	| aCart |
	
	aCart := ShoppingCart with: Bag new.
	self assert: (aCart isEmpty).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:03:55'!
test02AlAgregarUnLibroAlCarritoNoEstaVacio

	| aCart aCatalog |
	
	aCatalog := Bag with:'978-3-16-148410-0'.
	aCart := ShoppingCart with: aCatalog.
	aCart add: '978-3-16-148410-0'.
	self deny: (aCart isEmpty).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:04:28'!
test03AlAgregarUnLibroAlCarritoElLibroEstaEnElCarrito

	| aCart aBook aCatalog|
	
	aCatalog := Bag with:'978-3-16-148410-0'.
	aCart := ShoppingCart with: aCatalog.
	aBook := '978-3-16-148410-0'.
	aCart add: aBook.
	self assert: (aCart contains: aBook).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:05:38'!
test04UnLibroQueNoFueAgregadoAlCarritoNoEstaEnElCarrito

	| aCart aBook anotherBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Bag with: aBook.
	aCart := ShoppingCart with: aCatalog.
	anotherBook :=  '978-3-16-148410-1'.
	aCart add: aBook.
	self deny: (aCart content includes: anotherBook).! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:06:27'!
test05AlAgregarXVecesElMismoItemElCarritoLoContieneXVeces

	| aCart aBook aCatalog |
	
	aBook := '978-3-16-148410-0'.
	aCatalog := Bag with: aBook.
	aCart := ShoppingCart with: aCatalog.
	aCart add: aBook.
	aCart add: aBook.
	aCart add: aBook.
	aCart add: aBook.
	self assert: (aCart quantityOf: aBook) equals: 4.! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:06:46'!
test06NoSePuedeAgregarUnLibroQueNoPertenezcaAlCatalogo

	| aCart aCatalog |
	
	aCatalog := Bag new.
	aCatalog add: '978-3-16-148410-1'.
	aCart := ShoppingCart with: aCatalog.

	self should: [aCart add: '978-3-16-148410-0'] raise: Error withExceptionDo: [
		:anError | 
		self assert: (anError messageText) equals: (ShoppingCart mensajeDeErrorLibroNoPerteneceAlCatalogo).
	].! !

!ShoppingCartTest methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:16:48'!
test07AgregarUnLibroAlCarritoDebeReflejarseEnElListado

	| aCart aCatalog |
	
	aCatalog := Bag new.
	aCatalog add: '978-3-16-148410-1'.
	aCatalog add: '978-3-16-148410-2'.
	
	aCart := ShoppingCart with: aCatalog.
	aCart add: '978-3-16-148410-1'.
	aCart add: '978-3-16-148410-1'.
	aCart add: '978-3-16-148410-2'.
	self assert: (aCart content) equals: (Bag with: '978-3-16-148410-1' with: '978-3-16-148410-1' with: '978-3-16-148410-2').! !


!classDefinition: #ShoppingCart category: #'TusLibros-Iteracion1'!
Object subclass: #ShoppingCart
	instanceVariableNames: 'books catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion1'!

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 21:02:36'!
add: aBook

	catalog detect: [:aBookInTheCatalog | aBookInTheCatalog = aBook] ifNone: [self error: (self class mensajeDeErrorLibroNoPerteneceAlCatalogo)].
	books add: aBook 
! !

!ShoppingCart methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:26:13'!
contains: aBook

	^ books includes: aBook.! !

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

!classDefinition: 'ShoppingCart class' category: #'TusLibros-Iteracion1'!
ShoppingCart class
	instanceVariableNames: ''!

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:54:39'!
mensajeDeErrorLibroNoPerteneceAlCatalogo

	^ 'elLibroNoPerteneceAlCatalogo'! !

!ShoppingCart class methodsFor: 'as yet unclassified' stamp: 'ps 11/12/2018 20:53:26'!
with: aCatalog

	^ self new initializeWith: aCatalog! !
