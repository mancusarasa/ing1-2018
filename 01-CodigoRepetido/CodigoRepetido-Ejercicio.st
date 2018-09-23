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

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/23/2018 11:30:50'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self 	assertClosure: [customerBook addCustomerNamed: 'John Lennon'.] 
			TakesLessThan: 50.
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/23/2018 11:29:01'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| paulMcCartney |

	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.

	self 	assertClosure:  [customerBook removeCustomerNamed: paulMcCartney.]
			TakesLessThan: 100. ! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ps 9/23/2018 12:54:35'!
test03CanNotAddACustomerWithEmptyName 

	| assertClosure |

	assertClosure :=  [
		 :anError | 
		self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
		self assert: customerBook isEmpty
	].
	self performClosure: [customerBook addCustomerNamed: ''.] expectingError: Error andPerformPostErrorAssertions: assertClosure.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ps 9/23/2018 12:55:53'!
test04CanNotRemoveAnInvalidCustomer
	
	| johnLennon |
		
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self 	performClosure: [customerBook removeCustomerNamed: 'Paul McCartney'.]  
			expectingError: NotFound 
			andPerformPostErrorAssertions:  [:anError | self assertThereIsOnlyOneCustomerNamed: johnLennon.].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/23/2018 11:19:39'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertAmountOfActive: 0 suspended: 1 total: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'd 9/23/2018 11:19:44'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| paulMcCartney|

	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertAmountOfActive: 0 suspended: 0 total: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ps 9/23/2018 12:56:46'!
test07CanNotSuspendAnInvalidCustomer
	
	| johnLennon |
			
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.

	self 	performClosure: [customerBook suspendCustomerNamed: 'Paul McCartney'.] 
			expectingError: CantSuspend 
			andPerformPostErrorAssertions: [ :anError | self assertThereIsOnlyOneCustomerNamed: johnLennon.].! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ps 9/23/2018 12:57:51'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.

	self 	performClosure: [customerBook suspendCustomerNamed: johnLennon.] 
			expectingError:CantSuspend 
			andPerformPostErrorAssertions: [ :anError | self assertThereIsOnlyOneCustomerNamed: johnLennon.].
		
		
		
! !


!CustomerBookTest methodsFor: 'setUp' stamp: 'd 9/22/2018 15:57:51'!
setUp
	customerBook := CustomerBook  new.! !


!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/23/2018 11:19:23'!
assertAmountOfActive: activeCustomers suspended: suspendedCustomers total: totalCustomers
	
	self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
	self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: totalCustomers equals: customerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/20/2018 20:49:35'!
assertClosure: aClosure TakesLessThan: milliSeconds
	|millisecondsBeforeRunning millisecondsAfterRunning|

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (milliSeconds * millisecond)! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/23/2018 11:37:32'!
assertThereIsOnlyOneCustomerNamed: aName.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: aName).! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'd 9/23/2018 10:50:37'!
fail: failClosure onError: anError assert: assertClosure
	
	[failClosure value. self fail. ] on: anError do: [ :error | assertClosure value: error].! !

!CustomerBookTest methodsFor: 'auxiliares' stamp: 'ps 9/23/2018 12:53:09'!
performClosure: failClosure expectingError: anError andPerformPostErrorAssertions: assertClosure
	
	[failClosure value. self fail. ] on: anError do: [ :error | assertClosure value: error].! !


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
