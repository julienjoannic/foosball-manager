using { sig.cap.foosball as db } from '../db/schema';

service UserService @(requires: 'Player') {

    @readonly entity Players as projection on db.Players;
    @readonly entity Tables as projection on db.Tables;
    @readonly entity Seasons as projection on db.Seasons;

    @odata.draft.enabled
    @fiori.draft.enabled
    @Common.DefaultValuesFunction : 'GetDefaultValuesForGames'
    entity Games as projection on db.Games {
        *,
        SUBSTRING(PlayedAt, 1, 10) as PlayedAtDate: Date
    }

    function GetDefaultValuesForGames() returns UserService.Games;
}