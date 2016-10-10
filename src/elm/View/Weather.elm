module View.Weather exposing (weather)

import Html exposing (Html, div, text)
import Messages exposing (Message)
import Models exposing (FetchStatus(Failed, Fetching, Succeeded), WeatherModel)

weather : WeatherModel -> Html Message
weather model =
  case model.status of
    Fetching ->
      div [] [ text("Fetching weather...") ]
    Failed ->
      div [] [ text("Failed") ]
    Succeeded ->
      case model.details of
        Nothing ->
          div [] [ text("...") ] -- should never happen
        Just details ->
          let temperature =
            details.temperature |> toString
          in
            div []
              [ text( "Current: " ++ temperature ) ]
