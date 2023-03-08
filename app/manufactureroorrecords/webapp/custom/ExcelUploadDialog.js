sap.ui.define([
    "sap/m/MessageToast",
    "sap/m/MessageBox"
], function (MessageToast,
	MessageBox) {
    'use strict';
    function _createUploadController(oExtensionAPI, Entity) {
        var oUploadDialog;

        function setOkButtonEnabled(bOk) {
            oUploadDialog && oUploadDialog.getBeginButton().setEnabled(bOk);
        }

        function setDialogBusy(bBusy) {
            oUploadDialog.setBusy(bBusy)
        }

        function closeDialog() {
            oUploadDialog && oUploadDialog.close()
        }

        function showError(code, target, sMessage) {
            MessageBox.error("Upload failed", { title: "Error" })
        }

        function byId(sId) {
            return sap.ui.core.Fragment.byId("excelUploadDialog", sId);
        }

        return {
            onBeforeOpen: function (oEvent) {
                oUploadDialog = oEvent.getSource();
                oExtensionAPI.addDependent(oUploadDialog);
            },

            onAfterClose: function (oEvent) {
                oExtensionAPI.removeDependent(oUploadDialog);
                oUploadDialog.destroy();
                oUploadDialog = undefined;
            },

            onOk: function (oEvent) {
                setDialogBusy(true)
                const oSelectedKey = byId("idTemplateSelect").getSelectedKey()

                var oFileUploader = byId("uploader");
                var headPar = new sap.ui.unified.FileUploaderParameter();
                headPar.setName('slug');
                headPar.setValue(Entity);
                oFileUploader.removeHeaderParameter('slug');
                oFileUploader.addHeaderParameter(headPar);
                var headPar2 = new sap.ui.unified.FileUploaderParameter();
                headPar2.setName('filename');
                headPar2.setValue("textsf.xlsx");
                oFileUploader.addHeaderParameter(headPar2)
                var sUploadUri = oExtensionAPI._controller.extensionAPI._controller._oAppComponent.getManifestObject().resolveUri("/po/ExcelUpload/excel")
                oFileUploader.setUploadUrl(sUploadUri);
                oFileUploader.setName('testssf')
                oFileUploader
                    .checkFileReadable()
                    .then(function () {
                        oFileUploader.upload();
                    })
                    .catch(function (error) {
                        showError("The file cannot be read.");
                        setDialogBusy(false)
                    })
            },

            onCancel: function (oEvent) {
                closeDialog();
            },

            onTypeMismatch: function (oEvent) {
                var sSupportedFileTypes = oEvent
                    .getSource()
                    .getFileType()
                    .map(function (sFileType) {
                        return "*." + sFileType;
                    })
                    .join(", ");

                showError(
                    "The file type *." +
                    oEvent.getParameter("fileType") +
                    " is not supported. Choose one of the following types: " +
                    sSupportedFileTypes
                );
            },

            onFileAllowed: function (oEvent) {
                setOkButtonEnabled(true)
            },

            onFileEmpty: function (oEvent) {
                setOkButtonEnabled(false)
            },

            onUploadComplete: function (oEvent) {
                var iStatus = oEvent.getParameter("status");
                var oFileUploader = oEvent.getSource()

                oFileUploader.clear();
                setOkButtonEnabled(false)
                setDialogBusy(false)

                if (iStatus >= 400) {
                    var oRawResponse;
                    try {
                        oRawResponse = JSON.parse(oEvent.getParameter("responseRaw"));
                    } catch (e) {
                        oRawResponse = oEvent.getParameter("responseRaw");
                    }
                    if (oRawResponse && oRawResponse.error && oRawResponse.error.message) {
                        showError(oRawResponse.error.code, oRawResponse.error.target, oRawResponse && oRawResponse.error && oRawResponse.error.message);
                    }
                } else {
                    MessageToast.show("File uploaded successfully");
                    oExtensionAPI.refresh()
                    closeDialog();
                }
            }
        };
    };

    function _ErrorLogController(oExtensionAPI, Entity) {
        var oErrorDialog
        return{
            onBeforeOpen: function (oEvent) {
                oErrorDialog = oEvent.getSource();
                oExtensionAPI.addDependent(oErrorDialog);
            },

            onAfterClose: function (oEvent) {
                oExtensionAPI.removeDependent(oErrorDialog);
                oErrorDialog.destroy();
                oErrorDialog = undefined;
            },

            onCloseDialog: function(){
                oErrorDialog.close()
            }
        }
    };

    return {
        Upload: function (oBindingContext, aSelectedContexts) {
            this.loadFragment({
                id: "excelUploadDialog",
                name: "manufactureroorrecords.custom.ExcelUploadDialog",
                controller: _createUploadController(this, "ManufacturerOORRecords")
            }).then(function (oDialog) {
                oDialog.open();
            });
        },

        showErrorLog: function() {
            this.loadFragment({
                id: "errorLogList",
                name: "manufactureroorrecords.custom.ErrorLogFragment",
                controller: _ErrorLogController(this, "ManufacturerOORRecords")
            }).then(function (oDialog) {
                oDialog.open();
            });
        },
        postRecords: async function() {
            MessageBox.warning("You have Errors in your Log, these Entries will not get Posted. Do you want to Post?", {
                actions: ["Post", "Cancel"],
                onClose: sAction => {
                    if(sAction === "Post"){
                        MessageToast.show("Data Succesfully posted");
                    } 
                }
            })
        }
    };
});
