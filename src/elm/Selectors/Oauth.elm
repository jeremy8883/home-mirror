module Selectors.Oauth exposing (getLoginUrl, getIsAuthorized)

import Http exposing (encodeUri)
import Models exposing (Root)
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

getLoginUrl : Root -> String
getLoginUrl state =
  baseUrl ++ "scope=" ++ encodeUri (scope |> join " ") ++
  "&client_id=" ++ encodeUri state.config.oauth.clientId ++
  "&redirect_uri=" ++ encodeUri redirectUri ++
  "&response_type=token"

getIsAuthorized : Root -> Bool
getIsAuthorized state =
  state.oauth /= Nothing
