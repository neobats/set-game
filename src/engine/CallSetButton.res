@react.component
let make = (~text: string, ~onClick: (JsxEvent.Mouse.t) => unit) => {
  let (countdown, setCountdown) = React.useState(() => None)
  let (buttonText, setButtonText) = React.useState(() => text)

  let handleClick = event => {
    onClick(event)
    setCountdown(_ => Some(10))
  }
  
  let onCountdownEnd = () => {
    setCountdown(_ => None)
    setButtonText(_ => "SET!")
  }

  let onCountdownDecrement = (timeRemaining: option<int>) => {
    setButtonText(_ => switch timeRemaining {
      | Some(time) => time -> Int.toString
      | None => text
    })

    if (timeRemaining == Some(0)) {
      onCountdownEnd()
    }
  }

  let _ = Time.useCountdown(
    ~totalTime=countdown,
    ~setter=setCountdown,
    ~onDecrement=onCountdownDecrement,
  )

  <Button onClick={handleClick}>{buttonText -> React.string}</Button>
}