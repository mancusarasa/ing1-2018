!classDefinition: #QueueTest category: #'Queue-Exercise'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #Queue category: #'Queue-Exercise'!
Object subclass: #Queue
	instanceVariableNames: 'contents state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Queue methodsFor: 'as yet unclassified' stamp: 'd 10/2/2018 09:56:46'!
dequeue

	| firstInLine |
	
	state assertNonEmpty.
	firstInLine:= contents first.
	contents removeFirst.
	self updateCurrentState.
	^ firstInLine! !

!Queue methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:39:16'!
enqueue: anElement

	contents add: anElement.
	self updateCurrentState ! !

!Queue methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:39:21'!
initialize

	contents := OrderedCollection new.
	self updateCurrentState.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:38:10'!
isEmpty

	^state isEmpty ! !

!Queue methodsFor: 'as yet unclassified' stamp: 'd 10/2/2018 09:57:05'!
next

	state assertNonEmpty.
	^contents first.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:38:32'!
size

	^contents size.! !

!Queue methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:28:34'!
updateCurrentState

	state := QueueState with: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-Exercise'!
Queue class
	instanceVariableNames: ''!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !


!classDefinition: #QueueState category: #'Queue-Exercise'!
Object subclass: #QueueState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!QueueState methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:32:55'!
assertNonEmpty

	^self subclassResponsibility ! !

!QueueState methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:25:07'!
isEmpty

	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'QueueState class' category: #'Queue-Exercise'!
QueueState class
	instanceVariableNames: ''!

!QueueState class methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:15:47'!
matches: aQueue

	^self subclassResponsibility! !

!QueueState class methodsFor: 'as yet unclassified' stamp: 'd 10/2/2018 10:01:21'!
with: aQueue
	| queueStateSubclass |
	
	queueStateSubclass := self subclasses detect: [ :aSubClass | aSubClass matches: aQueue].
	^queueStateSubclass new.! !


!classDefinition: #Empty category: #'Queue-Exercise'!
QueueState subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!Empty methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:34:12'!
assertNonEmpty

	^self error: Queue queueEmptyErrorDescription! !

!Empty methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:25:23'!
isEmpty

	^ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empty class' category: #'Queue-Exercise'!
Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:18:56'!
matches: aQueue

	^aQueue size = 0! !


!classDefinition: #NonEmpty category: #'Queue-Exercise'!
QueueState subclass: #NonEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-Exercise'!

!NonEmpty methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:34:37'!
assertNonEmpty

	^self! !

!NonEmpty methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:25:37'!
isEmpty

	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonEmpty class' category: #'Queue-Exercise'!
NonEmpty class
	instanceVariableNames: ''!

!NonEmpty class methodsFor: 'as yet unclassified' stamp: 'ps 9/30/2018 14:19:14'!
matches: aQueue

	^aQueue size > 0! !
