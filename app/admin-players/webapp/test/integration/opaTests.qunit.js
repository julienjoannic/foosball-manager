sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sig/cap/foosball/app/adminplayers/test/integration/FirstJourney',
		'sig/cap/foosball/app/adminplayers/test/integration/pages/PlayersList',
		'sig/cap/foosball/app/adminplayers/test/integration/pages/PlayersObjectPage'
    ],
    function(JourneyRunner, opaJourney, PlayersList, PlayersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sig/cap/foosball/app/adminplayers') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePlayersList: PlayersList,
					onThePlayersObjectPage: PlayersObjectPage
                }
            },
            opaJourney.run
        );
    }
);