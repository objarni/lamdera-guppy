module Backend exposing (Model, app, init, update, updateFromFrontend)

import Html
import Lamdera exposing (ClientId, SessionId, sendToFrontend)
import Types exposing (..)


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = \m -> Sub.none
        }


init : ( Model, Cmd BackendMsg )
init =
    ( { message = "Hello!", clients = [] }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )

        NewClient ->
            ( { model | clients = clientId :: model.clients }
            , sendToFrontend clientId (UpdateMessage model.message)
            )

        SetMessage newMessage ->
            ( { model | message = newMessage }
            , sendToAll (UpdateMessage newMessage) model.clients
            )


sendToAll : ToFrontend -> List ClientId -> Cmd a
sendToAll message clients =
    let
        send m c =
            sendToFrontend c m
    in
    clients
        |> List.map (send message)
        |> Cmd.batch



-- FEEDBACK: why is
