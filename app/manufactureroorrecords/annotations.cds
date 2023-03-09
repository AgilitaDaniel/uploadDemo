using POService as service from '../../srv/po-service';

annotate service.ManufacturerOORRecords with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'SKU',
            Value : SKU,
        },
        {
            $Type : 'UI.DataField',
            Label : 'shortCodePO',
            Value : shortCodePO,
        },
        {
            $Type : 'UI.DataField',
            Label : 'bmcPONumber',
            Value : bmcPONumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'description',
            Value : description,
        },
        {
            $Type : 'UI.DataField',
            Label : 'color',
            Value : color,
        },
    ]
);
annotate service.ManufacturerOORRecords with @(
    Capabilities.DeleteRestrictions : {
        Deletable : false,
    },
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'SKU',
                Value : SKU,
            },
            {
                $Type : 'UI.DataField',
                Label : 'shortCodePO',
                Value : shortCodePO,
            },
            {
                $Type : 'UI.DataField',
                Label : 'bmcPONumber',
                Value : bmcPONumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'description',
                Value : description,
            },
            {
                $Type : 'UI.DataField',
                Label : 'color',
                Value : color,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Manufacturer_CustomerNumber',
                Value : Manufacturer_CustomerNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orderQuantity',
                Value : orderQuantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'oorQuantity',
                Value : oorQuantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'manufacturerETD',
                Value : manufacturerETD,
            },
            {
                $Type : 'UI.DataField',
                Label : 'bmcNewRequestDate',
                Value : bmcNewRequestDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'frameSetETD',
                Value : frameSetETD,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);

// annotate service.ManufacturerOORRecords with actions {
//     UploadExcel @(
//         Core.OperationAvailable : false
//     );
// } ;

