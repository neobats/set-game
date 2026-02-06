module Score = {
  type t = {
    points: int,
    errors: int,
    wins: int,
  }

  let make = (~points: int=0, ~errors: int=0, ~wins: int=0) => {
    {
      points,
      errors,
      wins,
    }
  }

  let hit = (~score: t) => {
    make(~points=score.points + 1, ~errors=score.errors, ~wins=score.wins)
  }

  let miss = (score: t) => {
    make(~points=score.points, ~errors=score.errors + 1, ~wins=score.wins)
  }

  let win = (score: t) => {
    make(~points=score.points, ~errors=score.errors, ~wins=score.wins + 1)
  }
}


module Mode = {
  type t =
  | AI(Score.t, Score.t)
  | Zen(Score.t)

  let change = (mode: t) => {
    switch mode {
      | AI(_, user) => Zen(user)
      | Zen(score) => AI(score, score)
    }
  }
}

module State = {
  type activity = 
    | Playing
    | Paused
    | Validating((Score.t))
    
  type t = {
    mode: Mode.t,
    gameTime: Time.t,
    state: activity
  }

  let make = (~mode: Mode.t, ~gameTime: Time.t) => {
    { mode, gameTime, state: Playing }
  }

  let pause = (state: t) => {
    { ...state, state: Paused }
  }

  let validate = (state: t) => {
    { ...state, state: Validating(Score.make()) }
  }
}

let start = (
  ~mode: Mode.t,
  ~gameTime: Time.t,
) => {
  State.make(~mode, ~gameTime)
}
