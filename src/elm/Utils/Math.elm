module Utils.Math exposing (roundBy)

roundBy : Int -> Float -> Float
roundBy decimalPlaces num =
  let
    multiplier = toFloat decimalPlaces * 10
  in
    (round(num * multiplier) |> toFloat) / multiplier
