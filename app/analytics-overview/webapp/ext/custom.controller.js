sap.ui.define([
        "sap/ui/core/mvc/ControllerExtension",
        "sap/suite/ui/generic/template/extensionAPI/extensionAPI",
        "sap/ui/model/odata/v4/ODataModel"
    ],
    function (ControllerExtension, ExtensionAPI, ODataModel) {
        "use strict";
        
        return {
            onBeforeRendering: async function() {
                console.log("onBeforeRendering");

                const oGlobalFilter = this.getView().byId("ovpGlobalMacroFilter");

                var oModel = new ODataModel({
                    serviceUrl : "/odata/v4/analytics/"
                });

                // Connected played
                var oFunction = oModel.bindContext("/GetConnectedPlayer(...)");
                await oFunction.invoke();
                var oContext = oFunction.getBoundContext();
                var object = oContext.getObject();

                if (object) {
                    oGlobalFilter.setFilterValues("PlayerName", "EQ", object.Name);
                }

                // Current season
                oFunction = oModel.bindContext("/GetCurrentSeason(...)");
                await oFunction.invoke();
                oContext = oFunction.getBoundContext();
                object = oContext.getObject();

                if (object) {
                    oGlobalFilter.setFilterValues("SeasonDescription", "EQ", object.Description);
                }
            }
        }
    }
);