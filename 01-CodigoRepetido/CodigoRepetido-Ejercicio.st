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
	instanceVariableNames: 'customerBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 16:02:00'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| addCustomer |
	
	addCustomer:= [customerBook addCustomerNamed: 'John Lennon'.].
	self assertClosure: addCustomer TakesLessThan: 50.
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 16:21:08'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney removeCustomer |

	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.
	  
	removeCustomer := [customerBook removeCustomerNamed: paulMcCartney.].
	self assertClosure: removeCustomer TakesLessThan: 100. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 16:10:37'!
test03CanNotAddACustomerWithEmptyName 

	| tryClosure catchClosure|
			
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

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 15:58:47'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon tryClosure catchClosure |
		
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

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 16:02:56'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertActive: 0 suspended: 1 total: 1 in: customerBook.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 15:59:02'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|

	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertActive: 0 suspended: 0 total: 0 in: customerBook.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 16:10:27'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon tryClosure catchClosure |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	tryClosure:= [ 
		customerBook suspendCustomerNamed: 'Paul McCartney'.
		self fail 
	].
	catchClosure:=[ 
		:anError | 
		self assert: customerBook numberOfCustomers = 1.
		self assert: (customerBook includesCustomerNamed: johnLennon)
	].
	self try: tryClosure  on: CantSuspend catch: catchClosure. 
		
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/22/2018 16:11:02'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon tryClosure catchClosure |
	
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


!CustomerBookTest methodsFor: 'setUp' stamp: 'd 9/22/2018 15:57:51'!
setUp
	customerBook := CustomerBook  new.! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/22/2018 15:36:18'!
assertActive: activeCustomers Suspended: suspendedCustomers Total: totalCustomers
	! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/22/2018 15:37:24'!
assertActive: activeCustomers suspended: suspendedCustomers total: totalCustomers in: aCustomerBook
	
	self assert: activeCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: aCustomerBook numberOfCustomers.! !

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


!CustomerBook methodsFor: 'customer management' stamp: 'd 9/21/2018 10:57:15'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 9/21/2018 10:59:14'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 9/21/2018 17:53:03'!
removeCustomerNamed: aName 

	customers remove: aName ifAbsent: [suspended remove: aName ifAbsent:[^ NotFound signal.]].
	
	^ aName
! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 9/21/2018 17:33:59'!
signalCustomerAlreadyExists 

	self signalCustomerClass: #customerAlreadyExistsErrorMessage.! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 9/21/2018 17:33:48'!
signalCustomerNameCannotBeEmpty 

	self signalCustomerClass: #customerCanNotBeEmptyErrorMessage. ! !

!CustomerBook methodsFor: 'customer management' stamp: 'd 9/21/2018 17:56:20'!
suspendCustomerNamed: aName 
		
	customers remove: aName ifAbsent: [^CantSuspend signal].
	suspended add: aName.! !


!CustomerBook methodsFor: 'signals' stamp: 'd 9/21/2018 17:11:54'!
signalCustomerClass: aMessage

	self error: (self class perform: aMessage).! !

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
