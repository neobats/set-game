@react.component
let make = (~card: CardDef.t) => {

  <article className="flex flex-col items-center justify-between p-2 border-2 border-gray-300 rounded-md">
    <Icon.make card=card />
  </article>
}