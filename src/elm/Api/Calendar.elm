module Api.Calendar exposing(fetchCalendar)

import Date exposing (Date)
import Http exposing (defaultSettings, empty, uriEncode)
import Messages exposing (Message(CalendarFetchFail, CalendarFetchSucceed))
import Task
import Json.Decode as Decode exposing (Decoder, (:=))
import Models exposing (CalendarDetails)
import Utils.Date exposing (dateToString)

fetchCalendar : String -> String -> String -> Date -> Cmd Message
fetchCalendar clientId accessToken calendarName now =
  let
    request =
      { url = "https://www.googleapis.com/calendar/v3/calendars/" ++
          uriEncode calendarName ++
          "/events?maxResults=50&timeMin=" ++ (uriEncode <| dateToString now) ++
          "&key=" ++ uriEncode clientId
      , headers = [("Authorization", "Bearer " ++ accessToken)]
      , verb = "GET"
      , body = empty
      }
  in
    Http.fromJson decodeCalendar (Http.send defaultSettings request)
    |> Task.perform CalendarFetchFail CalendarFetchSucceed

decodeCalendar : Decoder CalendarDetails
decodeCalendar =
  Decode.object2 CalendarDetails
    (Decode.at [ "updated" ] Decode.string)
    (Decode.at [ "summary" ] Decode.string)
