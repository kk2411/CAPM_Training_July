sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'poapplication/test/integration/FirstJourney',
		'poapplication/test/integration/pages/PurchaseOrderSetList',
		'poapplication/test/integration/pages/PurchaseOrderSetObjectPage',
		'poapplication/test/integration/pages/POItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, PurchaseOrderSetList, PurchaseOrderSetObjectPage, POItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('poapplication') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePurchaseOrderSetList: PurchaseOrderSetList,
					onThePurchaseOrderSetObjectPage: PurchaseOrderSetObjectPage,
					onThePOItemsObjectPage: POItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);