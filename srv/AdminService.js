const cds = require('@sap/cds');

module.exports = class AdminService extends cds.ApplicationService {

    async init() {
        const { Tables, Seasons, Players } = this.entities;

        this.on('GetDefaultValuesForSeasons', async function(req) {

            // Calculate season number
            var defaults = {
                Number: 0,
                DateFrom: new Date().toJSON().slice(0, 10),
                DateTo: '9999-12-31'
            };

            var seasons = await SELECT.from(Seasons, s => { s.ID });
            defaults.Number = seasons.length + 1;

            return defaults;
        });

        this.before(['CREATE', 'UPDATE'], 'Seasons', async (req) => {

            // Update previous season
            var lastSeason = await SELECT.one.from(Seasons, s => { s.ID, s.DateFrom, s.DateTo })
                .where({ DateTo: '9999-12-31' });
            if (lastSeason) {
                var previousDateTo = new Date(req.data.DateFrom);
                previousDateTo.setDate(previousDateTo.getDate() - 1);
                await UPDATE(Seasons, lastSeason.ID).with({ DateTo: previousDateTo.toJSON().slice(0, 10) });
            }
        });

        await super.init();
    }
}
