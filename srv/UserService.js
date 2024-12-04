const cds = require('@sap/cds');

module.exports = class UserService extends cds.ApplicationService {

    async init() {
        const { Tables, Games, Players, Seasons } = this.entities;

        this.on('GetDefaultValuesForGames', async function(req) {

            var defaults = {
                PlayedAt: new Date(),
                Table_ID: '',
                Teams: []
            };

            console.log(defaults.PlayedAt);

            var userPlayer = await SELECT.one.from(Players, p => {
                p.ID, p.DefaultTable_ID
            }).where({ Username: req.user.id });

            if (userPlayer) {
                defaults.Table_ID = userPlayer.DefaultTable_ID;
            }

            if (!defaults.Table_ID) {
                var tables = await SELECT.from(Tables, t => {
                    t.ID
                });

                if (tables.length == 1) {
                    defaults.Table_ID = tables[0].ID;
                }
            }

            if (defaults.Table_ID) {
                var table = await SELECT.one.from(Tables, t => {
                    t.Team1Color, t.Team2Color
                }).where({ ID: defaults.Table_ID });

                if (table) {
                    defaults.Teams = [
                        {
                            Color: table.Team1Color,
                            Player_ID: null
                        },
                        {
                            Color: table.Team2Color,
                            Player_ID: null
                        }
                    ];

                    if (userPlayer) {
                        defaults.Teams[0].Player_ID = userPlayer.ID;
                    }
                }
            }

            return defaults;
        });

        this.before(['CREATE', 'UPDATE'], 'Games' , async (req) => {
            // Check that players are different¨
            if (req.data.Teams[0].Player_ID == req.data.Teams[1].Player_ID) {
                req.error('Les joueurs doivent être différent dans chaque équipe');
            }

            // Check that a single team has 10 points
            var winningTeam, losingTeam;
            if ((req.data.Teams[0].Score < 10) && (req.data.Teams[1].Score < 10)) {
                req.error('Une des deux équipes doit avoir 10 points');
                return;
            }
            else if (req.data.Teams[0].Score == req.data.Teams[1].Score) {
                req.error('Une seule équipe doit avoir 10 points');
                return;
            }
            else if (req.data.Teams[0].Score > req.data.Teams[1].Score) {
                winningTeam = 0;
                losingTeam = 1;
            }
            else {
                winningTeam = 1;
                losingTeam = 0;
            }

            req.data.WinningTeamColor = req.data.Teams[winningTeam].Color;
            req.data.Teams[winningTeam].Won = true;
            req.data.Teams[losingTeam].Won = false;

            var players = [
                await SELECT.one.from(Players, p => { p.Name }).where({ ID: req.data.Teams[0].Player_ID}),
                await SELECT.one.from(Players, p => { p.Name }).where({ ID: req.data.Teams[1].Player_ID})
            ];
            req.data.Description = `(${req.data.Teams[0].Color}) ${players[0].Name} ${req.data.Teams[0].Score} - ${req.data.Teams[1].Score} ${players[1].Name} (${req.data.Teams[1].Color})`;

            // Fill season
            var refDate = new Date(req.data.PlayedAt);
            var season = await SELECT.one.from(Seasons, s => { s.ID })
                .where({ DateFrom: { '<=': refDate }, and: { DateTo: { '>=': refDate }}});
            if (season) {
                req.data.Season_ID = season.ID;
            }

            // Fill null values
            for (var team in req.data.Teams) {
                if (!req.data.Teams[team].Thomatines) req.data.Teams[team].Thomatines = 0;
                if (!req.data.Teams[team].Gamelles) req.data.Teams[team].Gamelles = 0;
            }
        });

        await super.init();
    }
}