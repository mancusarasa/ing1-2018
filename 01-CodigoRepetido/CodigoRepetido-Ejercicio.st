!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/20/2018 20:52:41'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| addCustomer |
	
	addCustomer:= [ | customerBook | customerBook := CustomerBook  new.
	customerBook addCustomerNamed: 'John Lennon'.].
	self assertClosure: addCustomer TakesLessThan: 50.
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/20/2018 20:55:03'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney removeCustomer |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	  
	removeCustomer := [customerBook removeCustomerNamed: paulMcCartney.].
	self assertClosure: removeCustomer TakesLessThan: 100. 

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/20/2018 21:17:54'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook tryClosure catchClosure|
			
	customerBook := CustomerBook new.

	tryClosure := [
		customerBook addCustomerNamed: ''.
		self fail
	].
	catchClosure :=  [
		 :anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty
	].
	self try: tryClosure on: Error catch: catchClosure. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/20/2018 21:12:31'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon tryClosure catchClosure |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	tryClosure := [ 
		customerBook removeCustomerNamed: 'Paul McCartney'.
		self fail
	]. 
	catchClosure :=  [ 
		:anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)
	].
	self try: tryClosure on:  NotFound catch: catchClosure.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 9/20/2018 09:21:59'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 1 equals: customerBook numberOfSuspendedCustomers.
	self assert: 1 equals: customerBook numberOfCustomers.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 9/20/2018 09:23:02'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assert: 0 equals: customerBook numberOfActiveCustomers.
	self assert: 0 equals: customerBook numberOfSuspendedCustomers.
	self assert: 0 equals: customerBook numberOfCustomers.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/20/2018 21:36:29'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon tryClosure catchClosure |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	tryClosure:= [ 
		customerBook suspendCustomerNamed: 'Paul McCartney'.
		self fail 
	].
	
	catchClosure:=[ :anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)
	].
	
	self try: tryClosure  on: CantSuspend catch: catchClosure. 
		
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/20/2018 21:39:18'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon tryClosure catchClosure |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	tryClosure:= [ 
		customerBook suspendCustomerNamed: johnLennon.
		self fail 
	].
	 
	catchClosure:= [
		:anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon) 
	].
	self try: tryClosure on: CantSuspend  catch: catchClosure. 
	
		
! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/20/2018 20:49:35'!
assertClosure: aClosure TakesLessThan: milliSeconds
	|millisecondsBeforeRunning millisecondsAfterRunning|

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (milliSeconds * millisecond)! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/20/2018 21:14:26'!
try: tryClosure on: anError catch: catchClosure
	
	tryClosure on: anError do: [ :error | catchClosure value: error].! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers suspended'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:28'!
includesCustomerNamed: aName

	^(customers includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:38'!
isEmpty
	
	^customers isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NicolasRinaldi 9/16/2018 21:55:33'!
initialize

	super initialize.
	customers := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'HAW 9/19/2018 08:41:11'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((customers includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NicolasRinaldi 9/16/2018 22:01:43'!
numberOfCustomers
	
	^customers size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 9/20/2018 20:40:00'!
removeCustomerNamed: aName 
	| removeCustomerInCollection |
	
	removeCustomerInCollection := [:aCollection |	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)	ifTrue: [
				aCollection removeAt: index.
				^ aName 
			] 
	].].
	removeCustomerInCollection value: customers.
	removeCustomerInCollection value: suspended.
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:27:55'!
suspendCustomerNamed: aName 
	
	(customers includes: aName) ifFalse: [^CantSuspend signal].
	
	customers remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
