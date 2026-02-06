
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
| Stripped
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
  | 2 => Stripped
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