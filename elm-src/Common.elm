module Common where

type alias Attribute =
  { id    : Int
  , name  : String
  , value : AttributeValue
  }


type AttributeValue
  = TextValue String
  | IntValue Int
  | FloatValue Int
  | BoolValue Bool
  | ListValue ListSource ListSelection

type alias ListSource
  = ListSourceID -> List (Int, String)

type alias ListSourceID
  = Int

type alias ListSelection
  = List Int


