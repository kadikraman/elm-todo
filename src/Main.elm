module Main exposing (..)

import Html exposing (Html, text, div, img, input)
import Html.Attributes exposing (src, type_, checked, class)
import Html.Events exposing (onClick)


---- MODEL ----


type alias Model =
    { isChecked : Bool }


init : ( Model, Cmd Msg )
init =
    ( { isChecked = True }, Cmd.none )



---- UPDATE ----


type Msg
    = ToggleIsChecked


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleIsChecked ->
            ( { model | isChecked = not model.isChecked }, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ input [ type_ "checkbox", onClick ToggleIsChecked, checked model.isChecked ] []
        , text "Do the thing"
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
