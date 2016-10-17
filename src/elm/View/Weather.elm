module View.Weather exposing (weather)

import Html exposing (Html, div, text)
import Messages exposing (Message)
import Models exposing (FetchStatus(Failed, Fetching, Succeeded), WeatherModel)
import Utils.Temperature exposing (fahrenheitToCelsius, toDegreesString)

weather : WeatherModel -> Html Message
weather model =
  case model.status of
    Fetching ->
      div [] [ text("Fetching weather...") ]
    Failed ->
      div [] [ text("Weather fetch failed") ]
    Succeeded ->
      case model.details of
        Nothing ->
          div [] [ text("...") ] -- should never happen
        Just details ->
          let temperature =
            fahrenheitToCelsius details.temperature
            |> toDegreesString
          in
            div []
              [ text( "Current: " ++ temperature ) ]
