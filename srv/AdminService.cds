using { sig.cap.foosball  as db } from '../db/schema';

service AdminService @(requires: 'Admin') {
    
    @odata.draft.enabled
    @fiori.draft.enabled
    entity Players as projection on db.Players;

    @odata.draft.enabled
    @fiori.draft.enabled
    entity Tables as projection on db.Tables;

    @odata.draft.enabled
    @fiori.draft.enabled
    @Common.DefaultValuesFunction : 'GetDefaultValuesForSeasons'
    entity Seasons as projection on db.Seasons;

    function GetDefaultValuesForSeasons() returns AdminService.Seasons;
}