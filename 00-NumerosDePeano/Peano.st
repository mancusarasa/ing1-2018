!classDefinition: #I category: #QuintaActividad!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #QuintaActividad!
I class
	instanceVariableNames: 'next previous'!

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:35:30'!
* otroNumero
	^ otroNumero! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:34:49'!
+ otroNumero
	^otroNumero next! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:55:26'!
- otroNumero
	self error: 'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/14/2018 00:05:34'!
/ otroNumero
	"perfoms the division"
	self = otroNumero ifTrue: [^I].
	(otroNumero > self) ifTrue: [
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].
	^ I + ((self - otroNumero) / (otroNumero)).! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/10/2018 21:40:06'!
> otroNumero
	"returns true if the number is larger than the other one "
	otroNumero = I ifTrue: [self = I ifFalse: [^true].].
	self = I ifTrue: [^false].
	^(self previous) > (otroNumero previous)! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/14/2018 00:12:24'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/14/2018 00:12:30'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!I class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:58'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := nil.! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:07:44'!
next
	"creates and returns the next number"
	^II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 22:58:07'!
previous
	"returns the previous number, if exists"
	self error: 'no previous for I'.! !

!I class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:28:55'!
restame: otroNumero
	^ otroNumero previous! !


!classDefinition: #II category: #QuintaActividad!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #QuintaActividad!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:37:50'!
* otroNumero
	^ (self previous * otroNumero) + otroNumero! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:50:44'!
+ otroNumero
	^ self previous + (otroNumero next)! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:33:46'!
- otroNumero
	^ otroNumero restame: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/14/2018 00:05:48'!
/ otroNumero
	"perfoms the division"
	self = otroNumero ifTrue: [^I].
	(otroNumero > self) ifTrue: [
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].
	^ I + ((self - otroNumero) / (otroNumero)).! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:11:54'!
> otroNumero
	"returns true if the number is larger than the other one "
	otroNumero = I ifTrue: [self = I ifFalse: [^true].].
	self = I ifTrue: [^false].
	^(self previous) > (otroNumero previous)! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/14/2018 00:12:08'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/14/2018 00:12:15'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!II class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:58'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 22:57:28'!
next
	"creates the next number"
	next ifNil: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 22:56:32'!
previous
	"returns the previous number, if exists"
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 22:57:01'!
previous: aNumber
	"sets the previous number"
	previous := aNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 22:58:28'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	].! !

!II class methodsFor: 'as yet unclassified' stamp: 'wp 9/13/2018 23:29:41'!
restame: otroNumero
	^ (otroNumero previous) - (self previous)! !


!classDefinition: #III category: #QuintaActividad!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #QuintaActividad!
III class
	instanceVariableNames: 'previous next'!

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
* otroNumero
	^ (self previous * otroNumero) + otroNumero! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
+ otroNumero
	^ self previous + (otroNumero next)! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
- otroNumero
	^ otroNumero restame: self.! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
/ otroNumero
	"perfoms the division"
	self = otroNumero ifTrue: [^I].
	(otroNumero > self) ifTrue: [
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].
	^ I + ((self - otroNumero) / (otroNumero)).! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
> otroNumero
	"returns true if the number is larger than the other one "
	otroNumero = I ifTrue: [self = I ifFalse: [^true].].
	self = I ifTrue: [^false].
	^(self previous) > (otroNumero previous)! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:58'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IIII.! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
next
	"creates the next number"
	next ifNil: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
previous
	"returns the previous number, if exists"
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
previous: aNumber
	"sets the previous number"
	previous := aNumber.! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	].! !

!III class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
restame: otroNumero
	^ (otroNumero previous) - (self previous)! !


!classDefinition: #IIII category: #QuintaActividad!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'QuintaActividad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #QuintaActividad!
IIII class
	instanceVariableNames: 'previous next'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
* otroNumero
	^ (self previous * otroNumero) + otroNumero! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
+ otroNumero
	^ self previous + (otroNumero next)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
- otroNumero
	^ otroNumero restame: self.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
/ otroNumero
	"perfoms the division"
	self = otroNumero ifTrue: [^I].
	(otroNumero > self) ifTrue: [
		self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.
	].
	^ I + ((self - otroNumero) / (otroNumero)).! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
> otroNumero
	"returns true if the number is larger than the other one "
	otroNumero = I ifTrue: [self = I ifFalse: [^true].].
	self = I ifTrue: [^false].
	^(self previous) > (otroNumero previous)! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'descripcionDeErrorDeNumerosNegativosNoSoportados'! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:58'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := nil.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
next
	"creates the next number"
	next ifNil: [
		next := self cloneNamed: self name , 'I'.
		next previous: self.
	].
	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
previous
	"returns the previous number, if exists"
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
previous: aNumber
	"sets the previous number"
	previous := aNumber.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
removeAllNext

	next ifNotNil: [
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	].! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'w 9/14/2018 11:32:48'!
restame: otroNumero
	^ (otroNumero previous) - (self previous)! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!