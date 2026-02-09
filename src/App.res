@module("./assets/rescript-logo.svg")
external rescript: string = "default"

@module("./assets/vite.svg")
external vite: string = "default"

@react.component
module Yeet = {
  let make = () => {
    <p className="text-2xl m-16 font-semibold text-center"> {"YEET!"->React.string} </p>
  }
}

@react.component
let make = () => {
  // example to prove that the Set button runs
  let (yeet, setYeet) = React.useState(() => None)
  let handleClick = _ => {
    setYeet(_ => Some(Yeet.make()))
  }
  
  // initialize the deck
  let ((shown, _hidden), resetDeck) = Deck.useDeck()

  React.useEffect(() => {
    Some(() => resetDeck())
  }, [])

  <div className="max-w-200">
    // set up the icons for the striped fills
    <Icon.Patterns />
    <h1 className="text-6xl m-16 font-semibold text-center"> {"Set game"->React.string} </h1>
    <h2 className="text-2xl m-16 font-semibold text-center"> {yeet->Option.getOr(React.null)} </h2>
    <Board.Render deck={shown} />
    <CallSetButton text="SET!" onClick={handleClick} />
  </div>
}
