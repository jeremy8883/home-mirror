module Messages exposing (Message(..), ClockMessage(..))

import Time exposing (Time)

type Message
  = ClockMessage' ClockMessage

type ClockMessage
  = ClockTick Time
