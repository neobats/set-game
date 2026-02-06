let initiateTimeout = (
  setter: (option<int> => option<int>) => unit,
  onDecrement: option<int> => unit,
  ) => {
  let timeout = setTimeout(() => setter(prev => {
    let newValue = switch prev {
      | None => None
      | Some(0) => None
      | x => Option.map(x, a => a - 1)
    }
    onDecrement(newValue)
    newValue
  }), 1000)

  Some(() => clearTimeout(timeout))
}

let useCountdown = (
  ~totalTime: option<int>,
  ~setter: (option<int> => option<int>) => unit,
  ~onDecrement: option<int> => unit,
) => {

  React.useEffect(() => {
    switch totalTime {
      | Some(0) => None
      | Some(_) => initiateTimeout(setter, onDecrement)
      | None => None
    }
  }, (totalTime, setter))

  totalTime
}