import Api.Weather exposing (fetchWeather)
import Api.Oauth exposing (fetchUserInfo)
import Html

import Messages exposing (Message(CalendarRequired, ClockTick, NoOp, WeatherRequired))
import Models exposing (Config, FetchStatus(Fetching), Root, Oauth)
import Task
import Time exposing (hour, minute, second)
import Update exposing (update)
import View exposing (view)
import Utils.LocalStorage as LocalStorage

main : Program Config Root Message
main =
  Html.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

oauth : Maybe Oauth
oauth =
  LocalStorage.getOauth

init : Config -> (Root, Cmd Message)
init config = (
  { clock = 0
  , config = config
  , weather =
    { status = Fetching
    , details = Nothing
    }
  , calendar =
    { status = Fetching
    , details = Nothing
    }
  , oauth = oauth
  , user =
    { status = Fetching
    , details = Nothing
    }
  }, case oauth of
    Nothing ->
      fetchWeather config.weather.darkSkyApiKey config.weather.longitude config.weather.latitude
    Just o ->
      Cmd.batch
      [ fetchWeather config.weather.darkSkyApiKey config.weather.longitude config.weather.latitude
      , fetchUserInfo o.accessToken
      , Task.perform CalendarRequired Time.now
      ]
  )

subscriptions : Root -> Sub Message
subscriptions model =
  Sub.batch
    [ Time.every second ClockTick
    , Time.every (hour * 6) WeatherRequired
    , Time.every (minute * 5) CalendarRequired
    ]
