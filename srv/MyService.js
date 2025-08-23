module.exports = cds.service.impl( async function(){
    const { ReadEmployee } = this.entities;
    this.on("READ",ReadEmployee, async(req, res) =>{
        var result = [];
        var whereCondition = req.data;
        console.log(whereCondition);
        if(whereCondition.hasOwnProperty("ID")){
            result = await cds.tx(req).run(SELECT.from(ReadEmployee).limit(10).where(whereCondition));
        } else {
            result = await cds.tx(req).run(SELECT.from(ReadEmployee).limit(1));
        }
    })

})