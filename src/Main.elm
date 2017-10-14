module Main exposing (..)

import Html exposing (Html, text, div, img, input, ul, button, form, Attribute)
import Html.Attributes exposing (src, type_, checked, class, value, classList, placeholder)
import Html.Events exposing (onClick, onInput, keyCode, on)
import Json.Decode as Json


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
    | KeyDown Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleIsDone id ->
            ( { model | toDos = List.map (toggle id) model.toDos }, Cmd.none )

        UpdateText text ->
            ( { model | text = text }, Cmd.none )

        AddToDo ->
            ( addTodo model, Cmd.none )

        KeyDown key ->
            if key == 13 then
                ( addTodo model, Cmd.none )
            else
                ( model, Cmd.none )


addTodo model =
    { model
        | toDos =
            List.append model.toDos
                [ { id = List.length model.toDos
                  , label = model.text
                  , isDone = False
                  }
                ]
        , text = ""
    }


toggle : Int -> ToDo -> ToDo
toggle id todo =
    if (todo.id == id) then
        { todo | isDone = not todo.isDone }
    else
        todo


onKeyDown : (Int -> msg) -> Attribute msg
onKeyDown tagger =
    on "keydown" (Json.map tagger keyCode)



---- VIEW ----


renderTodo : ToDo -> Html Msg
renderTodo toDo =
    div [ onClick (ToggleIsDone toDo.id), class "todo" ]
        [ input [ type_ "checkbox", checked toDo.isDone, class "checkbox" ] []
        , text toDo.label
        ]


view : Model -> Html Msg
view model =
    div [ classList [ ( "pure-g", True ), ( "container", True ) ] ]
        [ div [ classList [ ( "pure-u-1", True ), ( "title", True ) ] ] [ text "Stuff that needs doing" ]
        , div [ classList [ ( "pure-u-1-2", True ), ( "inputs", True ) ] ]
            [ div [ classList [ ( "pure-form", True ), ( "pure-form-stacked", True ) ] ]
                [ input [ onInput UpdateText, value model.text, placeholder "I need to...", type_ "text", onKeyDown KeyDown ] []
                , button [ onClick AddToDo, classList [ ( "pure-button", True ), ( "pure-button-primary", True ) ], type_ "button" ] [ text "Add ToDo" ]
                ]
            ]
        , div [ class "pure-u-1-2" ] [ div [] (List.map renderTodo model.toDos) ]
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
