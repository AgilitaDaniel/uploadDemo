using POService as service from '../../srv/po-service';

annotate service.PurchaseOrders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : bmcPONumber,
            Label : '{i18n>Ponumber}',
        },
        {
            $Type : 'UI.DataField',
            Value : Manufacturer_CustomerNumber,
            Label : '{i18n>Suppliernumber}',
        },
        {
            $Type : 'UI.DataField',
            Value : Currency,
            Label : '{i18n>Currency}',
        },
        {
            $Type : 'UI.DataField',
            Value : Company,
            Label : '{i18n>Company}',
        },
        {
            $Type : 'UI.DataField',
            Value : BuyingUnit,
            Label : '{i18n>Buyingunit}',
        },
        {
            $Type : 'UI.DataField',
            Value : Buyer,
            Label : '{i18n>Buyer}',
        },
        {
            $Type : 'UI.DataField',
            Value : billToParty,
            Label : '{i18n>Billtoparty}',
        },
        {
            $Type : 'UI.DataField',
            Value : IncoTerms,
            Label : '{i18n>Incoterms}',
        },
        {
            $Type : 'UI.DataField',
            Value : IncoTermsLocation,
            Label : '{i18n>Incotermslocation}',
        },
        {
            $Type : 'UI.DataField',
            Value : PaymentTerms,
            Label : '{i18n>Paymentterms}',
        },
        {
            $Type : 'UI.DataField',
            Value : to_Status_code,
            Label : '{i18n>Tostatuscode}',
            Criticality : to_Status.criticality,
        },
    ]
);
annotate service.PurchaseOrders with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Items}',
            ID : 'i18nItems',
            Target : 'Items/@UI.LineItem#i18nItems',
        },
    ]
);
annotate service.PurchaseOrderItems with @(
    UI.LineItem #i18nItems : [
        {
            $Type : 'UI.DataField',
            Value : SKU,
            Label : '{i18n>Sku}',
        },
        {
            $Type : 'UI.DataField',
            Value : quantity,
            Label : '{i18n>Quantity}',
        },
        {
            $Type : 'UI.DataField',
            Value : quantityUnit,
            Label : '{i18n>Quantityunit}',
        },
        {
            $Type : 'UI.DataField',
            Value : price,
            Label : '{i18n>Price}',
        },
        {
            $Type : 'UI.DataField',
            Value : Currency,
            Label : '{i18n>Currency}',
        },
        {
            $Type : 'UI.DataField',
            Value : firstReadyDate,
            Label : '{i18n>Firstreadydate}',
        },{
            $Type : 'UI.DataField',
            Value : deliveryDate,
            Label : '{i18n>Deliverydate}',
        },
        {
            $Type : 'UI.DataField',
            Value : ShippingMode,
            Label : '{i18n>Shippingmode}',
        },
        {
            $Type : 'UI.DataField',
            Value : sendOrderConfirmation,
            Label : '{i18n>Sendorderconfirmation}',
        },
        {
            $Type : 'UI.DataField',
            Value : pgiAndServiceConfirmationExpected,
            Label : '{i18n>Pgiandserviceconfirmationexpected}',
        },
        {
            $Type : 'UI.DataField',
            Value : invoiceExpected,
            Label : '{i18n>Invoiceexpected}',
        },
        {
            $Type : 'UI.DataField',
            Value : Destination_ID,
            Label : '{i18n>Destinationid}',
        },]
);
annotate service.PurchaseOrders with @(
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Purchaseorder}',
            ID : 'i18nPurchaseorder',
            Target : '@UI.FieldGroup#i18nPurchaseorder',
        },
    ],
    UI.FieldGroup #i18nPurchaseorder : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : bmcPONumber,
                Label : 'bmcPONumber',
            },{
                $Type : 'UI.DataField',
                Value : Manufacturer_CustomerNumber,
                Label : 'Manufacturer_CustomerNumber',
            },
            {
                $Type : 'UI.DataField',
                Value : to_Status_code,
                Label : 'to_Status_code',
            },],
    }
);
annotate service.PurchaseOrders with @(
    UI.HeaderInfo : {
        TypeName : '{i18n>Purchaseorderupload}',
        TypeNamePlural : '{i18n>Purchaseorderuploads}',
    }
);
annotate service.PurchaseOrders with {
    to_Status @Common.Text : to_Status.description
};
