module Api.Oauth exposing(fetchUserInfo, logout)

import Http exposing (uriEncode, empty)
import Messages exposing (Message(OauthFetchUserInfoFail, OauthFetchUserInfoSucceed, OauthLogoutFail, OauthLogoutSucceed))
import Task
import Json.Decode as Decode exposing (Decoder, (:=))
import Models exposing (LogoutResponseModel, UserDetailsModel)

fetchUserInfo : String -> Cmd Message
fetchUserInfo accessToken =
  let
    url = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" ++ uriEncode accessToken
  in
    Task.perform OauthFetchUserInfoFail OauthFetchUserInfoSucceed (Http.get decodeUser url)

decodeUser : Decoder UserDetailsModel
decodeUser =
  Decode.object2 UserDetailsModel
    (Decode.at [ "name" ] Decode.string)
    (Decode.at [ "email" ] Decode.string)


logout : String -> Cmd Message
logout accessToken =
  let
    url = "httpshttps://accounts.google.com/o/oauth2/revoke?token=" ++ uriEncode accessToken
  in
    Task.perform OauthLogoutFail OauthLogoutSucceed (Http.post logoutDecoder url empty)

logoutDecoder : Decoder LogoutResponseModel
logoutDecoder =
  Decode.object1 LogoutResponseModel
    (Decode.at [ "success" ] Decode.bool)
