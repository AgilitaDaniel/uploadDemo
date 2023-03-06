using POService as service from '../../srv/po-service';

annotate service.PurchaseOrderItems with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PurchaseOrder.InternalID,
            Label : 'InternalID',
        },
        {
            $Type : 'UI.DataField',
            Label : 'PONumber',
            Value : purchaseOrderNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Pos',
            Value : positionNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'SKU',
            Value : SKU,
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
            Label : 'Description',
        },
        {
            $Type : 'UI.DataField',
            Label : 'Qty',
            Value : quantity,
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : 'Price per Unit',
        },
        {
            $Type : 'UI.DataField',
            Value : Currency,
            Label : 'Currency',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Status_code,
            Label : 'UpdateStatus',
            Criticality : to_Status.criticality,
        },
    ]
);
annotate service.PurchaseOrderItems with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'purchaseOrderNumber',
                Value : purchaseOrderNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Destination_ID',
                Value : Destination_ID,
            },
            {
                $Type : 'UI.DataField',
                Label : 'positionNumber',
                Value : positionNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SKU',
                Value : SKU,
            },
            {
                $Type : 'UI.DataField',
                Label : 'quantity',
                Value : quantity,
            },
            {
                $Type : 'UI.DataField',
                Label : 'quantityUnit',
                Value : quantityUnit,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orderDate',
                Value : orderDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Currency',
                Value : Currency,
            },
            {
                $Type : 'UI.DataField',
                Label : 'price',
                Value : price,
            },
            {
                $Type : 'UI.DataField',
                Label : 'firstReadyDate',
                Value : firstReadyDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ShippingMode',
                Value : ShippingMode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'deliveryDate',
                Value : deliveryDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'sendOrderConfirmation',
                Value : sendOrderConfirmation,
            },
            {
                $Type : 'UI.DataField',
                Label : 'sendDeliveryConfirmation',
                Value : sendDeliveryConfirmation,
            },
            {
                $Type : 'UI.DataField',
                Label : 'invoiceExpected',
                Value : invoiceExpected,
            },
            {
                $Type : 'UI.DataField',
                Label : 'pgiAndServiceConfirmationExpected',
                Value : pgiAndServiceConfirmationExpected,
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
annotate service.PurchaseOrderItems with @(
    UI.SelectionFields : [
        SKU,
        purchaseOrderNumber,
    ]
);
annotate service.PurchaseOrderItems with {
    SKU @Common.Label : 'Material'
};
annotate service.PurchaseOrderItems with {
    purchaseOrderNumber @Common.Label : 'Purchase Order'
};
annotate service.PurchaseOrderItems with {
    to_Status @Common.Text : to_Status.description
};
