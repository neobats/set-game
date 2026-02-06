
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

type t = {
  id: int,
  shape: shape,
  color: color,
  fill: fill,
  qty: int,
}

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

module type t = {
  type shape
  type color
  type fill
  type t
  let toShape: int => shape
  let toColor: int => color
  let toFill: int => fill
}