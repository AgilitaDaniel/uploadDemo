sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'purchaseorderpriceupdate/test/integration/FirstJourney',
		'purchaseorderpriceupdate/test/integration/pages/PurchaseOrderItemsList',
		'purchaseorderpriceupdate/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, PurchaseOrderItemsList, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('purchaseorderpriceupdate') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePurchaseOrderItemsList: PurchaseOrderItemsList,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);