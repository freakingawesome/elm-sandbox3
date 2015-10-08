import Effects exposing (Never)
import FlexibleField exposing (init, update, view)
import StartApp
import Task


app =
  StartApp.start
    { init = init "Hello world"
    , update = update
    , view = view
    , inputs = []
    }


main =
  app.html


port tasks : Signal (Task.Task Never ())
port tasks =
  app.tasks



