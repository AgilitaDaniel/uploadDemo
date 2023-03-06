namespace blaze.pomagic;

using {managed, sap.common.CodeList, sap.common.Currencies} from '@sap/cds/common';

entity Manufacturers {
  key CustomerNumber : String(20);
      Name           : String(20);
}

entity Destinations {
  key ID   : String(20);
      Name : String(20);
}

entity Uploads : managed {
  key ID       : UUID @Core.Computed;
      Name     : String(20);
      records  : String;
      fileName : String;
}

entity Bikes {
  key SKU         : String;
      description : String;
      color       : String;
}

@odata.singleton
entity MeeInfo {
  key MeeID   : String;
      MeeName : String;
};

entity ManufacturerOORRecords : managed {
  key ID                : UUID @Core.Computed;
      SKU               : String;
      shortCodePO       : String(6);
      bmcPONumber       : String(30);
      description       : String;
      partSupplierPONumber: String;
      color             : String;
      Manufacturer      : Association to one Manufacturers;
      PurchaseOrder     : Association to one PurchaseOrders
                            on PurchaseOrder.bmcPONumber = bmcPONumber;
      Bike              : Association to one Bikes
                            on Bike.SKU = SKU;
      orderQuantity     : Integer;
      commentUnparsed   : String;
      oorQuantity       : Integer;
      manufacturerETD   : String;
      bmcNewRequestDate : String;
      frameSetETD       : String;
      filename:           String;
      validbmcPO: Boolean;
      validSKU: Boolean;
      validManufacturerETD: Boolean;
      validBmcNewRequestDate: Boolean;
}

entity ManufacturerOORRecordComments : managed {
  key ID           : UUID @Core.Computed;
      vendorString : String;
      date         : String;
}

entity PurchaseOrders {
  key ID           : UUID @Core.Computed;
      InternalID   : String;
      bmcPONumber  : String(30);
      Manufacturer : Association to one Manufacturers;
      Items        : Association to many PurchaseOrderItems
                       on Items.purchaseOrderNumber = bmcPONumber;
      to_Status    : Association to one POStatus;
      Company: String;
      Currency: String;
      billToParty:String;
      BuyingUnit: String;
      Buyer: String;
      IncoTerms: String; 
      IncoTermsLocation: String;
      PaymentTerms: String;

}

entity PurchaseOrderItems {
  key ID                  : UUID @Core.Computed;
      purchaseOrderNumber : String;
      Destination  : Association to one Destinations;
      PurchaseOrder       : Association to one PurchaseOrders
                               on PurchaseOrder.bmcPONumber = purchaseOrderNumber;
      positionNumber      : Integer;
      SKU                 : String;
      Bike                : Association to one Bikes
                              on Bike.SKU = SKU;
      quantity            : Integer;
      quantityUnit: String(4);
      orderDate           : Date;
      Currency: String;
      price: Decimal;
      firstReadyDate: Date;
      ShippingMode: String;
      deliveryDate: Date;
      sendOrderConfirmation: String(2);
      sendDeliveryConfirmation: String(2); //04 oder 02 erlaubt
      invoiceExpected:  String(2);
      pgiAndServiceConfirmationExpected: String(2);
      Description: String;
      to_Status    : Association to one POStatus;
}

entity UploadedPOItems: managed {
  key ID: UUID @Core.Computed;
  bmcPONumber: String;
  
}

entity POStatus : CodeList {
  key code : String enum {
    New     = 'N';
    Uploaded = 'U';
    UploadedWithWarning = 'W';
    Error = 'E';
  } default 'N';
  criticality : Integer; //  2: yellow colour,  3: green colour, 0: unknown
  fieldControl: Integer @odata.Type:'Edm.Byte'; // 1: #ReadOnly, 7: #Mandatory
  createDeleteHidden: Boolean;
  description: String;
  insertDeleteRestriction: Boolean; // = NOT createDeleteHidden
}