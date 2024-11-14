sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'sig.cap.foosball.app.adminseasons',
            componentId: 'SeasonsList',
            contextPath: '/Seasons'
        },
        CustomPageDefinitions
    );
});