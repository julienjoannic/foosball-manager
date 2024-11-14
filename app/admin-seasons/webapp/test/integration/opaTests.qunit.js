sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sig/cap/foosball/app/adminseasons/test/integration/FirstJourney',
		'sig/cap/foosball/app/adminseasons/test/integration/pages/SeasonsList',
		'sig/cap/foosball/app/adminseasons/test/integration/pages/SeasonsObjectPage'
    ],
    function(JourneyRunner, opaJourney, SeasonsList, SeasonsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sig/cap/foosball/app/adminseasons') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheSeasonsList: SeasonsList,
					onTheSeasonsObjectPage: SeasonsObjectPage
                }
            },
            opaJourney.run
        );
    }
);