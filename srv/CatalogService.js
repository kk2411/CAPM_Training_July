const { default: cds } = require("@sap/cds");

module.exports = cds.service.impl( async function(){
    // Step - 1 : We have to get the object of our ODATA Entities
    const { EmployeeSet, PurchaseOrderSet } = this.entities;
    // We have 3 generic handlers to perform pre-checks, post-checks, and DB operations
    // this.before() - Pre-checks
    // this.after() - Post-checks
    // this.on() - Database Operations

    // Step - 2 : Define Generic Handlers for the pre-checks/validations
    this.before('UPDATE', EmployeeSet, (req, res) =>{
        console.log("Amount which you wanted to increase", req.data.salaryAmount ) ;
        if(parseFloat(req.data.salaryAmount) >= 120000){
            req.error(500, "Please get the approval from your line account manager");
        }
    });

    this.on('discountOnPrice', async(req, res) =>{
        try {
            const ID = req.params[0].NODE_KEY;
            const tx = cds.tx(req);
            await tx.update(PurchaseOrderSet).with({
                GROSS_AMOUNT : { '-=' : 1000},
                NOTE : "Discounted..!"
            }).where({NODE_KEY: ID});
        } catch (error) {
            return "Error " + error.toString();
        }
    });
    this.on('getOrderDefaults', async req =>{
        return {
            LIFESYCLE_STATUS : 'N',
            OVERALL_STATUS : 'N'
        };
    })
    this.on('biggestOrder', async(req, res) =>{
        try {
            const tx = cds.tx(req);

            const returnData = await tx.read(PurchaseOrderSet).orderBy({
                GROSS_AMOUNT : 'desc'
            }).limit(1);

            return returnData;
        } catch (error) {
            return "Error " + error.toString();
        }
    });
})