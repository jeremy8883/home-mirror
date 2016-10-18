module View.Calendar exposing (calendar)

import Html exposing (Html, button, div, text)

import Messages exposing (Message)
import Models exposing (CalendarDetailsModel, Model)
import Selectors.Oauth exposing (getIsAuthorized)

calendar : Model -> Html Message
calendar state =
  let
    props =
      { isAuthorized = getIsAuthorized state
      , details = state.calendar.details
      }
  in
    calendarChild props

calendarChild : ViewModel -> Html Message
calendarChild model =
  if model.isAuthorized then
    case model.details of
      Nothing ->
        div [] [ text "..." ]
      Just a ->
        calendarDetails a
  else
    div [ ] [ text "Login required for calendar" ]

type alias ViewModel =
  { isAuthorized: Bool
  , details: Maybe CalendarDetailsModel
  }

calendarDetails : CalendarDetailsModel -> Html Message
calendarDetails calendar =
  div [ ] [ text ("Yes, this is a calendar for " ++ calendar.summary) ]
