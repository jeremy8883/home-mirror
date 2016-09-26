module Update exposing (update)

import Messages exposing (ClockMessage(ClockTick), Message(ClockMessage'))
import Models exposing (Model)

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    ClockMessage' message ->
      updateClockMessage message model

updateClockMessage : ClockMessage -> Model -> (Model, Cmd Message)
updateClockMessage message model =
  case message of
    ClockTick newTime ->
     ({ model | clock = newTime }, Cmd.none)
