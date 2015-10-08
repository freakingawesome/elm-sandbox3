module FlexibleField where

import Effects exposing (Effects, map, batch, Never)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json

type alias Model = String

init : String -> (Model, Effects Action)
init s =
  (s, Effects.none)

type Action
  = NoOp

update : Action -> Model -> (Model, Effects Action)
update message model =
  (model, Effects.none)

view : Signal.Address Action -> Model -> Html
view address model =
  div []
      [ text model ]
