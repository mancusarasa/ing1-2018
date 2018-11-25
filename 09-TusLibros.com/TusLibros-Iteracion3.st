!classDefinition: #CartTest category: #'TusLibros-Iteracion3'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:51:17'!
test01ANonExistentUserCantCreateACart

	| aRestInterface |
	
	aRestInterface := InternalRestInterface withCatalog: (testObjectsFactory defaultCatalog) andAuthInfo: (Dictionary new) andRegistry: (CartRegistry new) through: self.
	self should: [
		aRestInterface createNewCartFor: 'ClienteInexistente' withPassword: 'password'. 
	]
	raise: Error withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorUsuarioInexistente.
	]! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:52:09'!
test02AnExistentUserWithTheWrongPasswordCantCreateANewCart

	| aRestInterface usersPasswords |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	self should: [
		aRestInterface createNewCartFor: 'unCliente' withPassword: 'passworddddd'. 
	]
	raise: Error withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorContraseñaIncorrecta.
	]! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:51:33'!
test03ANewCartIsEmptyWhenCreated

	| aRestInterface usersPasswords cartId cartItems |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	cartId := aRestInterface createNewCartFor: 'unCliente' withPassword: 'password'.
	cartItems := aRestInterface listItemsOf: cartId.
	self assert: cartItems equals: OrderedCollection new.! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:51:36'!
test04ItemsAddedToACartAreListedInItsItems

	| aRestInterface usersPasswords cartId cartItems |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	cartId := aRestInterface createNewCartFor: 'unCliente' withPassword: 'password'.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	cartItems := aRestInterface listItemsOf: cartId.
	self assert: cartItems equals: (OrderedCollection with: testObjectsFactory itemSellByTheStore)! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:51:39'!
test05CannotAddItemsToAnInvalidCart

	| aRestInterface usersPasswords cartId |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	cartId := aRestInterface createNewCartFor: 'unCliente' withPassword: 'password'.

	self should: [aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId +1]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorIdDeCarritoInvalido.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:51:42'!
test06CannotListItemsOfAnInvalidCart

	| aRestInterface usersPasswords cartId |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	cartId := aRestInterface createNewCartFor: 'unCliente' withPassword: 'password'.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	
	self should: [aRestInterface listItemsOf: cartId+1]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorIdDeCarritoInvalido.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:51:46'!
test07CheckoutCartWithExpiredCreditCardShouldFail

	| aRestInterface usersPasswords cartId |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	cartId := aRestInterface createNewCartFor: 'unCliente' withPassword: 'password'.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.

	self should: [aRestInterface checkoutCart: cartId ofClientId: 'unCliente' withCreditCard: testObjectsFactory expiredCreditCard on: testObjectsFactory today]
	raise: Error
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: InternalRestInterface mensajeDeErrorTarjetaExpirada.
		self assert: (aRestInterface listPurchasesBy: 'unCliente' withPassword: 'password') isEmpty.
	].! !

!InternalRestInterfaceTest methodsFor: 'testing' stamp: 'ps 11/25/2018 15:55:06'!
test08CheckoutCartWithValidCreditCardShouldReflectOnTheClientPurchases

	| aRestInterface usersPasswords cartId clientPurchases |
	
	usersPasswords := Dictionary new.
	usersPasswords at: 'unCliente' put: 'password'.
	aRestInterface := InternalRestInterface withCatalog: testObjectsFactory defaultCatalog andAuthInfo: usersPasswords andRegistry: (CartRegistry new) through: self.
	cartId := aRestInterface createNewCartFor: 'unCliente' withPassword: 'password'.
	aRestInterface add: 1 of: (testObjectsFactory itemSellByTheStore) toCart: cartId.
	aRestInterface checkoutCart: cartId ofClientId: 'unCliente' withCreditCard: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	clientPurchases := aRestInterface listPurchasesBy: 'unCliente' withPassword: 'password'.
	self assert: clientPurchases size equals: 1.
	" aca faltan assertions sobre el item presente en clientPurchases"! !


!InternalRestInterfaceTest methodsFor: 'setup' stamp: 'ps 11/22/2018 20:52:10'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.! !


!InternalRestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'ps 11/25/2018 15:53:14'!
debit: anAmount from: aCreditCard! !


!classDefinition: #Cart category: #'TusLibros-Iteracion3'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


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


!classDefinition: #CartRegistry category: #'TusLibros-Iteracion3'!
Object subclass: #CartRegistry
	instanceVariableNames: 'carts nextId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CartRegistry methodsFor: 'cart accessing' stamp: 'ps 11/25/2018 12:13:53'!
getCartWithId: aCartId ifAbsent: aBlockClosure

	^ carts at: aCartId ifAbsent: [aBlockClosure value]! !

!CartRegistry methodsFor: 'cart accessing' stamp: 'ps 11/25/2018 12:10:52'!
registerNewCart: aCart

	| cartId |
	cartId := self getNextId.
	carts at: cartId put: aCart.
	^ cartId! !


!CartRegistry methodsFor: 'initialization' stamp: 'ps 11/25/2018 12:31:17'!
initialize

	carts := Dictionary new.
	nextId := 1.! !


!CartRegistry methodsFor: 'private' stamp: 'ps 11/25/2018 12:09:30'!
getNextId

	nextId := nextId + 1.
	^ nextId - 1! !


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

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
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


!classDefinition: #CreditCard category: #'TusLibros-Iteracion3'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Iteracion3'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #InternalRestInterface category: #'TusLibros-Iteracion3'!
Object subclass: #InternalRestInterface
	instanceVariableNames: 'userPassword catalog cartRegistry purchasesByClient cart merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!InternalRestInterface methodsFor: 'initialization' stamp: 'ps 11/25/2018 15:47:09'!
initializeWithCatalog: aCatalog andAuthInfo: aUserPasswordDictionary andRegistry: aCartRegistry through: aMerchantProcessor

	catalog := aCatalog.
	userPassword := aUserPasswordDictionary.
	cartRegistry := aCartRegistry.
	purchasesByClient := Dictionary new.
	merchantProcessor := aMerchantProcessor.! !


!InternalRestInterface methodsFor: 'services' stamp: 'ps 11/25/2018 12:36:51'!
add: anAmount of: anISBN toCart: aCartId 

	(cartRegistry getCartWithId: aCartId ifAbsent: [self error: self class mensajeDeErrorIdDeCarritoInvalido]) add: anAmount of: anISBN.! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 11/25/2018 15:54:36'!
checkoutCart: aCartId ofClientId: aClientId withCreditCard: aCreditCard on: aDate

	| cashier salesBook clientPurchases |
	
	self assertCreditCard: aCreditCard isNotExpiredOn: aDate.
	cart := cartRegistry getCartWithId: aCartId ifAbsent: [].
	salesBook := OrderedCollection new.
	cashier := Cashier toCheckout: cart charging: aCreditCard throught: merchantProcessor on: aDate registeringOn: salesBook.
	cashier checkOut.
	clientPurchases := purchasesByClient at: aClientId ifAbsent: [OrderedCollection new].
	clientPurchases add: (salesBook at: 1).
	purchasesByClient at: aClientId put: clientPurchases.


! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 11/25/2018 12:29:13'!
createNewCartFor: aClient withPassword: aPassword

	self validateUser: aClient andPassword: aPassword.
	^ self registerNewCart: (Cart acceptingItemsOf: catalog).
! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 11/25/2018 12:39:00'!
listItemsOf: aCartId 

	^ (cartRegistry getCartWithId: aCartId ifAbsent: [self error: self class mensajeDeErrorIdDeCarritoInvalido]) content! !

!InternalRestInterface methodsFor: 'services' stamp: 'ps 11/25/2018 15:04:06'!
listPurchasesBy: aClient withPassword: aPassword

	self validateUser: aClient andPassword: aPassword.
	^ purchasesByClient at: aClient ifAbsent: [OrderedCollection new]! !


!InternalRestInterface methodsFor: 'private' stamp: 'ps 11/25/2018 14:19:44'!
assertCreditCard: aCreditCard isNotExpiredOn: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self error: self class mensajeDeErrorTarjetaExpirada]! !

!InternalRestInterface methodsFor: 'private' stamp: 'ps 11/25/2018 12:29:28'!
registerNewCart: aCart

	^ cartRegistry registerNewCart: aCart! !

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

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/22/2018 20:01:01'!
mensajeDeErrorContraseñaIncorrecta

	^ 'laContraseñaEsIncorrecta'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/22/2018 21:06:35'!
mensajeDeErrorIdDeCarritoInvalido

	^ 'elIdDeCarritoEsInvalido'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/25/2018 14:25:46'!
mensajeDeErrorTarjetaExpirada

	^ 'laTarjetaEstaExpirada'! !

!InternalRestInterface class methodsFor: 'error messages' stamp: 'ps 11/22/2018 19:56:56'!
mensajeDeErrorUsuarioInexistente

	^ 'elUsuarioNoExiste'! !


!InternalRestInterface class methodsFor: 'instance creation' stamp: 'ps 11/25/2018 15:50:58'!
withCatalog: aCatalog andAuthInfo: aUserPasswordDictionary andRegistry: aCartRegistry through: aMerchantProcessor

	^ self new initializeWithCatalog: aCatalog andAuthInfo: aUserPasswordDictionary andRegistry: aCartRegistry through: aMerchantProcessor! !


!classDefinition: #Sale category: #'TusLibros-Iteracion3'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Iteracion3'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #'TusLibros-Iteracion3'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


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


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
