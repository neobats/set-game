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

  /*
   Debugging function to print cards
   */
  let inspect = (cards: t, ~message: string = "Cards") => {
    Console.log2(message, cards)
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

  /**
   Add a card to the collection if the collection; no op if full
   */
  let add = (cards: t, card: C.t) => {
    switch Collection.length(cards) {
    | 3 => cards
    | _ => Collection.add(cards, card)
    }
  }

  /**
   Convert a list to a set
   */
  let rec toSet = (s: Set.t<'a>,l: list<'a>): Set.t<'a> => {
    switch l {
    | list{head, ...tail} => {
      Set.add(s, head)
      toSet(s, tail)
    }
    | list{} => s
    }
  }

  /**
   Generic property checker: verifies that a property across cards forms a valid set
   (all same or all different - i.e., set size is 1 or 3)
   Takes the property getter first to enable partial application
   */
  let checkProperty = (getProperty: Card.t => 'a, cards: list<Card.t>): check => {
    let values = toSet(Set.make(), List.map(cards, getProperty))
    switch Set.size(values) {
    | 1 => Valid
    | 3 => Valid
    | _ => Invalid
    }
  }

  /**
   Verifies the shapes constitute part of a valid set
   */
  let checkShapes = checkProperty((card) => card.shape, ...)

  /**
   Verifies the colors constitute part of a valid set
   */
  let checkColors = checkProperty((card) => card.color, ...)

  /**
   Verifies the fills constitute part of a valid set
   */
  let checkFills = checkProperty((card) => card.fill, ...)

  /**
   Verifies the numbers constitute part of a valid set
   */
  let checkNumbers = checkProperty((card) => card.number, ...)
}

module GameSet = MakeGameSet(Card, ListCollection)

let test = () => {
  let deck = Deck.init() -> Belt.Array.shuffle
  Console.log2("Deck", deck)

  let cards = Array.slice(deck, ~start=0, ~end=3)
  [0, 1, 2] -> Array.reduce(
    GameSet.make(),
    (set, i) => {
      GameSet.maybeSet(set) -> Console.log2("Status", _)
      let s = GameSet.add(
        set, 
        Array.get(cards, i)->Option.getOrThrow,
      )

      let status = GameSet.maybeSet(s)

      switch status {
      | GameSet.Filled(set') => Console.log2("Set filled", set')
      | GameSet.Filling(set') => Console.log2("Set filling", set')
      | GameSet.Empty => Console.log("Set empty")
      }

      s
    }
  ) -> ignore


  let listCards = List.fromArray(cards)
  let checkFns = [
    ("Shapes", GameSet.checkShapes),
    ("Colors", GameSet.checkColors),
    ("Fills", GameSet.checkFills),
    ("Numbers", GameSet.checkNumbers)
  ]

  let _ = checkFns 
    -> Array.map(((name, checkFn)) => (name, checkFn(listCards)))
    -> Array.forEach(((name, check)) => Console.log3("Check", name, check))
}
