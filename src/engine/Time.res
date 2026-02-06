type t = 
  | Count(int)
  | Ending
  | Stopped

let initiateTimeout = (
  setter: (t => t) => unit,
  onDecrement: t => unit,
  ) => {
  let timeout = setTimeout(() => setter(prev => {
    let newValue = switch prev {
      | Stopped => Stopped
      | Ending => Stopped
      | Count(0) => Ending
      | Count(x) => Count(x - 1)
    }
    onDecrement(newValue)
    newValue
  }), 1000)

  Some(() => clearTimeout(timeout))
}

let useCountdown = (
  ~totalTime: t,
  ~setter: (t => t) => unit,
  ~onDecrement: t => unit,
) => {

  React.useEffect(() => {
    switch totalTime {
      | Ending => None
      | Count(_) => initiateTimeout(setter, onDecrement)
      | Stopped => None
    }
  }, (totalTime, setter, onDecrement))

  totalTime
}
