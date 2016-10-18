module Api.Calendar exposing(fetchCalendar)

import Http exposing (defaultSettings, empty, uriEncode)
import Messages exposing (Message(CalendarFetchFail, CalendarFetchSucceed))
import Task
import Json.Decode as Decode exposing (Decoder, (:=))
import Models exposing (CalendarDetailsModel)

fetchCalendar : String -> String -> String -> Cmd Message
fetchCalendar clientId accessToken calendarName =
  let
    request =
      { url = "https://www.googleapis.com/calendar/v3/calendars/" ++
          uriEncode calendarName ++
          "/events?maxResults=50&timeMin=" ++ uriEncode "2016-07-04T10:00:00Z" ++
          "&key=" ++ uriEncode clientId
      , headers = [("Authorization", "Bearer " ++ accessToken)]
      , verb = "GET"
      , body = empty
      }
  in
    Http.fromJson decodeCalendar (Http.send defaultSettings request)
    |> Task.perform CalendarFetchFail CalendarFetchSucceed

decodeCalendar : Decoder CalendarDetailsModel
decodeCalendar =
  Decode.object2 CalendarDetailsModel
    (Decode.at [ "updated" ] Decode.string)
    (Decode.at [ "summary" ] Decode.string)
