module Messages exposing (Message(..))

import Http
import Models exposing (CalendarDetails, LogoutResponse, UserDetails, WeatherDetails)
import Time exposing (Time)

type Message
  = ClockTick Time
  | WeatherFetch Time
  | WeatherFetchSucceed WeatherDetails
  | WeatherFetchFail Http.Error
  | OauthFetchUserInfo
  | OauthFetchUserInfoSucceed UserDetails
  | OauthFetchUserInfoFail Http.Error
  | OauthLogout
  | OauthLogoutSucceed LogoutResponse
  | OauthLogoutFail Http.Error
  | CalendarFetch Time
  | CalendarFetchSucceed CalendarDetails
  | CalendarFetchFail Http.Error
  | NoOp
