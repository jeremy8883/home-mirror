module Models exposing (..)

import Time exposing (Time)

type alias Root =
  { config: Config
  , clock: Clock
  , weather: Weather
  , calendar: Calendar
  , oauth: Maybe Oauth
  , user: User
  }

type alias Config =
  { weather:
    { darkSkyApiKey: String
    , longitude: Float
    , latitude: Float
    }
  , oauth: { clientId: String }
  , calendar: { name: String }
  }

type alias Clock = Time

type FetchStatus
  = Fetching
  | Succeeded
  | Failed

type alias Weather =
  { status: FetchStatus
  , details: Maybe WeatherDetails
  }

type alias WeatherDetails =
  { temperature: Float }

type alias Oauth =
  { accessToken: String
  , tokenType: String
  , expiresIn: String
  }

type alias Calendar =
  { status: FetchStatus
  , details: Maybe CalendarDetails
  }

type alias CalendarDetails =
  { updated: String
  , summary: String
  }

--type alias CalendarEventItem =
--  { id: String
--  , status: String
--  , summary: String
--  , description: String
--  }

type alias User =
  { status: FetchStatus
  , details: Maybe UserDetails
  }

type alias UserDetails =
  { name: String
  , email: String
  }

type alias LogoutResponse = { success: Bool }
