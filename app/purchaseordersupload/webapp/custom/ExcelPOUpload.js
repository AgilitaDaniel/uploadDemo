sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        Upload: function(oEvent) {
            MessageToast.show("Custom handler invoked.");
        },
        Release: function() {
            MessageToast.show("Custom handler invoked.");
        }
    };
});
