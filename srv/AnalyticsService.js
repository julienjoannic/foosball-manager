const cds = require('@sap/cds');

module.exports = class AnalyticsService extends cds.ApplicationService {

    async init() {
        const { Tables, Games, Players, Seasons } = this.entities;

        this.on('GetConnectedPlayer', async (req) => {

            var player = await SELECT.one.from(Players).where({ Username: req.user.id });
            if (player) {
                return player;
            }
        })

        this.on('GetCurrentSeason', async (req) => {

            var refDate = new Date();
            var season = await SELECT
                .one
                .from(Seasons)
                .where({ DateFrom: { '<=': refDate }, and: { DateTo: { '>=': refDate }}});
            if (season) {
                return season;
            }
        })

        await super.init();
    }
};