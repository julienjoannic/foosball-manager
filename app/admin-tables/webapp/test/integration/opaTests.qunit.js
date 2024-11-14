sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'sig/cap/foosball/app/admintables/test/integration/FirstJourney',
		'sig/cap/foosball/app/admintables/test/integration/pages/TablesList',
		'sig/cap/foosball/app/admintables/test/integration/pages/TablesObjectPage'
    ],
    function(JourneyRunner, opaJourney, TablesList, TablesObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('sig/cap/foosball/app/admintables') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheTablesList: TablesList,
					onTheTablesObjectPage: TablesObjectPage
                }
            },
            opaJourney.run
        );
    }
);