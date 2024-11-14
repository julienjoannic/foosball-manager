sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'sig.cap.foosball.app.usergames',
            componentId: 'GamesList',
            contextPath: '/Games'
        },
        CustomPageDefinitions
    );
});