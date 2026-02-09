type state = 
  | Initializing
  | Active
  | Disabled
  | Selecting

let showBoardState = (state: state) => {
  switch state {
    | Initializing => "Initializing"
    | Active => "Active"
    | Disabled => "Disabled"
    | Selecting => "Selecting"
  } -> React.string
}

type hasChildren = (React.element) => bool
let hasChildren = %raw(`function hasChildren(element) { 
  return element.hasChildNodes() 
}`)

module Render = {
  @react.component
  let make = (~deck: array<CardDef.t>) => {
  let (boardState, setBoardState) = React.useState(() => Initializing)
  let boardRef = React.useRef(null)

  React.useLayoutEffect(() => {
    let boardElement = boardRef.current
    let hasCards = boardElement
      ->Nullable.map(
        element => {
          hasChildren(element)
        }
      )
      ->Nullable.getOr(false)

    if hasCards {
      setBoardState(_ => Active)
    }

    Some(() => {
      setBoardState(_ => Disabled)
    })
  }, [])

  <>
    <p>{boardState -> showBoardState}</p>
    <article className="grid grid-cols-3 gap-6" ref={ReactDOM.Ref.domRef(boardRef)}>
      {Belt.Array.map(deck, card => <Card key={card.id->Int.toString} card=card />)->React.array}
    </article>
  </>
  }
}