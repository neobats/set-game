
type shape = 
| Tilde
| Diamond
| Pill

type color =
| Red
| Green
| Purple

type fill =
| Solid
| Striped
| Outlined

type number = 
| One
| Two
| Three

type t = {
  id: int,
  shape: shape,
  color: color,
  fill: fill,
  number: number,
}

type property = 
| Shape
| Color
| Fill
| Number

/**
  Convert integer (1-3) to shape variant
  */
let toShape = (n: int): shape => {
  switch n {
  | 1 => Tilde
  | 2 => Diamond
  | _ => Pill
  }
}

/**
  Convert integer (1-3) to color variant
  */
let toColor = (n: int): color => {
  switch n {
  | 1 => Red
  | 2 => Green
  | _ => Purple
  }
}

/**
  Convert integer (1-3) to fill variant
  */
let toFill = (n: int): fill => {
  switch n {
  | 1 => Solid
  | 2 => Striped
  | _ => Outlined
  }
}

let toNumber = (n: int): number => {
  switch n {
  | 1 => One
  | 2 => Two
  | _ => Three
  }
}

module type t = {
  type shape
  type color
  type fill
  type t
  let toShape: int => shape
  let toColor: int => color
  let toFill: int => fill
  let toNumber: int => number
}

type renderCard = (~card: t) => React.element

/*
These SVGs are shamelessly stolen from https://github.com/hugosaintemarie/set-game,
who inspired this project.
 */
module Render = {
  module Diamond = {
    @react.component
    let make: renderCard = (~card) => {
      <svg id="diamond" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" viewBox="0 0 12 8">
          <polygon points="1,4 6,7 11,4 6,1 "/>
      </svg>
    }
  }

  module Pill = {
    @react.component
    let make: renderCard = (~card) => {
      <svg id="pill" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" viewBox="0 0 12 8">
          <path d="M3,2h6c1.1,0,2,0.9,2,2v0c0,1.1-0.9,2-2,2H3C1.9,6,1,5.1,1,4v0C1,2.9,1.9,2,3,2z"/>
      </svg>
    }
  }

  module Tilde = {
    @react.component
    let make: renderCard = (~card) => {
      <svg id="tilde" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" viewBox="0 0 12 8">
          <path d="M2,6.3C1.4,6.3,0.9,6,0.5,5.5C0,4.7,0.2,3.6,1,3c1.9-1.3,4-1.7,6-0.6c0.7,0.4,1.3,0.2,1.9-0.3c0.7-0.6,1.8-0.5,2.5,0.2
                  c0.6,0.7,0.5,1.8-0.2,2.5C9.4,6.3,7.3,6.6,5.3,5.5C4.5,5.1,3.7,5.4,3,6C2.7,6.2,2.3,6.3,2,6.3z"/>
      </svg>
    }
  }
}