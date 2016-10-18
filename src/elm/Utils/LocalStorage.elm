module Utils.LocalStorage exposing (getOauth, remove)
import Models exposing (OauthModel)

import Native.LocalStorage
import Json.Decode exposing (Value)

-- TODO find out the best way to do this
getOauth : Maybe OauthModel
getOauth =
  Native.LocalStorage.get "auth"

remove : String -> Value
remove key =
  Native.LocalStorage.remove key
