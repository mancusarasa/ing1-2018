!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'ps 10/11/2018 21:16:53'!
relativeValue

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'evaluating' stamp: 'ps 10/22/2018 20:31:06'!
accept: aVisitor

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'amount duration interestRate account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'value' stamp: 'ps 10/22/2018 20:31:46'!
accept: aVisitor

	^ aVisitor processCertificateOfDeposit: self! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'ps 10/20/2018 22:58:19'!
affectBalance: aBalance

	^ aBalance - amount! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'd 10/20/2018 20:01:30'!
duration

	^ duration ! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'd 10/20/2018 19:29:51'!
earnings

	^ amount *((interestRate )/360)*duration.  ! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'd 10/20/2018 20:01:41'!
interestRate

	^ interestRate ! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'd 10/20/2018 18:33:44'!
value

	^ amount ! !


!CertificateOfDeposit methodsFor: 'initialization' stamp: 'ps 10/20/2018 22:39:14'!
initializeWithAmount: anAmount during: aNumberOfDays at: anInterestRate on: anAccount

	amount := anAmount .
	duration := aNumberOfDays . 
	interestRate := anInterestRate .
	anAccount register: self .
	account := anAccount .
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'creation' stamp: 'ps 10/20/2018 22:37:27'!
of: anAmount during: aNumberOfDays at: anInterestRate on: anAccount

	^ self new initializeWithAmount: anAmount during: aNumberOfDays at: anInterestRate on: anAccount! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'ps 10/22/2018 20:31:59'!
accept: aVisitor

	^ aVisitor processDeposit: self! !

!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'ps 10/11/2018 21:17:10'!
relativeValue

	^ value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'ps 10/18/2018 21:01:48'!
initializeWith: anAmmount inTransfer: aTransfer

	value := anAmmount.
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'value' stamp: 'ps 10/18/2018 20:51:00'!
transfer

	^transfer! !

!TransferLeg methodsFor: 'value' stamp: 'ps 10/18/2018 20:52:39'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'ps 10/18/2018 21:02:25'!
with: anAmmount inTransfer: aTransfer

	^self new initializeWith: anAmmount inTransfer: aTransfer ! !


!classDefinition: #DepositLeg category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!DepositLeg methodsFor: 'value' stamp: 'ps 10/22/2018 20:32:18'!
accept: aVisitor

	^ aVisitor processDepositLeg: self! !

!DepositLeg methodsFor: 'value' stamp: 'ps 10/18/2018 20:50:03'!
affectBalance: currentBalance

	^currentBalance + value! !


!classDefinition: #WithdrawLeg category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WithdrawLeg methodsFor: 'value' stamp: 'ps 10/22/2018 20:32:32'!
accept: aVisitor

	^ aVisitor processWithdrawLeg: self! !

!WithdrawLeg methodsFor: 'value' stamp: 'ps 10/18/2018 20:50:16'!
affectBalance: currentBalance

	^currentBalance - value! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'ps 10/22/2018 20:32:53'!
accept: aVisitor

	^ aVisitor processWithdraw: self! !

!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'ps 10/11/2018 21:17:34'!
relativeValue

	^ -1*value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountVisitor methodsFor: 'processing' stamp: 'ps 10/19/2018 20:58:53'!
processDeposit: aDeposit

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'processing' stamp: 'ps 10/19/2018 20:58:59'!
processDepositLeg: aDepositLeg

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'processing' stamp: 'ps 10/19/2018 20:59:11'!
processWithdraw: aWithdraw

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'processing' stamp: 'ps 10/19/2018 20:59:15'!
processWithdrawLeg: aWithdrawLeg

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 20:22:13'!
value

	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 20:20:46'!
visitTransactions

	account visitAllTransactionsWith: self! !


!AccountVisitor methodsFor: 'initialization' stamp: 'ps 10/22/2018 19:12:17'!
initializeWith: aReceptiveAccount 

	account := aReceptiveAccount .
	self initialize! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor class
	instanceVariableNames: ''!

!AccountVisitor class methodsFor: 'as yet unclassified' stamp: 'ps 10/19/2018 21:03:03'!
with: aReceptiveAccount

	^ self new initializeWith: aReceptiveAccount ! !


!classDefinition: #AccountTransferNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #AccountTransferNetVisitor
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:17:41'!
initialize

	transferNet := 0! !

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:17:50'!
processCertificateOfDeposit: aCertificate! !

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:17:54'!
processDeposit: aDeposit! !

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:18:06'!
processDepositLeg: aDepositLeg

	transferNet := transferNet + aDepositLeg value! !

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:18:11'!
processWithdraw: aWithdraw! !

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:18:24'!
processWithdrawLeg: aWithdrawLeg

	transferNet :=  transferNet - aWithdrawLeg value! !

!AccountTransferNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 20:22:22'!
value

	self visitTransactions.
	^ transferNet! !


!classDefinition: #InvestmentEarningsVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #InvestmentEarningsVisitor
	instanceVariableNames: 'investmentEarnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:15:24'!
initialize

	investmentEarnings := 0! !

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:15:46'!
processCertificateOfDeposit: aCertificate

	investmentEarnings := investmentEarnings + (((aCertificate value) * (aCertificate interestRate) / 360) * (aCertificate duration))! !

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:15:54'!
processDeposit: aDeposit! !

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:15:58'!
processDepositLeg: aDepositLeg! !

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:16:04'!
processWithdraw: aWithdraw! !

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:16:08'!
processWithdrawLeg: aWithdrawLeg! !

!InvestmentEarningsVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 20:22:31'!
value

	self visitTransactions.
	^ investmentEarnings! !


!classDefinition: #InvestmentNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #InvestmentNetVisitor
	instanceVariableNames: 'investmentNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:13:15'!
initialize

	investmentNet := 0! !

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:13:56'!
processCertificateOfDeposit: aCertificate

	investmentNet := investmentNet + aCertificate value! !

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:14:03'!
processDeposit: aDeposit! !

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:14:11'!
processDepositLeg: aDepositLeg! !

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:14:17'!
processWithdraw: aWithdraw! !

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:14:24'!
processWithdrawLeg: aWithdrawLeg! !

!InvestmentNetVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 20:22:40'!
value

	self visitTransactions.
	^ investmentNet.
! !


!classDefinition: #SummaryLinesVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountVisitor subclass: #SummaryLinesVisitor
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:07:10'!
initialize

	lines := OrderedCollection new! !

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:10:49'!
processCertificateOfDeposit: aCertificate

	lines add: ('Plazo fijo por ', aCertificate value printString, ' durante ', aCertificate duration printString, ' dias a una tna de ', (aCertificate interestRate*100) printString, '%')
! !

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:11:00'!
processDeposit: aDeposit

	lines add: ('Deposito por ' , (aDeposit value printString))! !

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:11:16'!
processDepositLeg: aDepositLeg

	lines add: ('Transferencia por ' , (aDepositLeg value printString))! !

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:11:26'!
processWithdraw: aWithdraw

	lines add: ('Extraccion por ' , (aWithdraw value printString))! !

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 19:11:38'!
processWithdrawLeg: aWithdrawLeg

	lines add: ('Transferencia por -' , (aWithdrawLeg value printString))! !

!SummaryLinesVisitor methodsFor: 'processing' stamp: 'ps 10/22/2018 20:22:58'!
value

	self visitTransactions.
	^ lines.! !


!classDefinition: #PortfolioTreeVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #PortfolioTreeVisitor
	instanceVariableNames: 'portfolio nameDictionary lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTreeVisitor methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 20:13:39'!
formatAccountName: aName withSpaces: anInteger

	| spaces | 

	spaces := ''.
	anInteger timesRepeat: [
		spaces := spaces , ' '.
	].
	^ spaces := spaces , aName! !

!PortfolioTreeVisitor methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 19:37:23'!
initializeWith: aPortfolio namingAccountWith: aDictionary

	portfolio := aPortfolio.
	nameDictionary := aDictionary.
	lines := OrderedCollection new! !

!PortfolioTreeVisitor methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 20:24:57'!
reversedValue

	^ (self value) reversed! !

!PortfolioTreeVisitor methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 20:24:19'!
value

	portfolio accept: self withDepth: 0.
	^ lines! !

!PortfolioTreeVisitor methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 20:04:32'!
visitPortfolio: aPortfolio withDepth: anInteger

	lines add: (self formatAccountName: (nameDictionary at: aPortfolio) withSpaces: anInteger).! !

!PortfolioTreeVisitor methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 20:05:51'!
visitReceptiveAccount: aReceptiveAccount withDepth: anInteger

	lines add: (self formatAccountName:(nameDictionary at: aReceptiveAccount) withSpaces: anInteger).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreeVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTreeVisitor class
	instanceVariableNames: ''!

!PortfolioTreeVisitor class methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 19:24:16'!
of: aPortfolio namingAccountWith: aDictionary

	^ self new initializeWith: aPortfolio namingAccountWith: aDictionary! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'accounts' stamp: 'd 10/14/2018 19:12:41'!
allAccounts
	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 19:45:18'!
accept: aPortfolioVisitor withDepth: anInteger

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'accounts' stamp: 'd 10/14/2018 19:13:45'!
allAccounts

	^accounts inject: OrderedCollection new into:
	 [
		:totalAccounts :anAccount |
		totalAccounts addAll: anAccount allAccounts.
		totalAccounts
	].! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 20:06:24'!
accept: aPortfolioVisitor withDepth: anInteger

	aPortfolioVisitor visitPortfolio: self withDepth: anInteger.
	accounts do: [
		:aSummarizingAccount |
		aSummarizingAccount accept: aPortfolioVisitor withDepth: anInteger + 1.
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'd 10/20/2018 18:53:09'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	certificates := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'd 10/20/2018 17:54:02'!
registerCertificateOfDeposit: aCertificate

	certificates add: aCertificate 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'accounts' stamp: 'd 10/14/2018 19:13:11'!
allAccounts 
	^ OrderedCollection with: self.! !

!ReceptiveAccount methodsFor: 'accounts' stamp: 'ps 10/22/2018 20:30:22'!
visitAllTransactionsWith: aVisitor

	transactions do: [
		:transaction | 
		transaction accept: aVisitor.
	]! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 19:47:34'!
accept: aPortfolioVisitor withDepth: anInteger

	aPortfolioVisitor visitReceptiveAccount: self withDepth: anInteger! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'ps 10/22/2018 19:32:44'!
accept: aPortfolioVisitor withNames: nameDictionary

	aPortfolioVisitor visitReceptiveAccount: self withNames: nameDictionary ! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'depositLeg withdrawLeg value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'ps 10/18/2018 20:55:47'!
initializeWithAmount: anAmount from: fromAccount to: toAccount

	value := anAmount. 
	depositLeg := DepositLeg with: anAmount inTransfer: self.
	withdrawLeg := WithdrawLeg with: anAmount inTransfer: self.
	fromAccount register: withdrawLeg.
	toAccount register: depositLeg.! !


!Transfer methodsFor: 'value' stamp: 'ps 10/18/2018 19:19:56'!
depositLeg 

	^depositLeg! !

!Transfer methodsFor: 'value' stamp: 'ps 10/18/2018 19:20:46'!
value

	^ value! !

!Transfer methodsFor: 'value' stamp: 'ps 10/18/2018 19:20:09'!
withdrawLeg 

	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'ps 10/18/2018 19:16:38'!
amount: anAmount from: fromAccount to: toAccount

	^ self new initializeWithAmount: anAmount from:fromAccount to:toAccount! !
