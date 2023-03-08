using blaze.pomagic as my from '../db/data-model';

service POService {
    @readonly entity Bikes as projection on my.Bikes;
    @readonly entity PurchaseOrders as projection on my.PurchaseOrders;
    @readonly entity PurchaseOrderItems as projection on my.PurchaseOrderItems;
    @readonly entity Manufacturers as projection on my.Manufacturers;
    @readonly entity Destinations as projection on my.Destinations;
    entity ManufacturerOORRecords as projection on my.ManufacturerOORRecords;
    entity UploadErrorLog as projection on my.UploadErrorLog;
    entity FieldMapping as projection on my.FieldMapping;
    entity Template as projection on my.Template;
    @readonly entity ManufacturerOORRecordComments as projection on my.ManufacturerOORRecordComments;
    entity Uploads as projection on my.Uploads;
    entity MeeInfo as projection on my.MeeInfo;

    annotate PurchaseOrderItems with actions {
        changePrice
    };
    
    // entity UploadedPOs as projection on my.UploadedPOs;

    @cds.persistence.skip
    @odata.singleton
    entity ExcelUpload {
        @Core.MediaType : 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        excel : LargeBinary;
        fileName: String;
    };
}

