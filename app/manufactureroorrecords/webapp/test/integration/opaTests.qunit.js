sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'manufactureroorrecords/test/integration/FirstJourney',
		'manufactureroorrecords/test/integration/pages/ManufacturerOORRecordsList',
		'manufactureroorrecords/test/integration/pages/ManufacturerOORRecordsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ManufacturerOORRecordsList, ManufacturerOORRecordsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('manufactureroorrecords') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheManufacturerOORRecordsList: ManufacturerOORRecordsList,
					onTheManufacturerOORRecordsObjectPage: ManufacturerOORRecordsObjectPage
                }
            },
            opaJourney.run
        );
    }
);