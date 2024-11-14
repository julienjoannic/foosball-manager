sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sig/cap/foosball/app/usergames/test/integration/FirstJourney',
		'sig/cap/foosball/app/usergames/test/integration/pages/GamesList',
		'sig/cap/foosball/app/usergames/test/integration/pages/GamesObjectPage'
    ],
    function(JourneyRunner, opaJourney, GamesList, GamesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sig/cap/foosball/app/usergames') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheGamesList: GamesList,
					onTheGamesObjectPage: GamesObjectPage
                }
            },
            opaJourney.run
        );
    }
);