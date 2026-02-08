type state = 
  | Active
  | Disabled
  | Selecting

let showBoardState = (state: state) => {
  switch state {
    | Active => "Active"
    | Disabled => "Disabled"
    | Selecting => "Selecting"
  } -> React.string
}

module Render = {
  @react.component
  let make = () => {
  let (boardState, setBoardState) = React.useState(() => Active)

  <article className="grid grid-cols-3 gap-6">
    <p>{boardState -> showBoardState}</p>
  </article>
  }
}