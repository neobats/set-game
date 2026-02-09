type state =
  | Default
  | Selected
  | Disabled

@react.component
let make = (~card: CardDef.t, ~state: state = Disabled) => {
  let (cardState, setCardState) = React.useState(() => state)

  <article 
    className="flex flex-col items-center justify-between p-2 border-2 border-gray-300 rounded-md"
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
    <Icon.make card=card />
  </article>
}