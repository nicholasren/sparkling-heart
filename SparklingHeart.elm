port module SparklingHeart exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


main =
    beginnerProgram
        { model = emptyModel
        , view = view
        , update = update
        }


type alias Model =
    { hearts : List Heart
    }


type alias Heart =
    { comment : String
    }


emptyModel : Model
emptyModel =
    { hearts = []
    }


view : Model -> Html Msg
view model =
    div []
        [ div [ class "pure-g" ] [ h2 [ class "header" ] [ text "Daisy's sparkling heart" ] ]
        , div [ class "pure-g" ]
            [ div [ class "content" ]
                [ div [] [ img [ src "./public/daisy.jpg", width 500 ] [] ]
                , div [ class "hearts" ] (display model)
                , div []
                    [ button [ onClick Decrement, class "pure-button pure-1-2" ] [ text "减少" ]
                    , button [ onClick Increment, class "pure-button pure-1-2" ] [ text "增加" ]
                    ]
                ]
            ]
        ]


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { hearts = model.hearts ++ [ newHeart ] }

        Decrement ->
            { hearts = Maybe.withDefault [] (List.tail (model.hearts)) }


newHeart : Heart
newHeart =
    { comment = "Sparkling"
    }


display : Model -> List (Html msg)
display model =
    (List.map (\h -> span [] [ text "💖" ]) model.hearts)
