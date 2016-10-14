module Utils.Number exposing (toFixed)

import List exposing (head, tail, length)
import Maybe exposing (withDefault)
import String exposing (padRight, split)
import Utils.Math exposing (roundBy)

toFixed : Int -> Float -> String
toFixed decimalPlaces num =
  let
    roundedStr = roundBy decimalPlaces num |> toString
  in
    if decimalPlaces == 0 then
      roundedStr
    else
      let
        splitted = split "." roundedStr
        left = withDefault "0" (head splitted)
        right = splitted |> tail |> withDefault [] |> head |> withDefault ""
      in
        left ++ "." ++ (padRight decimalPlaces '0' right)
