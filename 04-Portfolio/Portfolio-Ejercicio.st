!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'ps 10/11/2018 21:16:53'!
relativeValue

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'ps 10/11/2018 21:17:10'!
relativeValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ps 10/11/2018 21:17:34'!
relativeValue

	^ -1*value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'accounts' stamp: 'd 10/14/2018 19:12:41'!
allAccounts
	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'ps 10/11/2018 21:28:39'!
balance

	^ accounts sum: [:anElement | anElement balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'testing' stamp: 'ps 10/15/2018 20:40:58'!
doesManage: anAccount

	^accounts anySatisfy: [:aSummarizingAccount | aSummarizingAccount=anAccount or: (aSummarizingAccount doesManage: anAccount)]! !

!Portfolio methodsFor: 'testing' stamp: 'ps 10/15/2018 20:41:13'!
hasRegistered: aTransaction

	^accounts anySatisfy: [:aSummarizingAccount | aSummarizingAccount hasRegistered: aTransaction]! !


!Portfolio methodsFor: 'transactions' stamp: 'ps 10/13/2018 12:14:33'!
transactions 

	^accounts inject: OrderedCollection new into: [
		:transactions :anAccount |
		transactions addAll: anAccount transactions.
		transactions
	].! !

!Portfolio methodsFor: 'transactions' stamp: 'ps 10/15/2018 20:41:53'!
transactionsOf: anAccount 

	(self doesManage: anAccount)  ifFalse: [self error: Portfolio accountNotManagedMessageDescription]. 
	^anAccount transactions.! !


!Portfolio methodsFor: 'initialization' stamp: 'ps 10/11/2018 21:22:13'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts ! !


!Portfolio methodsFor: 'accounts' stamp: 'ps 10/15/2018 21:00:30'!
allAccounts

	^accounts inject: OrderedCollection new into: [
		:totalAccounts :anAccount |
		totalAccounts addAll: anAccount allAccounts.
		totalAccounts
	].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'ps 10/15/2018 21:00:18'!
verifyThereAreNoRepeatedAccountsIn: aCollectionOfAccounts
	
	| accountsAndSubAccounts |

	accountsAndSubAccounts := aCollectionOfAccounts inject: OrderedCollection new into:[
		:accountsAccumulator :aSummarizingAccount |
		accountsAccumulator addAll: aSummarizingAccount allAccounts.
		accountsAccumulator
	] .
	accountsAndSubAccounts do: [ :aSummarizingAccount |
		(accountsAndSubAccounts occurrencesOf: aSummarizingAccount) > 1 ifTrue: [self error: Portfolio accountAlreadyManagedErrorMessage]
	].! !

!Portfolio class methodsFor: 'instance creation' stamp: 'd 10/14/2018 18:35:53'!
with: leftAccount with: rightAccount

	^self withAll: (OrderedCollection with: leftAccount with: rightAccount).! !

!Portfolio class methodsFor: 'instance creation' stamp: 'ps 10/15/2018 20:48:10'!
withAll: aCollectionOfAccounts
	| accounts accountsAndSubAccounts|
	
	accounts := OrderedCollection new.
	accountsAndSubAccounts:= OrderedCollection new.
	
	aCollectionOfAccounts do: [:aSummarizingAccount | accountsAndSubAccounts addAll: aSummarizingAccount allAccounts ].
		
	accountsAndSubAccounts do: [:aSummarizingAccount | accounts detect:[ :anAccount | aSummarizingAccount=anAccount] ifFound: [:repeatedAccount | self error: Portfolio accountAlreadyManagedErrorMessage] ifNone:[accounts add: aSummarizingAccount] ].
	self verifyThereAreNoRepeatedAccountsIn: aCollectionOfAccounts.
	
	
	^self new initializeWithAll: aCollectionOfAccounts.! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'ps 10/15/2018 21:01:23'!
balance

	^ transactions inject: 0 into: [:subTotal :aTrx | subTotal + aTrx relativeValue]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'ps 10/15/2018 20:39:13'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'accounts' stamp: 'ps 10/15/2018 21:01:12'!
allAccounts 

	^ OrderedCollection with: self.! !
