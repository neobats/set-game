/*
These SVGs are shamelessly stolen from https://github.com/hugosaintemarie/set-game,
who inspired this project.
 */

type shapeProps = {
  fill: string,
  stroke: string,
  strokeWidth: string,
}

/**
  Get HSL color string for a color variant
  */
let getColorValue = (color: Card.color): string => {
  switch color {
  | Red => "hsl(0, 100%, 45%)"
  | Green => "hsl(120, 100%, 25%)"
  | Purple => "hsl(300, 100%, 25%)"
  }
}

/**
  Get HSL color string for a card's color
  */
let getColor = (card: Card.t): string => getColorValue(card.color)

/**
  Convert color variant to lowercase string for pattern IDs
  */
let colorToString = (color: Card.color): string => {
  switch color {
  | Red => "red"
  | Green => "green"
  | Purple => "purple"
  }
}

/**
  Generate a unique pattern ID for striped fills based on color
  */
let getPatternId = (card: Card.t): string => {
  "stripes-" ++ colorToString(card.color)
}

/**
  Get fill and stroke attributes based on card's fill type
  Returns shapeProps with fill, stroke, and strokeWidth
  */
let getFillAttrs = (card: Card.t): shapeProps => {
  let color = getColor(card)
  switch card.fill {
  | Solid => {fill: color, stroke: "none", strokeWidth: "0"}
  | Outlined => {fill: "none", stroke: color, strokeWidth: "0.3"}
  | Striped => {fill: "url(#" ++ getPatternId(card) ++ ")", stroke: color, strokeWidth: "0.3"}
  }
}

/**
  Shape components that render the SVG paths with fill attributes
  */
module Diamond = {
  @react.component
  let make = (~fill: string, ~stroke: string, ~strokeWidth: string) => {
    <svg xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" viewBox="0 0 12 8">
        <polygon 
          points="1,4 6,7 11,4 6,1"
          fill={fill}
          stroke={stroke}
          strokeWidth={strokeWidth}
        />
    </svg>
  }
}

module Pill = {
  @react.component
  let make = (~fill: string, ~stroke: string, ~strokeWidth: string) => {
    <svg xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" viewBox="0 0 12 8">
        <path 
          d="M3,2h6c1.1,0,2,0.9,2,2v0c0,1.1-0.9,2-2,2H3C1.9,6,1,5.1,1,4v0C1,2.9,1.9,2,3,2z"
          fill={fill}
          stroke={stroke}
          strokeWidth={strokeWidth}
        />
    </svg>
  }
}

module Tilde = {
  @react.component
  let make = (~fill: string, ~stroke: string, ~strokeWidth: string) => {
    <svg xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" viewBox="0 0 12 8">
        <path 
          d="M2,6.3C1.4,6.3,0.9,6,0.5,5.5C0,4.7,0.2,3.6,1,3c1.9-1.3,4-1.7,6-0.6c0.7,0.4,1.3,0.2,1.9-0.3c0.7-0.6,1.8-0.5,2.5,0.2
                c0.6,0.7,0.5,1.8-0.2,2.5C9.4,6.3,7.3,6.6,5.3,5.5C4.5,5.1,3.7,5.4,3,6C2.7,6.2,2.3,6.3,2,6.3z"
          fill={fill}
          stroke={stroke}
          strokeWidth={strokeWidth}
        />
    </svg>
  }
}

/**
  Main render function that handles fill logic and delegates to shape components
  */
@react.component
let make = (~card: Card.t) => {
  let {fill, stroke, strokeWidth} = getFillAttrs(card)
  switch card.shape {
  | Diamond => <Diamond fill={fill} stroke={stroke} strokeWidth={strokeWidth} />
  | Pill => <Pill fill={fill} stroke={stroke} strokeWidth={strokeWidth} />
  | Tilde => <Tilde fill={fill} stroke={stroke} strokeWidth={strokeWidth} />
  }
}

/**
  Pattern definitions module for striped fills
  */
module Patterns = {
  /**
    Render striped pattern definitions for all colors
    Should be included once in the app root (e.g., in a <defs> element)
    These patterns are referenced by the striped fill style
    */
  @react.component
  let make = () => {
    let colors: array<Card.color> = [Card.Red, Card.Green, Card.Purple]
    
    <svg width="0" height="0">
      <defs>
        {Belt.Array.map(colors, color => {
          let patternId = "stripes-" ++ colorToString(color)
          let colorValue = getColorValue(color)
          <pattern
            key={patternId}
            id={patternId}
            x="0"
            width="12"
            height="8"
            patternUnits="userSpaceOnUse"
            stroke={colorValue}
            strokeWidth="0.3"
          >
            <line x1="1" y1="0" x2="1" y2="8"/>
            <line x1="2.2" y1="0" x2="2.2" y2="8"/>
            <line x1="3.5" y1="0" x2="3.5" y2="8"/>
            <line x1="4.8" y1="0" x2="4.8" y2="8"/>
            <line x1="6" y1="0" x2="6" y2="8"/>
            <line x1="7.2" y1="0" x2="7.2" y2="8"/>
            <line x1="8.5" y1="0" x2="8.5" y2="8"/>
            <line x1="9.8" y1="0" x2="9.8" y2="8"/>
            <line x1="11" y1="0" x2="11" y2="8"/>
          </pattern>
        })->React.array}
      </defs>
    </svg>
  }
}