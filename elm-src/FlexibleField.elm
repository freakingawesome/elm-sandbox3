module FlexibleField where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (input, button, text, div, Html)
import Html.Attributes exposing (value)
import Html.Events exposing (on, onClick, targetValue)
import Json.Decode as Json
import Debug

type alias Model =
  { value : String
  , mode : Mode
  , tempValue : Maybe String
  }

type Mode = Read | Write

init : String -> (Model, Effects Action)
init value =
  ({ value = value, mode = Read, tempValue = Nothing }, Effects.none)

type Action
  = SetValue String
  | UpdateTempValue String
  | ChangeMode Mode
  | Save (Maybe String)
  | Cancel

update : Action -> Model -> (Model, Effects Action)
update message model =
  let
    noop = 
      (model, Effects.none)
  in
    case message of
      SetValue value ->
        if model.mode == Write then
          ({ model | value <- value }, Effects.none)
        else
          noop
      UpdateTempValue value ->
        ({ model | tempValue <- Just value }, Effects.none)
      ChangeMode Read ->
        ({ model | mode <- Read, tempValue <- Nothing }, Effects.none)
      ChangeMode Write ->
        ({ model | mode <- Write, tempValue <- Just model.value }, Effects.none)
      Save Nothing ->
        ({ model | mode <- Read, tempValue <- Nothing }, Effects.none)
      Save (Just value) ->
        ({ model | mode <- Read, value <- value, tempValue <- Nothing }, Effects.none)
      Cancel ->
        ({ model | mode <- Read }, Effects.none)
      _ ->
        noop

view : Signal.Address Action -> Model -> Html
view address model =
  case model.mode of
    Read ->
      div [ onClick address <| ChangeMode Write
          ]
          [ text model.value
          ]
    Write ->
      div []
          [ input
              [ value <| Maybe.withDefault "" model.tempValue
              , on "input" targetValue (Signal.message address << UpdateTempValue)
              ]
              []
          , button [ onClick address (Save model.tempValue) ] [ text "Save" ]
          , button [ onClick address Cancel ] [ text "Cancel" ]
          ]
