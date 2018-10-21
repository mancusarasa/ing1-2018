!classDefinition: #AccountReport category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountReport methodsFor: 'processing' stamp: 'ps 10/19/2018 20:55:46'!
getData

	self subclassResponsibility ! !

!AccountReport methodsFor: 'processing' stamp: 'ps 10/19/2018 20:58:53'!
processDeposit: aDeposit

	self subclassResponsibility ! !

!AccountReport methodsFor: 'processing' stamp: 'ps 10/19/2018 20:58:59'!
processDepositLeg: aDepositLeg

	self subclassResponsibility ! !

!AccountReport methodsFor: 'processing' stamp: 'ps 10/19/2018 20:59:11'!
processWithdraw: aWithdraw

	self subclassResponsibility ! !

!AccountReport methodsFor: 'processing' stamp: 'ps 10/19/2018 20:59:15'!
processWithdrawLeg: aWithdrawLeg

	self subclassResponsibility ! !


!AccountReport methodsFor: 'initialization' stamp: 'ps 10/19/2018 21:03:20'!
initializeWith: aReceptiveAccount 

	account := aReceptiveAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReport class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountReport class
	instanceVariableNames: ''!

!AccountReport class methodsFor: 'as yet unclassified' stamp: 'ps 10/19/2018 21:03:03'!
with: aReceptiveAccount

	^ self new initializeWith: aReceptiveAccount ! !


!classDefinition: #AccountTransferNetReport category: #'PortfolioTreePrinter-Ejercicio'!
AccountReport subclass: #AccountTransferNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNetReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:49:35'!
getData
	
	^ account transactions inject: 0 into: [
		:subTotal :transaction |
		subTotal + (transaction affectReport: self)
	].! !

!AccountTransferNetReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:46:24'!
processDeposit: aDeposit

	^ 0! !

!AccountTransferNetReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:52:16'!
processDepositLeg: aDepositLeg

	^ aDepositLeg value! !

!AccountTransferNetReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:46:48'!
processWithdraw: aWithdraw

	^ 0! !

!AccountTransferNetReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:51:58'!
processWithdrawLeg: aWithdrawLeg

	^ (-1)* (aWithdrawLeg value)! !


!classDefinition: #InvestmentEarningsReport category: #'PortfolioTreePrinter-Ejercicio'!
AccountReport subclass: #InvestmentEarningsReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarningsReport methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 19:28:48'!
getData
	^ account certificatesOfDeposit inject: 0 into: [
		:subTotal :certificate |
		subTotal + certificate earnings .
	].! !


!classDefinition: #InvestmentNetReport category: #'PortfolioTreePrinter-Ejercicio'!
AccountReport subclass: #InvestmentNetReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNetReport methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 18:53:33'!
getData
	^ account certificatesOfDeposit inject: 0 into: [
		:subTotal :certificate |
		subTotal + (certificate value)
	].! !


!classDefinition: #SummaryLinesReport category: #'PortfolioTreePrinter-Ejercicio'!
AccountReport subclass: #SummaryLinesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummaryLinesReport methodsFor: 'processing' stamp: 'd 10/20/2018 20:38:07'!
getData
	
	^ (account transactions inject: OrderedCollection new into: [
		:lines :transaction | (transaction isKindOf: CertificateOfDepositWithdraw) ifFalse: [ 
		lines add: (transaction affectReport: self)].
		lines
	]), (account certificatesOfDeposit inject: OrderedCollection new into: [
		:lines :certificate |
		lines add: (certificate affectReport: self).
		lines
	]).
! !

!SummaryLinesReport methodsFor: 'processing' stamp: 'd 10/20/2018 20:41:58'!
processCertificateOfDeposit: aCertificate

	^ 'Plazo fijo por ', aCertificate value printString, ' durante ', aCertificate duration printString, ' dias a una tna de ', (aCertificate interestRate*100) printString, '%'.
! !

!SummaryLinesReport methodsFor: 'processing' stamp: 'd 10/20/2018 20:35:00'!
processCertificateOfDepositWithdraw: aCertificateOfDeposit

	^ nil! !

!SummaryLinesReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:37:43'!
processDeposit: aDeposit

	^ 'Deposito por ' , (aDeposit value printString)! !

!SummaryLinesReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:37:53'!
processDepositLeg: aDepositLeg

	^ 'Transferencia por ' , (aDepositLeg value printString)! !

!SummaryLinesReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:38:01'!
processWithdraw: aWithdraw

	^ 'Extraccion por ' , (aWithdraw value printString)! !

!SummaryLinesReport methodsFor: 'processing' stamp: 'ps 10/19/2018 21:38:09'!
processWithdrawLeg: aWithdrawLeg

	^ 'Transferencia por -' , (aWithdrawLeg value printString)! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'ps 10/11/2018 21:16:53'!
relativeValue

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'ps 10/19/2018 21:19:47'!
affectReport: anAccountReport

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


!classDefinition: #CertificateOfDepositWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDepositWithdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDepositWithdraw methodsFor: 'initialization' stamp: 'd 10/20/2018 20:30:37'!
initializeFor: aValue

	value := aValue ! !


!CertificateOfDepositWithdraw methodsFor: 'value' stamp: 'd 10/20/2018 20:30:37'!
affectBalance: currentBalance

	^currentBalance - value! !

!CertificateOfDepositWithdraw methodsFor: 'value' stamp: 'd 10/20/2018 20:31:04'!
affectReport: anAccountReport

	^ anAccountReport processCertificateOfDepositWithdraw: self! !

!CertificateOfDepositWithdraw methodsFor: 'value' stamp: 'd 10/20/2018 20:30:37'!
relativeValue

	^ -1*value! !

!CertificateOfDepositWithdraw methodsFor: 'value' stamp: 'd 10/20/2018 20:30:37'!
value

	^ value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDepositWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDepositWithdraw class
	instanceVariableNames: ''!

!CertificateOfDepositWithdraw class methodsFor: 'instance creation' stamp: 'd 10/20/2018 20:30:37'!
for: aValue

	^ self new initializeFor: aValue ! !

!CertificateOfDepositWithdraw class methodsFor: 'instance creation' stamp: 'd 10/20/2018 20:30:37'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'ps 10/19/2018 21:40:41'!
affectReport: anAccountReport

	^ anAccountReport processDeposit: self! !

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

!DepositLeg methodsFor: 'value' stamp: 'ps 10/18/2018 20:50:03'!
affectBalance: currentBalance

	^currentBalance + value! !

!DepositLeg methodsFor: 'value' stamp: 'ps 10/19/2018 21:40:49'!
affectReport: anAccountReport

	^ anAccountReport processDepositLeg: self! !


!classDefinition: #WithdrawLeg category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #WithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!WithdrawLeg methodsFor: 'value' stamp: 'ps 10/18/2018 20:50:16'!
affectBalance: currentBalance

	^currentBalance - value! !

!WithdrawLeg methodsFor: 'value' stamp: 'ps 10/19/2018 21:41:00'!
affectReport: anAccountReport

	^ anAccountReport processWithdrawLeg: self! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'ps 10/19/2018 21:41:17'!
affectReport: anAccountReport

	^ anAccountReport processWithdraw: self! !

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


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #CertificateOfDeposit
	instanceVariableNames: 'amount duration interestRate account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 20:38:53'!
affectReport: anAccountReport

	^ anAccountReport processCertificateOfDeposit: self! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 20:01:30'!
duration

	^ duration ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 19:29:51'!
earnings

	^ amount *((interestRate )/360)*duration.  ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 20:32:37'!
initializeWithAmount: anAmount during: aNumberOfDays at: anInterestRate on: anAccount
	amount := anAmount .
	duration := aNumberOfDays . 
	interestRate := anInterestRate .
	account := anAccount .
	CertificateOfDepositWithdraw register: anAmount on: anAccount .
	account registerCertificateOfDeposit: self.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 20:01:41'!
interestRate

	^ interestRate ! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 18:33:44'!
value

	^ amount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'd 10/20/2018 17:39:28'!
of: anAmount during: aNumberOfDays at: anInterestRate on: anAccount
	^ self new initializeWithAmount: anAmount during: aNumberOfDays at: anInterestRate on: anAccount! !


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
	instanceVariableNames: 'transactions certificates'
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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'd 10/20/2018 18:10:50'!
certificatesOfDeposit 

	^ certificates copy! !

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
