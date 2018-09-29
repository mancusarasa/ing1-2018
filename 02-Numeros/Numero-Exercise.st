!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:21:34'!
* aMultiplier 
	
	^aMultiplier multiplyAnInteger: self.
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'wp 9/27/2018 20:12:34'!
+ anAdder 
	
	^anAdder addAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'wp 9/27/2018 16:54:35'!
- aSubtrahend 
	
	^ aSubtrahend substractMeFromInteger: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ps 9/25/2018 14:52:41'!
/ aDivisor 
	^aDivisor divideAnInteger: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'd 9/28/2018 15:53:03'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:13:07'!
addAFraccion: aFraccionAdder

	| newNumerator |
	
	newNumerator := aFraccionAdder numerator + (self * aFraccionAdder denominator).
	^newNumerator / aFraccionAdder denominator.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'd 9/28/2018 16:15:07'!
addAnInteger: anIntegerAdder 

	^Entero with: value + anIntegerAdder integerValue
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ps 9/25/2018 15:05:17'!
divideAFraccion: aFraccionDividend.

	^ aFraccionDividend numerator / (self *aFraccionDividend denominator).! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ps 9/25/2018 15:01:32'!
divideAnInteger: anIntegerDividend.

	^Fraccion with: anIntegerDividend over: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'd 9/28/2018 15:24:38'!
fibonacci

	self subclassResponsibility
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'd 9/28/2018 16:15:25'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (value gcd: anEntero integerValue)! !

!Entero methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:23:57'!
multiplyAFraccion: aFraccionMultiplier
	| newNumerator |

	newNumerator := self * aFraccionMultiplier numerator.
	^ newNumerator / (aFraccionMultiplier denominator)
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'd 9/28/2018 15:53:46'!
multiplyAnInteger: anIntegerMultiplier

	^Entero with: value * anIntegerMultiplier integerValue
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'wp 9/27/2018 20:28:28'!
substractMeFromFraccion: aFraccionSubtrahend 
	
	| newNumerator |
	
	newNumerator := aFraccionSubtrahend numerator - (self * (aFraccionSubtrahend denominator)).
	^newNumerator / (aFraccionSubtrahend denominator).
	
	
	
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'd 9/28/2018 15:51:47'!
substractMeFromInteger: anIntegerSubtrahend 
	
	^ Entero with: anIntegerSubtrahend integerValue - value! !


!Entero methodsFor: 'comparing' stamp: 'd 9/28/2018 16:14:56'!
= anObject

	^(anObject isKindOf: Entero) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'd 9/29/2018 15:16:13'!
ifNegativeDo: aBlock.
	
! !

!Entero methodsFor: 'testing' stamp: 'd 9/29/2018 15:17:41'!
ifOneDo: aBlock.
	
! !

!Entero methodsFor: 'testing' stamp: 'd 9/29/2018 15:09:20'!
ifZeroDo: aBlock.
	
! !

!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 9/23/2018 22:17:16'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para enteros negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'd 9/29/2018 12:03:15'!
with: aValue 
	| EnteroSubClass |
	 EnteroSubClass := self subclasses detect:[:aSubClass| aSubClass tipo:aValue].
	^EnteroSubClass new initalizeWith: aValue.! !


!classDefinition: #Negativo category: #'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'as yet unclassified' stamp: 'd 9/28/2018 14:27:01'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription.! !

!Negativo methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 15:16:44'!
ifNegativeDo: aBlock.
	
	aBlock value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativo class' category: #'Numero-Exercise'!
Negativo class
	instanceVariableNames: ''!

!Negativo class methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 12:03:58'!
tipo: aValue 
	
	^aValue < 0.! !


!classDefinition: #Positivo category: #'Numero-Exercise'!
Entero subclass: #Positivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Positivo methodsFor: 'as yet unclassified' stamp: 'd 9/28/2018 20:41:16'!
fibonacci

	"self error: Entero negativeFibonacciErrorDescription."
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Positivo class' category: #'Numero-Exercise'!
Positivo class
	instanceVariableNames: ''!

!Positivo class methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 12:06:41'!
tipo: aValue 
	
	^aValue > 1.! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'as yet unclassified' stamp: 'd 9/28/2018 16:11:51'!
fibonacci
	
	^ Entero with: 1.! !

!Uno methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 15:18:04'!
ifOneDo: aBlock.
	
	aBlock value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 12:04:39'!
tipo: aValue 

	^aValue = 1.! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Zero methodsFor: 'as yet unclassified' stamp: 'd 9/28/2018 15:23:53'!
fibonacci

	^(Entero with: 1).
! !

!Zero methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 15:09:26'!
ifZeroDo: aBlock.
	
	aBlock value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: #'Numero-Exercise'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'as yet unclassified' stamp: 'd 9/29/2018 12:04:44'!
tipo: aValue 

	^aValue = 0.! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:28:02'!
* aMultiplier 
	
	^ aMultiplier multiplyAFraccion: self.
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:02:32'!
+ anAdder 
	
	^ anAdder addAFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/27/2018 20:30:12'!
- aSubtrahend 
	
	^aSubtrahend substractMeFromFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ps 9/25/2018 14:56:21'!
/ aDivisor 

	^aDivisor divideAFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:04:25'!
addAFraccion: aFraccionAdder

	| newNumerator newDenominator |
	
	newNumerator := (numerator * aFraccionAdder denominator) + (denominator * aFraccionAdder numerator).
	newDenominator := denominator * aFraccionAdder denominator.
	
	^newNumerator / newDenominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:14:04'!
addAnInteger: anIntegerAdder 

	| newNumerator |
	
	newNumerator := numerator + (denominator * anIntegerAdder).
	^newNumerator / denominator. ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ps 9/25/2018 15:00:29'!
divideAFraccion: aFraccionDividend

	^(aFraccionDividend numerator * denominator) / (aFraccionDividend denominator * numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'ps 9/25/2018 15:00:56'!
divideAnInteger: anIntegerDividend

	^(anIntegerDividend * denominator) / (numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:27:42'!
multiplyAFraccion: aFraccionMultiplier 

	^(numerator * aFraccionMultiplier numerator) / (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/24/2018 23:25:56'!
multiplyAnInteger: anIntegerMultiplier 

	| newNumerator |
	
	newNumerator := numerator * anIntegerMultiplier.
	^newNumerator / denominator. ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/27/2018 20:21:18'!
substractMeFromFraccion: aFraccionSubtrahend

	| newNumerator newDenominator |
	
	newNumerator := (aFraccionSubtrahend numerator * self denominator) - (aFraccionSubtrahend denominator * self numerator).
	newDenominator := aFraccionSubtrahend denominator * self denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'wp 9/27/2018 17:12:02'!
substractMeFromInteger: anIntegerSubtrahend 
	
	| newNumerator |
	
	newNumerator := (anIntegerSubtrahend * self denominator)  - self numerator.
	^newNumerator / self denominator.
	
	
	
	
	! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 22:54'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator isZero ifTrue: [ self error: 'una fraccion no puede ser cero' ].
	aDenominator isOne ifTrue: [ self error: 'una fraccion no puede tener denominador 1 porque sino es un entero' ].
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'd 9/29/2018 15:18:16'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor ifZeroDo:  [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend ifZeroDo: [ ^aDividend ].
	
	aDivisor ifNegativeDo:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator ifOneDo: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
