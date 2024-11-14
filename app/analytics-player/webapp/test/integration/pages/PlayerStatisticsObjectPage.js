sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'sig.cap.foosball.app.analyticsplayer',
            componentId: 'PlayerStatisticsObjectPage',
            contextPath: '/PlayerStatistics'
        },
        CustomPageDefinitions
    );
});