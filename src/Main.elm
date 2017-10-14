module Main exposing (..)

import Html exposing (Html, text, div, img, input, ul)
import Html.Attributes exposing (src, type_, checked, class)
import Html.Events exposing (onClick)


---- MODEL ----


type alias ToDo =
    { isDone : Bool
    , label : String
    }


type alias Model =
    { isChecked : Bool
    , toDos : List ToDo
    }


init : ( Model, Cmd Msg )
init =
    ( { isChecked = True
      , toDos =
            [ { isDone = True, label = "Chckbox in Elm" }
            , { isDone = False, label = "Render a list of items" }
            , { isDone = False, label = "Adding new items" }
            ]
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ToggleIsChecked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleIsChecked ->
            ( { model | isChecked = not model.isChecked }, Cmd.none )



---- VIEW ----


renderTodo : ToDo -> Html Msg
renderTodo toDo =
    div []
        [ input [ type_ "checkbox", checked toDo.isDone ] []
        , text toDo.label
        ]


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ input [ type_ "checkbox", onClick ToggleIsChecked, checked model.isChecked ] []
        , text "Do the thing"
        , div [ class "todos" ] [ ul [] (List.map renderTodo model.toDos) ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
