module Api.Oauth exposing(fetchUserInfo, logout)

import Http exposing (emptyBody, encodeUri)
import Json.Decode exposing (field)
import Messages exposing (Message(OauthLogoutPost, OauthUserInfoFetch, OauthUserInfoRequired))
import Models exposing (LogoutResponse, UserDetails)

fetchUserInfo : String -> Cmd Message
fetchUserInfo accessToken =
  let
    url = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" ++ encodeUri accessToken
    request = Http.get url decodeUser
  in
    Http.send OauthUserInfoFetch request

decodeUser : Json.Decode.Decoder UserDetails
decodeUser =
  Json.Decode.map2 UserDetails
    (field "name" Json.Decode.string)
    (field "email" Json.Decode.string)


logout : String -> Cmd Message
logout accessToken =
  let
    url = "httpshttps://accounts.google.com/o/oauth2/revoke?token=" ++ encodeUri accessToken
    request = Http.post url emptyBody logoutDecoder
  in
    Http.send OauthLogoutPost request

logoutDecoder : Json.Decode.Decoder LogoutResponse
logoutDecoder =
  Json.Decode.map LogoutResponse
    (field "success" Json.Decode.bool)
