/**
  Initialize deck with all 81 cards (3^4 combinations)
  Generates cards by iterating through all combinations of:
  - shape (1-3): Tilde, Diamond, Pill
  - color (1-3): Red, Green, Purple
  - number (1-3): 1, 2, 3 symbols
  - fill (1-3): Solid, Stripped, Outlined
 */
let init = (): array<Card.t> => {
  let cards: array<Card.t> = Belt.Array.makeBy(81, _ => ({
    id: 0,
    shape: Card.Tilde,
    color: Card.Red,
    fill: Card.Solid,
    number: Card.One,
  }: Card.t))
  
  let cardId = ref(0)
  
  for shape in 1 to 3 {
    for color in 1 to 3 {
      for number in 1 to 3 {
        for fill in 1 to 3 {
          cards[cardId.contents] = {
            id: cardId.contents,
            shape: Card.toShape(shape),
            color: Card.toColor(color),
            fill: Card.toFill(fill),
            number: Card.toNumber(number),
          }
          Int.Ref.increment(cardId)
        }
      }
    }
  }
  
  cards
}