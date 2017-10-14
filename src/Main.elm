module Main exposing (..)

import Html exposing (Html, text, div, img, input, ul, button)
import Html.Attributes exposing (src, type_, checked, class, value)
import Html.Events exposing (onClick, onInput)


---- MODEL ----


type alias ToDo =
    { id : Int
    , isDone : Bool
    , label : String
    }


type alias Model =
    { text : String
    , toDos : List ToDo
    }


init : ( Model, Cmd Msg )
init =
    ( { text = ""
      , toDos =
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
    | AddToDo
    | UpdateText String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleIsDone id ->
            ( { model | toDos = List.map (toggle id) model.toDos }, Cmd.none )

        UpdateText text ->
            ( { model | text = text }, Cmd.none )

        AddToDo ->
            ( { model
                | toDos =
                    List.append model.toDos
                        [ { id = List.length model.toDos
                          , label = model.text
                          , isDone = False
                          }
                        ]
                , text = ""
              }
            , Cmd.none
            )


toggle : Int -> ToDo -> ToDo
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
        [ div [] [ input [ onInput UpdateText, value model.text ] [], button [ onClick AddToDo ] [ text "Add ToDo" ] ]
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
