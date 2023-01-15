namespace blaze.pomagic;

using {managed} from '@sap/cds/common';

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
      Destination  : Association to one Destinations;
      Items        : Association to many PurchaseOrderItems
                       on Items.purchaseOrderNumber = InternalID;
}

entity PurchaseOrderItems {
  key ID                  : UUID @Core.Computed;
      purchaseOrderNumber : String;
      PurchaseOrder       : Association to one PurchaseOrders
                               on PurchaseOrder.InternalID = purchaseOrderNumber;
      positionNumber      : Integer;
      SKU                 : String;
      Bike                : Association to one Bikes
                              on Bike.SKU = SKU;
      quantity            : Integer;
      orderDate           : Date;
}

entity UploadedPOItems: managed {
  key ID: UUID @Core.Computed;
  bmcPONumber: String;
  
}
