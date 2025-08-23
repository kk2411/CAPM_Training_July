using { mp.soa.db as db  } from '../db/datamodel';

service MyService {

    // Instance based Authorization with readonly capability
    @readonly
    entity ReadEmployee as projection on db.master.employees;

    @insertonly
    entity InsertEmployee as projection on db.master.employees;

    @updateonly
    entity UpdateEmployee as projection on db.master.employees;

    @deleteonly
    entity DeleteEmployee as projection on db.master.employees;

    @Capabilities : { Updatable : false, Deletable : false, Readable : false, Insertable }
    entity UpdateReadEmp as projection on db.master.employees;

}