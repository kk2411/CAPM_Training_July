using {mp.soa.db} from '../db/datamodel';


service CatalogService @(
    path    : 'CatalogService',
    requries: 'authenticated-user'
) {


    entity BusinessPartnerSet as projection on db.master.businesspartner;


    entity AddressSet @(restrict: [
        {
            grant: ['READ'],
            to   : 'Viewer',
            where: 'COUNTRY = $user.conditionCountry'
        },
        {
            grant: ['WRITE'],
            to   : 'Admin'
        }
    ])                        as projection on db.master.address;




    entity EmployeeSet        as projection on db.master.employees;


    entity ProductSet         as projection on db.master.product;


    @odata.draft.enabled            : true
    @Common.DefaultValuesFunction   : 'getOrderDefaults'
    entity PurchaseOrderSet   as
        projection on db.transaction.purchaseorder {
            *,
            case
                OVERALL_STATUS
                when 'N'
                     then 'New'
                when 'P'
                     then 'Paid'
                when 'B'
                     then 'Blocked'
                else 'Delivered'
            end as OverallStatus   : String(20),
            case
                LIFECYCLE_STATUS
                when 'N'
                     then 'New'
                when 'I'
                     then 'In Progress'
                when 'C'
                     then 'Not completed'
                else 'Completed'
            end as LifecycleStatus : String(20),
            case
                OVERALL_STATUS
                when 'N'
                     then 0
                when 'P'
                     then 3
                when 'B'
                     then 1
                else 2
            end as OSCriticality   : Integer,
            case
                LIFECYCLE_STATUS
                when 'N'
                     then 3
                when 'I'
                     then 2
                when 'C'
                     then 1
                else 0
            end as LSCriticality   : Integer,
            Items                  : redirected to POItems
        }
        actions {
            @cds.odata.bindingparameter.name: 'ABC'
            @Common.SideEffects             : {TargetProperties: ['ABC/GROSS_AMOUNT']}
            action   discountOnPrice();
            function biggestOrder() returns array of PurchaseOrderSet;
        };


    function getOrderDefaults() returns PurchaseOrderSet;
    entity POItems            as projection on db.transaction.poitems;
}