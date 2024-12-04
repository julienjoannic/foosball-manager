namespace sig.cap.foosball;

using { cuid, managed } from '@sap/cds/common';

entity Players : cuid, managed {

    Name: String;
    Username: String;
    DefaultTable: Association to Tables;
}

entity Tables : cuid, managed {

    Brand: String;
    Model: String;
    Location: String;

    Description: String = Brand || ' ' || Model || ' ' || Location;

    Team1Color: String;
    Team1Name: String = 'Equipe ' || Team1Color;
    Team2Color: String;
    Team2Name: String = 'Equipe ' || Team2Color;
}

entity Seasons : cuid, managed {

    Number: Integer;
    DateFrom: Date;
    DateTo: Date;

    Description: String = 'Saison ' || Number || ' - ' || DateFrom || ' au ' || DateTo;
}

entity GameTeams: managed {
    key Game: Association to Games;
    key Color: String;
    Score: Integer @assert.range: [-100, 10];
    Thomatines: Integer @assert.range: [0, 100];
    Gamelles: Integer @assert.range: [0, 100];
    Won: Boolean;

    Player: Association to Players;
}

entity Games : cuid, managed {

    Table: Association to Tables;
    Season: Association to Seasons;
    PlayedAt: Timestamp;
    WinningTeamColor: String;

    Teams: Composition of many GameTeams on Teams.Game = $self;

    Description: String;
}