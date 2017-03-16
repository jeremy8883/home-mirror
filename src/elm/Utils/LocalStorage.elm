module Utils.LocalStorage exposing (getOauth, remove)
import Models exposing (Oauth)

import Native.LocalStorage
import Json.Decode exposing (Value)

-- TODO find out the best way to do this
getOauth : Maybe Oauth
getOauth =
  Native.LocalStorage.get "auth"

remove : String -> Value
remove key =
  Native.LocalStorage.remove key
