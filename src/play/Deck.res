/**
  Initialize deck with all 81 cards (3^4 combinations)
  Generates cards by iterating through all combinations of:
  - shape (1-3): Tilde, Diamond, Pill
  - color (1-3): Red, Green, Purple
  - number (1-3): 1, 2, 3 symbols
  - fill (1-3): Solid, Stripped, Outlined
 */
let init = (): array<CardDef.t> => {
  let cards: array<CardDef.t> = Belt.Array.makeBy(81, _ => ({
    id: 0,
    shape: CardDef.Tilde,
    color: CardDef.Red,
    fill: CardDef.Solid,
    number: CardDef.One,
  }: CardDef.t))
  
  let cardId = ref(0)
  
  for shape in 1 to 3 {
    for color in 1 to 3 {
      for number in 1 to 3 {
        for fill in 1 to 3 {
          cards[cardId.contents] = {
            id: cardId.contents,
            shape: CardDef.toShape(shape),
            color: CardDef.toColor(color),
            fill: CardDef.toFill(fill),
            number: CardDef.toNumber(number),
          }
          Int.Ref.increment(cardId)
        }
      }
    }
  }
  
  cards
}

let useDeck = () => {
  let (_deck, setDeck) = React.useState(() => init())

  let resetDeck = () => {
    setDeck(_ => init())
  }

  let deck = React.useMemo(() => Belt.Array.shuffle(_deck), [_deck])
  (deck, resetDeck)
}