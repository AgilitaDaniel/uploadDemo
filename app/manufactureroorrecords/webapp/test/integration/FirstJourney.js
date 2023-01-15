sap.ui.define([
    "sap/ui/test/opaQunit"
], function (opaTest) {
    "use strict";

    var Journey = {
        run: function() {
            QUnit.module("First journey");

            opaTest("Start application", function (Given, When, Then) {
                Given.iStartMyApp();

                Then.onTheManufacturerOORRecordsList.iSeeThisPage();

            });


            opaTest("Navigate to ObjectPage", function (Given, When, Then) {
                // Note: this test will fail if the ListReport page doesn't show any data
                When.onTheManufacturerOORRecordsList.onFilterBar().iExecuteSearch();
                Then.onTheManufacturerOORRecordsList.onTable().iCheckRows();

                When.onTheManufacturerOORRecordsList.onTable().iPressRow(0);
                Then.onTheManufacturerOORRecordsObjectPage.iSeeThisPage();

            });

            opaTest("Teardown", function (Given, When, Then) { 
                // Cleanup
                Given.iTearDownMyApp();
            });
        }
    }

    return Journey;
});