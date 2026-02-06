type t = 
  | Count(int)
  | Ending
  | Stopped

let useCountdown: (
  ~totalTime: t,
  ~setter: (t => t) => unit,
  ~onDecrement: t => unit,
) => t
