import Effects exposing (Never)
-- import FlexibleField exposing (init, update, view)
import AttributeValueEditor exposing (init, update, view)
import StartApp
import Task
import Common exposing (..)


app =
  StartApp.start
    -- { init = init <| TextValue "Hello world"
    { init = init <| IntValue 666
    , update = update
    , view = view
    , inputs = []
    }

main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks



