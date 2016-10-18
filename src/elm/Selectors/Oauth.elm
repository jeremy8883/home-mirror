module Selectors.Oauth exposing (getLoginUrl, getIsAuthorized)

import Http exposing (uriEncode)
import Models exposing (Model)
import String exposing (join)

baseUrl : String
baseUrl =
  "https://accounts.google.com/o/oauth2/auth?"

scope : List String
scope =
  [ "https://www.googleapis.com/auth/userinfo.profile"
  , "https://www.googleapis.com/auth/userinfo.email"
  , "https://www.googleapis.com/auth/calendar.readonly"
  ]

redirectUri : String
redirectUri =
  "http://localhost:8090/static/oauth.html"

getLoginUrl : Model -> String
getLoginUrl state =
  baseUrl ++ "scope=" ++ uriEncode (scope |> join " ") ++
  "&client_id=" ++ uriEncode state.config.oauth.clientId ++
  "&redirect_uri=" ++ uriEncode redirectUri ++
  "&response_type=token"

getIsAuthorized : Model -> Bool
getIsAuthorized state =
  state.oauth /= Nothing
