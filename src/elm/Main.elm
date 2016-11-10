import Api.Calendar exposing (fetchCalendar)
import Api.Weather exposing (fetchWeather)
import Api.Oauth exposing (fetchUserInfo)
import Date
import Html.App

import Messages exposing (Message(CalendarFetch, ClockTick, NoOp, WeatherFetch))
import Models exposing (ConfigModel, FetchStatus(Fetching), Model, OauthModel)
import Task
import Time exposing (hour, minute, second)
import Update exposing (update)
import View exposing (view)
import Utils.LocalStorage as LocalStorage

main =
  Html.App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

oauth : Maybe OauthModel
oauth =
  LocalStorage.getOauth

init : ConfigModel -> (Model, Cmd Message)
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
      , Task.perform (\_ -> NoOp) CalendarFetch Time.now
      ]
  )

subscriptions : Model -> Sub Message
subscriptions model =
  Sub.batch
    [ Time.every second ClockTick
    , Time.every (hour * 6) WeatherFetch
    , Time.every (minute * 5) CalendarFetch
    ]
