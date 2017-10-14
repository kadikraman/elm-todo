module Main exposing (..)

import Html exposing (Html, text, div, img, input, ul)
import Html.Attributes exposing (src, type_, checked, class)
import Html.Events exposing (onClick)


---- MODEL ----


type alias ToDo =
    { id : Int
    , isDone : Bool
    , label : String
    }


type alias Model =
    { toDos : List ToDo
    }


init : ( Model, Cmd Msg )
init =
    ( { toDos =
            [ { id = 0, isDone = True, label = "Chckbox in Elm" }
            , { id = 1, isDone = False, label = "Render a list of items" }
            , { id = 2, isDone = False, label = "Adding new items" }
            ]
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = ToggleIsDone Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleIsDone id ->
            ( { model | toDos = List.map (toggle id) model.toDos }, Cmd.none )


toggle id todo =
    if (todo.id == id) then
        { todo | isDone = not todo.isDone }
    else
        todo



---- VIEW ----


renderTodo : ToDo -> Html Msg
renderTodo toDo =
    div [ onClick (ToggleIsDone toDo.id), class "todo" ]
        [ input [ type_ "checkbox", checked toDo.isDone ] []
        , text toDo.label
        ]


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "todos" ] [ ul [] (List.map renderTodo model.toDos) ]
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
