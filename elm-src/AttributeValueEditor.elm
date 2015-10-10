module AttributeValueEditor where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (input, button, text, div, Html)
import Html.Attributes exposing (value, type', size)
import Html.Events exposing (on, onClick, targetValue)
import Json.Decode as Json
import Debug
import Common exposing (..)
import String exposing (toInt)

type alias Model =
  AttributeValue

init : Model -> (Model, Effects Action)
init value =
  (value, Effects.none)

type Action
  = SetValue String

update : Action -> Model -> (Model, Effects Action)
update message model =
  let
    noop = 
      (model, Effects.none)
  in
    case message of
      SetValue value ->
        case model of
          TextValue _ ->
            (TextValue value, Effects.none)
          IntValue _ ->
            case (toInt value) of
              Ok i -> (IntValue (Just i), Effects.none)
              Err msg -> noop
      _ ->
        noop

view : Signal.Address Action -> Model -> Html
view address model =
  div []
      [ getInputField address model
      , text <| toString model
      ]

getInputField address model =
  case model of
    TextValue val ->
      input
        [ value val
        , on "input" targetValue (Signal.message address << SetValue)
        ]
        []
    IntValue val ->
      let
          strVal = case val of
            Just i -> toString i
            Nothing -> ""
      in
        input
          [ value strVal
          , on "input" targetValue (Signal.message address << SetValue)
          , type' "number"
          , size 5
          ]
          []
    _ -> text "UNKNOWN"
