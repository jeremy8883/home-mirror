module Utils.String exposing (appendP)

import String exposing (append)

{-| Just like String's append, but swaps the arguments so you can pipe the function
-}
appendP : String -> String -> String
appendP strA strB =
  append strB strA
