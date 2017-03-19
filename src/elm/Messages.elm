module Messages exposing (Message(..))

import Http
import Models exposing (CalendarDetails, LogoutResponse, UserDetails, WeatherDetails)
import Time exposing (Time)

type Message
  = ClockTick Time
  | WeatherRequired Time
  | WeatherFetch (Result Http.Error WeatherDetails)
  | OauthUserInfoRequired
  | OauthUserInfoFetch (Result Http.Error UserDetails)
  | OauthLogoutRequired
  | OauthLogoutPost (Result Http.Error LogoutResponse)
  | CalendarRequired Time
  | CalendarFetch (Result Http.Error CalendarDetails)
  | NoOp
