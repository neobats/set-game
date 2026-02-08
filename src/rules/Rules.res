type check =
| Valid
| Invalid


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

  let inspect = (cards: t) => {
    Console.log2("Cards", cards)
    cards
  }
  /**
    Check if a collection has exactly 3 cards (required for a Set)
   */
  let maybeSet = (cards: t): status => {
    switch Collection.length(cards) {
    | 3 => Filled(cards)
    | 0 => Empty
    | _ => Filling(cards)
    }
  }

  let add = (cards: t, card: C.t) => {
    Console.log2("Adding card", card)
    let length
    = Collection.length(cards)
    Console.log2("Length", length)
    switch length {
    | 3 => cards
    | _ => Collection.add(cards, card)
    }
  }

  let rec toSet = (s: Set.t<'a>,l: list<'a>): Set.t<'a> => {
    switch l {
    | list{head, ...tail} => {
      Set.add(s, head)
      toSet(s, tail)
    }
    | list{} => s
    }
  }

  let checkShapes = (cards: list<Card.t>): check => {
    let shapes = toSet(Set.make(), List.map(cards, (card) => card.shape))
    switch Set.size(shapes) {
    | 1 => Valid
    | 3 => Valid
    | _ => Invalid
    }
  }
}

module GameSet = MakeGameSet(Card, ListCollection)

let test = () => {
  let deck = Deck.init() -> Belt.Array.shuffle
  Console.log2("Deck", deck)
  let cards = Array.slice(deck, ~start=0, ~end=3)
  let set = [0, 1, 2] -> Array.reduce(GameSet.make(), (set, i) => {
    let card = Array.get(cards, i)->Option.getOrThrow
    Console.log2("From array: Card", card)
    set
    -> GameSet.inspect 
    -> GameSet.add(card)
  })
  let status = GameSet.maybeSet(set)
  Console.log2("Status", status)
  switch status {
  | GameSet.Filled(set) => Console.log2("Set filled", set)
  | GameSet.Filling(set) => Console.log2("Set filling", set)
  | GameSet.Empty => Console.log("Set empty")
  }

  let check = cards
    -> List.fromArray
    -> GameSet.checkShapes
    -> (c) => {
      switch c {
      | Valid => Console.log("Valid")
      | Invalid => Console.log("Invalid")
      }
      c
    }
  Console.log2("Check", check)
}
