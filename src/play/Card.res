type state =
  | Default
  | Selected
  | Disabled

@react.component
let make = (~card: CardDef.t, ~state: state = Disabled) => {
  let (cardState, setCardState) = React.useState(() => state)


  let cardsToRender = card.number 
    -> CardDef.fromNumber
    -> (n) => Array.make(~length=n, card)

  <article 
    className="flex flex-col items-center justify-center p-2 border-3 border-gray-700 rounded-lg"
    role="button"
    ariaDisabled={cardState == Disabled}
    ariaSelected={cardState == Selected}
    disabled={cardState == Disabled}
    onClick={_ => {
      if state == Default {
        setCardState(_ => Selected)
      }
    }}
  >
    {Array.map(cardsToRender, card => <Icon.make card=card />)->React.array}
  </article>
}