namespace mp.soa.common;
using { Currency } from '@sap/cds/common';


// Reusable Types
type Guid  : String(32);

type Gender : String(1) enum{
    male = 'M' ;
    female = 'F' ;
    undisclosed = 'U' ;
}

type AmountT : Decimal(10,2)@(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);

aspect Amount : {
    CURRENCY : Currency @(title : '{i18n>CURRENCY}');
    GROSS_AMOUNT : AmountT @(title : '{i18n>GROSS_AMOUNT}');
    NET_AMOUNT : AmountT @(title : '{i18n>NET_AMOUNT}');
    TAX_AMOUNT : AmountT @(title : '{i18n>TAX_AMOUNT}');
}


// Reusable Aspects - Structure - Group of fields
aspect Address {
    street   : Guid;
    landmark : String(40);
    city     : Guid;
    country  : String(2);
}

type phoneNumber : String(30);
type Email : String(255);