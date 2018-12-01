!classDefinition: #CartTest category: #'TusLibros-Iteracion3'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'ps 12/1/2018 13:06:56'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'ps 12/1/2018 13:07:08'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'ps 12/1/2018 13:07:13'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart class invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #'TusLibros-Iteracion3'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #InternalRestInterfaceTest category: #'TusLibros-Iteracion3'!
TestCase subclass: #InternalRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test01ANonExistentUserCantCreateACart

	| aRestInterface |
	
	aRestInterface := InternalRestInterface withCatalog: (testObjectsFactory defaultCatalog) andAuthInfo: (testObjectsFactory defaultAuthInfo) andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	self should: [
		aRestInterface createNewCartFor: 'ClienteInexistente' withPassword: 'password'. 
	]
	raise: Error withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorUsuarioInexistente.
	]! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test02AnExistentUserWithTheWrongPasswordCantCreateANewCart

	| aRestInterface |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	self should: [
		aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: 'passworddddd'. 
	]
	raise: Error withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorContraseñaIncorrecta.
	]! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test03ANewCartIsEmptyWhenCreated

	| aRestInterface cartId cartItems |
	
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	cartItems := aRestInterface listItemsOf: cartId.
	self assert: cartItems equals: OrderedCollection new.! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test04ItemsAddedToACartAreListedInItsItems

	| aRestInterface usersPasswords cartId cartItems |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	cartItems := aRestInterface listItemsOf: cartId.
	self assert: cartItems equals: (OrderedCollection with: testObjectsFactory itemSellByTheStore)! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test05CannotAddItemsToAnInvalidCart

	| aRestInterface cartId |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword .

	self should: [aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId +1]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorIdDeCarritoInvalido.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test06CannotListItemsOfAnInvalidCart

	| aRestInterface cartId |
	
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	
	self should: [aRestInterface listItemsOf: cartId+1]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorIdDeCarritoInvalido.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test07CheckoutCartWithExpiredCreditCardShouldFail

	| aRestInterface cartId ccn cco cced |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.

	self should: [
		ccn := testObjectsFactory validCreditCardNumber.
		cco := testObjectsFactory defaultClient.
		cced := testObjectsFactory expiredCreditCardFormattedString.
		aRestInterface checkoutCart: cartId withCreditCardNumber: ccn withExpirationDate: cced fromOwner: cco on: testObjectsFactory today.
	]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorTarjetaExpirada.
		self assert: (aRestInterface listPurchasesBy: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword) items isEmpty.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test08CheckoutCartWithValidCreditCardShouldReflectOnTheClientPurchases

	| aRestInterface cartId clientPurchases |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	aRestInterface checkoutCart: cartId withCreditCardNumber: testObjectsFactory validCreditCardNumber withExpirationDate: testObjectsFactory notExpiredCreditCardFormattedString fromOwner: testObjectsFactory defaultClient on: testObjectsFactory today.
	clientPurchases := aRestInterface listPurchasesBy: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	self assert: clientPurchases total equals: testObjectsFactory itemSellByTheStorePrice.
	self assert: (clientPurchases items occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 1.
! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test09CantAddItemsFromAnExpiredCart

	| aRestInterface cartId clock |

	clock := testObjectsFactory createClockOnCurrentTime.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: clock.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	clock advanceTimeIn: (3 hours).
	self should: [aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorCarritoExpirado.
		self assert: (aRestInterface listPurchasesBy: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword) items isEmpty.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test10CantListItemsFromAnExpiredCart

	| aRestInterface cartId clock |
	
	clock := testObjectsFactory createClockOnCurrentTime.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: clock.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient  withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	clock advanceTimeIn: (3 hours).
	self should: [aRestInterface listItemsOf: cartId]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorCarritoExpirado.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test11CheckoutAnExpiredCartShouldFail

	| aRestInterface cartId clock |

	clock := testObjectsFactory createClockOnCurrentTime.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: clock.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	clock advanceTimeIn: (3 hours).
	self should: [aRestInterface checkoutCart: cartId withCreditCardNumber: testObjectsFactory validCreditCardNumber withExpirationDate: testObjectsFactory notExpiredCreditCardFormattedString fromOwner: testObjectsFactory defaultClient on: testObjectsFactory today.]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorCarritoExpirado.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test12CannotCheckoutWhenTheCreditCardHasNoCredit

	| aRestInterface cartId |
	
	debitBehavior := [ :anAmount :aCreditCard | self error: InternalRestInterface mensajeDeErrorTarjetaSinFondos].
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
		
	self should: 
		[aRestInterface checkoutCart: cartId withCreditCardNumber: testObjectsFactory validCreditCardNumber withExpirationDate: testObjectsFactory notExpiredCreditCardFormattedString fromOwner: testObjectsFactory defaultClient on: testObjectsFactory today.]  
	raise: Error
	withExceptionDo: 
		[:anError |
			self assert: anError messageText equals: InternalRestInterface mensajeDeErrorTarjetaSinFondos.
			self assert: (aRestInterface listPurchasesBy: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword) items isEmpty.
		].
 	
! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test13CannotAddItemsThatArentPresentInTheCatalog

	| aRestInterface cartId |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.

	self should: [aRestInterface add: 1 of: 'bondiola ISBN' toCart: cartId]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorItemInvalido.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test14CannotAddAnInvalidAmountOfItems

	| aRestInterface cartId |
	
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.

	self should: [aRestInterface add: -1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorCantidadInvalida.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test15CannotCheckoutAnEmptyCart

	| aRestInterface cartId ccn cco cced |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.

	self should: [
		ccn := testObjectsFactory validCreditCardNumber.
		cco := testObjectsFactory defaultClient.
		cced := testObjectsFactory notExpiredCreditCardFormattedString.
		aRestInterface checkoutCart: cartId withCreditCardNumber: ccn withExpirationDate: cced fromOwner: cco on: testObjectsFactory today.
	]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorCarritoVacio.
		self assert: (aRestInterface listPurchasesBy: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword) items isEmpty.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'd 12/1/2018 18:12:11'!
test16CannotCheckoutACartWithAnInvalidCreditCardNumber

	| aRestInterface cartId ccn cco cced |

	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: testObjectsFactory defaultAuthInfo andRegistry: (RestInterfaceCartRegistry new) through: self withClock: testObjectsFactory createClockOnCurrentTime.
	cartId := aRestInterface createNewCartFor: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword.

	self should: [
		ccn := testObjectsFactory invalidCreditCardNumber.
		cco := testObjectsFactory defaultClient.
		cced := testObjectsFactory notExpiredCreditCardFormattedString.
		aRestInterface checkoutCart: cartId withCreditCardNumber: ccn withExpirationDate: cced fromOwner: cco on: testObjectsFactory today.
	]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorNumeroDeTarjetaInvalido.
		self assert: (aRestInterface listPurchasesBy: testObjectsFactory defaultClient withPassword: testObjectsFactory defaultClientPassword) items isEmpty.
	].! !


!InternalRestInterfaceTest methodsFor: 'setup' stamp: 'd 11/30/2018 18:09:14'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'd 11/30/2018 18:10:01'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #Cart category: #'TusLibros-Iteracion3'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cart methodsFor: 'assertions' stamp: 'ps 12/1/2018 13:07:40'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self class invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'ps 12/1/2018 13:07:57'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self class invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

!Cart methodsFor: 'adding' stamp: 'ps 11/22/2018 20:26:04'!
content

	^ items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Iteracion3'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error messages' stamp: 'ps 12/1/2018 13:05:40'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'ps 12/1/2018 13:05:22'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!classDefinition: #Cashier category: #'TusLibros-Iteracion3'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'ps 11/25/2018 21:33:16'!
createSale

	^ Sale of: total withItems: cart content
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Iteracion3'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientPurchasesSummary category: #'TusLibros-Iteracion3'!
Object subclass: #ClientPurchasesSummary
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!ClientPurchasesSummary methodsFor: 'initialization' stamp: 'ps 11/26/2018 20:54:11'!
initializeWithItems: aBag andTotalAmount: totalAmount

	items := aBag.
	total := totalAmount.! !


!ClientPurchasesSummary methodsFor: 'accessing' stamp: 'ps 11/26/2018 20:54:15'!
items

	^ items copy! !

!ClientPurchasesSummary methodsFor: 'accessing' stamp: 'ps 11/26/2018 20:54:23'!
total

	^ total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientPurchasesSummary class' category: #'TusLibros-Iteracion3'!
ClientPurchasesSummary class
	instanceVariableNames: 'items total'!

!ClientPurchasesSummary class methodsFor: 'instance creation' stamp: 'ps 11/26/2018 19:26:13'!
withItems: aDictionary andTotalAmount: totalAmount

	^ self new initializeWithItems: aDictionary andTotalAmount: totalAmount ! !


!classDefinition: #CreditCard category: #'TusLibros-Iteracion3'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'ps 12/1/2018 16:20:04'!
initializeExpiringOn: aMonth withOwner: aCreditCardOwner withNumber: aCreditCardNumber

	expiration := aMonth.
	owner := aCreditCardOwner.
	number := aCreditCardNumber.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Iteracion3'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'ps 12/1/2018 16:20:21'!
expiringOn: aMonth withOwner: aCreditCardOwner withNumber: aCreditCardNumber
	
	self assertValidNumber: aCreditCardNumber.
	^ self new initializeExpiringOn: aMonth withOwner: aCreditCardOwner withNumber: aCreditCardNumber! !


!CreditCard class methodsFor: 'error messages' stamp: 'ps 12/1/2018 16:21:46'!
invalidCreditCardNumber

	^ 'invalidCreditCardNumber'! !


!CreditCard class methodsFor: 'assertions' stamp: 'ps 12/1/2018 16:21:07'!
assertValidNumber: aCreditCardNumber

	(aCreditCardNumber size = 16) ifFalse: [self error: self invalidCreditCardNumber].! !


!classDefinition: #CustomizableClock category: #'TusLibros-Iteracion3'!
Object subclass: #CustomizableClock
	instanceVariableNames: 'currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CustomizableClock methodsFor: 'time' stamp: 'ps 11/26/2018 17:51:42'!
advanceTimeIn: aDelta

	currentTime := currentTime + aDelta! !

!CustomizableClock methodsFor: 'time' stamp: 'ps 11/26/2018 18:00:31'!
currentTime

	^ currentTime! !


!CustomizableClock methodsFor: 'initialization' stamp: 'ps 11/26/2018 17:51:06'!
initializeOnCurrentTime: aDateAndTime 

	currentTime := aDateAndTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomizableClock class' category: #'TusLibros-Iteracion3'!
CustomizableClock class
	instanceVariableNames: ''!

!CustomizableClock class methodsFor: 'instance creation' stamp: 'ps 11/26/2018 17:59:55'!
onCurrentTime: aDateAndTime

	^ self new initializeOnCurrentTime: aDateAndTime ! !


!classDefinition: #InternalRestInterface category: #'TusLibros-Iteracion3'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'userPassword catalog cartRegistry purchasesByClient merchantProcessor cartLastUseTime clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'ps 11/26/2018 17:48:24'!
initializeWithCatalog: aCatalog andAuthInfo: aUserPasswordDictionary andRegistry: aCartRegistry through: aMerchantProcessor withClock: aClock

	catalog := aCatalog.
	userPassword := aUserPasswordDictionary.
	cartRegistry := aCartRegistry.
	purchasesByClient := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	cartLastUseTime := Dictionary new.
	clock := aClock.! !


!InternalRestInterface methodsFor: 'services' stamp: 'ps 12/1/2018 15:23:41'!
add: anAmount of: anISBN toCart: aCartId 

	| cart |

	cart := self getCartWithId: aCartId.
	cart add: anAmount of: anISBN.
	self updateLastUseTimeOf: aCartId.! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 12/1/2018 15:24:00'!
checkoutCart: aCartId withCreditCardNumber: aCreditCardNumber withExpirationDate: aFormattedDate fromOwner: aCreditCardOwner on: aDate

	| creditCard lastPurchase cart |

	cart := self getCartWithId: aCartId.
	creditCard := CreditCard expiringOn: (aFormattedDate asMonth) withOwner: aCreditCardOwner withNumber: aCreditCardNumber.
	lastPurchase := self checkoutCart: cart charging: creditCard through: merchantProcessor on: aDate.
	self registerLastPurchase: lastPurchase fromClient: aCreditCardOwner.! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 12/1/2018 15:25:39'!
createNewCartFor: aClient withPassword: aPassword

	self validateUser: aClient andPassword: aPassword.
	^ self registerNewCart.! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 12/1/2018 15:24:36'!
listItemsOf: aCartId 

	| cart |
	
	cart := self getCartWithId: aCartId.
	^ cart content! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 12/1/2018 14:04:05'!
listPurchasesBy: aClient withPassword: aPassword

	self validateUser: aClient andPassword: aPassword.
	^ self summarizePurchasesBy: aClient ! !


!InternalRestInterface methodsFor: 'private' stamp: 'ps 11/26/2018 18:17:52'!
checkCartIsStillValid: aCartId

	((clock currentTime) - (cartLastUseTime at: aCartId)) < (30 minutes) ifFalse: [self error: self class mensajeDeErrorCarritoExpirado]! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 12/1/2018 14:58:58'!
checkoutCart: aCart charging: creditCard through: merchantProcessor on: aDate

	| cashier salesBook |

	salesBook := OrderedCollection new.
	cashier := Cashier toCheckout: aCart charging: creditCard throught: merchantProcessor on: aDate registeringOn: salesBook.
	cashier checkOut.
	^ salesBook at: 1! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 12/1/2018 15:22:26'!
getCartWithId: aCartId

	| aCart |

	aCart := cartRegistry getCartWithId: aCartId.
	self checkCartIsStillValid: aCartId.
	^ aCart! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 12/1/2018 14:49:28'!
registerLastPurchase: aSale fromClient: aCreditCardOwner

	| clientPurchases |

	clientPurchases := purchasesByClient at: aCreditCardOwner ifAbsent: [OrderedCollection new].
	clientPurchases add: aSale.
	purchasesByClient at: aCreditCardOwner put: clientPurchases.! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 12/1/2018 15:13:50'!
registerNewCart

	| cartId |

	cartId := cartRegistry registerNewCart: (Cart acceptingItemsOf: catalog).
	self updateLastUseTimeOf: cartId.
	^ cartId! !

!InternalRestInterface methodsFor: 'private' stamp: 'd 12/1/2018 17:33:06'!
summarizePurchasesBy: aClient

	| items total |

	items := Bag new.
	total := 0.
	(purchasesByClient at: aClient ifAbsent: [OrderedCollection new]) do: [
		:aSale |
		items addAll: aSale items.
		total := total + aSale total.
	].
	^ ClientPurchasesSummary withItems: items andTotalAmount: total.! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 11/26/2018 17:29:08'!
updateLastUseTimeOf: cartId

	cartLastUseTime at: cartId put: clock currentTime.! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 11/25/2018 12:27:18'!
validateUser: aClient andPassword: aPassword

	| password |

	password := userPassword at: aClient ifAbsent: [self error: self class mensajeDeErrorUsuarioInexistente ].
	password = aPassword ifFalse: [self error: self class mensajeDeErrorContraseñaIncorrecta ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InternalRestInterface class' category: #'TusLibros-Iteracion3'!
InternalRestInterface class
	instanceVariableNames: ''!

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 12/1/2018 12:58:02'!
mensajeDeErrorCantidadInvalida

	^ Cart invalidQuantityErrorMessage! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/26/2018 17:34:15'!
mensajeDeErrorCarritoExpirado

	^ 'elCarritoYaExpiro'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 12/1/2018 13:59:43'!
mensajeDeErrorCarritoVacio

	^ Cashier cartCanNotBeEmptyErrorMessage! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/22/2018 20:01:01'!
mensajeDeErrorContraseñaIncorrecta

	^ 'laContraseñaEsIncorrecta'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'd 12/1/2018 18:12:11'!
mensajeDeErrorIdDeCarritoInvalido

	^ RestInterfaceCartRegistry mensajeDeErrorIdDeCarritoInvalido! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 12/1/2018 13:09:51'!
mensajeDeErrorItemInvalido

	^ Cart invalidItemErrorMessage ! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 12/1/2018 16:26:16'!
mensajeDeErrorNumeroDeTarjetaInvalido

	^ CreditCard invalidCreditCardNumber! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 12/1/2018 13:46:31'!
mensajeDeErrorTarjetaExpirada

	^ Cashier canNotChargeAnExpiredCreditCardErrorMessage! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 12/1/2018 14:08:06'!
mensajeDeErrorTarjetaSinFondos

	^ Cashier creditCardHasNoCreditErrorMessage! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/22/2018 19:56:56'!
mensajeDeErrorUsuarioInexistente

	^ 'elUsuarioNoExiste'! !


!InternalRestInterface class methodsFor: 'instance creation' stamp: 'ps 11/26/2018 17:47:57'!
withCatalog: aCatalog andAuthInfo: aUserPasswordDictionary andRegistry: aCartRegistry through: aMerchantProcessor withClock: aClock

	^ self new initializeWithCatalog: aCatalog andAuthInfo: aUserPasswordDictionary andRegistry: aCartRegistry through: aMerchantProcessor withClock: aClock! !


!classDefinition: #RestInterfaceCartRegistry category: #'TusLibros-Iteracion3'!
Object subclass: #RestInterfaceCartRegistry
	instanceVariableNames: 'carts nextId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!RestInterfaceCartRegistry methodsFor: 'cart accessing' stamp: 'ps 12/1/2018 13:28:05'!
getCartWithId: aCartId

	^ carts at: aCartId ifAbsent: [self error: self class mensajeDeErrorIdDeCarritoInvalido]! !

!RestInterfaceCartRegistry methodsFor: 'cart accessing' stamp: 'ps 11/25/2018 12:10:52'!
registerNewCart: aCart

	| cartId |
	cartId := self getNextId.
	carts at: cartId put: aCart.
	^ cartId! !


!RestInterfaceCartRegistry methodsFor: 'initialization' stamp: 'ps 11/25/2018 12:31:17'!
initialize

	carts := Dictionary new.
	nextId := 1.! !


!RestInterfaceCartRegistry methodsFor: 'private' stamp: 'ps 11/25/2018 12:09:30'!
getNextId

	nextId := nextId + 1.
	^ nextId - 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterfaceCartRegistry class' category: #'TusLibros-Iteracion3'!
RestInterfaceCartRegistry class
	instanceVariableNames: ''!

!RestInterfaceCartRegistry class methodsFor: 'error messages' stamp: 'ps 12/1/2018 13:28:19'!
mensajeDeErrorIdDeCarritoInvalido

	^ 'elIdDeCarritoEsInvalido'! !


!classDefinition: #Sale category: #'TusLibros-Iteracion3'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Sale methodsFor: 'total' stamp: 'ps 11/25/2018 21:34:09'!
items
	
	^ items copy! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'ps 11/25/2018 21:32:18'!
initializeTotal: aTotal withItems: anOrderedCollection

	total := aTotal. 
	items := anOrderedCollection.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Iteracion3'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'd 12/1/2018 18:14:26'!
of: aTotal withItems: anOrderedCollection

	^self new initializeTotal: aTotal withItems: anOrderedCollection! !


!classDefinition: #StoreTestObjectsFactory category: #'TusLibros-Iteracion3'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'd 12/1/2018 18:00:22'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1) withOwner: 'cacho' withNumber: self validCreditCardNumber.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ps 11/26/2018 18:35:47'!
expiredCreditCardFormattedString
	
	| year month |
	
	year := ((GregorianMonthOfYear current year number)-2) asString.
	month := GregorianMonthOfYear current month number asString.
	^ year , '-' , month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ps 12/1/2018 15:30:44'!
invalidCreditCardNumber
	
	^ '1234'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'd 12/1/2018 18:00:29'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1) withOwner: 'cacho' withNumber: self validCreditCardNumber.! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ps 11/26/2018 18:36:37'!
notExpiredCreditCardFormattedString
	
	| year month |
	
	year := ((GregorianMonthOfYear current year number)+2) asString.
	month := GregorianMonthOfYear current month number asString.
	^ year , '-' , month! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'ps 12/1/2018 15:30:30'!
validCreditCardNumber
	
	^ '1111222233334444'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'clock' stamp: 'ps 11/26/2018 17:57:56'!
createClockOnCurrentTime

	^ CustomizableClock onCurrentTime: (DateAndTime nowUpToSeconds)! !


!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'ps 12/1/2018 15:43:43'!
defaultAuthInfo

	| authInfo |

	authInfo := Dictionary new.
	authInfo at: self defaultClient put: self defaultClientPassword.
	^ authInfo! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'ps 12/1/2018 15:42:59'!
defaultClient

	^ 'unCliente'
! !

!StoreTestObjectsFactory methodsFor: 'authentication' stamp: 'ps 12/1/2018 15:43:16'!
defaultClientPassword

	^ 'password'! !
