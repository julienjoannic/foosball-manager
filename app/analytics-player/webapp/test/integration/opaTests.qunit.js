sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sig/cap/foosball/app/analyticsplayer/test/integration/FirstJourney',
		'sig/cap/foosball/app/analyticsplayer/test/integration/pages/PlayerStatisticsList',
		'sig/cap/foosball/app/analyticsplayer/test/integration/pages/PlayerStatisticsObjectPage'
    ],
    function(JourneyRunner, opaJourney, PlayerStatisticsList, PlayerStatisticsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sig/cap/foosball/app/analyticsplayer') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePlayerStatisticsList: PlayerStatisticsList,
					onThePlayerStatisticsObjectPage: PlayerStatisticsObjectPage
                }
            },
            opaJourney.run
        );
    }
);