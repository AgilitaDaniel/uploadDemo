sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'purchaseordersupload/test/integration/FirstJourney',
		'purchaseordersupload/test/integration/pages/PurchaseOrdersList',
		'purchaseordersupload/test/integration/pages/PurchaseOrdersObjectPage',
		'purchaseordersupload/test/integration/pages/PurchaseOrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, PurchaseOrdersList, PurchaseOrdersObjectPage, PurchaseOrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('purchaseordersupload') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePurchaseOrdersList: PurchaseOrdersList,
					onThePurchaseOrdersObjectPage: PurchaseOrdersObjectPage,
					onThePurchaseOrderItemsObjectPage: PurchaseOrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);