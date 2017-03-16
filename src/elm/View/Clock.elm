module View.Clock exposing (clock)

import Html.Attributes exposing (class)
import Date exposing (Date, fromTime)
import Html exposing (Html, div, text)
import String exposing (pad)

import Messages exposing (Message)
import Models exposing (Clock)

toTimeString : Date -> String
toTimeString date =
  let
    hours = date |> Date.hour |> toString
    minutes = date |> Date.minute |> toString |> pad 2 '0'
  in
    hours ++ ":" ++ minutes

clock : Clock -> Html Message
clock model =
  let
    date = fromTime model
  in
    div [ class "clock" ][
      text ( toTimeString date )
    ]
