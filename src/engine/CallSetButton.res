@react.component
let make = (~text: string, ~onClick: (JsxEvent.Mouse.t) => unit) => {
  let (countdown, setCountdown) = React.useState(() => Time.Stopped)
  let (buttonText, setButtonText) = React.useState(() => text)

  let handleClick = event => {
    onClick(event)
    setCountdown(_ => Time.Count(10))
  }
  
  let onCountdownEnd = () => {
    setCountdown(_ => Time.Stopped)
    setButtonText(_ => "SET!")
  }

  let onCountdownDecrement = (timeRemaining: Time.t) => {
    setButtonText(_ => switch timeRemaining {
      | Time.Count(time) => time -> Int.toString
      | _ => text
    })

    if (timeRemaining == Time.Ending) {
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