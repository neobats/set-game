module type Collection = {
  type t<'a>
  let length: t<'a> => int
  let add: (t<'a>, 'a) => t<'a>
  let map: (t<'a>, 'a => 'b) => t<'b>
  let toArray: t<'a> => array<'a>
  let init: unit => t<'a>
}

module ListCollection = {
  type t<'a> = list<'a>
  let length = List.length
  let add = List.add
  let map = List.map
  let toArray = List.toArray
  let init = () => list{}
}

/**
  Functor that creates a GameSet module parameterized by:
  - Card: the card module type
  - Collection: the collection module (like ListCollection)
 */
module MakeGameSet = (C: Card.t, Collection: Collection) => {
  type t = Collection.t<C.t>

  type status = 
    | Filling(t)
    | Filled(t)
    | Empty

  let length = Collection.length
  let map = Collection.map
  let toArray = Collection.toArray
  let make = Collection.init

  /**
    Check if a collection has exactly 3 cards (required for a Set)
   */
  let maybeSet = (cards: t): bool => {
    switch Collection.length(cards) {
    | 3 => true
    | _ => false
    }
  }

  let add = (cards: t, card: C.t) => {
    switch Collection.length(cards) {
    | 3 => cards
    | _ => Collection.add(cards, card)
    }
  }
}

module GameSet = MakeGameSet(Card, ListCollection)