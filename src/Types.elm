module Types exposing (BackendModel, BackendMsg(..), FrontendModel, FrontendMsg(..), ToBackend(..), ToFrontend(..))

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Dict
import Lamdera
import Url exposing (Url)


type alias FrontendModel =
    { key : Key
    , message : String
    }


type alias BackendModel =
    { message : String
    , clients : Dict.Dict Lamdera.ClientId { x : Int, y : Int }
    }



-- Frontend -> Frontend


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg
    | WrapToBackend ToBackend



-- Frontend -> Backend


type ToBackend
    = NewClient
    | NoOpToBackend
    | SetMessage String



-- Backend -> Backend


type BackendMsg
    = NoOpBackendMsg



-- Backend -> Frontend


type ToFrontend
    = NoOpToFrontend
    | UpdateMessage String



-- FEEDBACK: Surprised not only message types are here
-- (mixes state types and message types)
