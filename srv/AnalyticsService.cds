using { sig.cap.foosball as db } from '../db/schema';

service AnalyticsService @(requires: 'Player') {
    @readonly entity Players as projection on db.Players;
    @readonly entity Tables as projection on db.Tables;
    @readonly entity Seasons as projection on db.Seasons;

    @readonly
    @Aggregation.ApplySupported: {
        Transformations: [
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'filter',
            'search'
        ]
    }
    entity Games as projection on db.Games {
        key ID,
        PlayedAt,
        Table,
        Season,
        Season.Description as SeasonDescription,
        SUBSTRING(PlayedAt, 1, 10) as PlayedAtDate: Date,
        Teams.Player,
        Teams.Player.Name as PlayerName,
        Teams.Color,
        Teams.Score,
        Teams.Gamelles,
        Teams.Thomatines,
        Teams.Won,
    }

    @readonly
    @Aggregation.ApplySupported: {
        Transformations: [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'search'
        ],
        Rollup: #None,
        GroupableProperties: [
            PlayerName,
            SeasonDescription,
            Season_ID
        ],
        AggregatableProperties: [
            { Property: WinRate },
            { Property: GamesPlayed }
        ]
    }
    entity PlayerStatistics as SELECT from db.GameTeams {
        key Player.Name as PlayerName,
        key Game.Season,
        Game.Season.Description as SeasonDescription,
        count(*) as GamesPlayed:Integer,
        sum(case Won when true then 1 else 0 end) as GamesWon:Integer,
        sum(case Won when false then 1 else 0 end) as GamesLost:Integer,
        round((sum(case Won when true then 1 else 0 end) * 100.0)/count(*), 2) as WinRate:Decimal(3,2),
        sum(Gamelles) as Gamelles:Integer,
        round((sum(Gamelles) * 1.0)/count(*), 2) as GamellesPerGame:Decimal(2,2),
        sum(Thomatines) as Thomatines:Integer,
        round((sum(Thomatines) * 1.0)/count(*), 2) as ThomatinesPerGame:Decimal(2,2)
    } GROUP BY Player.Name, Game.Season, Game.Season.Number, Game.Season.DateFrom, Game.Season.DateTo;

    function GetConnectedPlayer() returns Players;
    function GetCurrentSeason() returns Seasons;
}