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

module Render = {
  @react.component
  let make = () => {
  let (boardState, setBoardState) = React.useState(() => Initializing)

  <article className="grid grid-cols-3 gap-6">
    <p>{boardState -> showBoardState}</p>
  </article>
  }
}