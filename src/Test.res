open Rules

let make = () => {
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
