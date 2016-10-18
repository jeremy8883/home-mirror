module View.Settings exposing (settings)

import Html exposing (Html, a, button, div, text)

import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Messages exposing (Message(OauthLogout))
import Models exposing (Model, UserDetailsModel)
import Selectors.Oauth exposing (getIsAuthorized, getLoginUrl)

settings : Model -> Html Message
settings state =
  let
    props =
      { loginUrl = getLoginUrl state
      , userDetails = state.user.details
      }
  in
    settingsChild props

settingsChild : ViewModel -> Html Message
settingsChild model =
  case model.userDetails of
    Nothing ->
      a [ href model.loginUrl ] [ text "Log in" ]
    Just ud ->
      button [onClick OauthLogout] [ text ("Log out of " ++ ud.name) ]

type alias ViewModel =
  { loginUrl: String
  , userDetails: Maybe UserDetailsModel
  }
