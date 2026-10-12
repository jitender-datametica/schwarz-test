/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_COUPON_TYPE_ADD(
      COUPON_TYPE_ID FLOAT,  
      COUPON_TYPE_SUBGROUP_ID FLOAT,      
      COUPON_TYPE_DESC VARCHAR
)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
    /* Initialisation */
    var res;
    var check_1 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_2 WHERE coupon_type_id = :1"
                    ,bind : [COUPON_TYPE_ID] 
                    ,err  : 'Uniqueness violation: COUPON_TYPE_ID: ' + COUPON_TYPE_ID + ' already exist in table T_REF_LDPL_COUPON_TYPE_2'
                  };

    var check_2 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_2 WHERE coupon_type_desc = :1"
                    ,bind : [COUPON_TYPE_DESC] 
                    ,err  : 'Uniqueness violation: COUPON_TYPE_DESC: "' + COUPON_TYPE_DESC + '" already exist in table T_REF_LDPL_COUPON_TYPE_2'
                  };

    var apply = { 
                     sql  : `INSERT INTO p_lew_process_mstr.t_ref_ldpl_coupon_type_2 
                            (                              
                                 coupon_type_id              
                                ,coupon_type_subgroup_id                                
                                ,coupon_type_desc 
                                ,dwh_created                   
                                ,dwh_updated                          
                            )
                            SELECT
                              :1 AS coupon_type_id
                             ,:2 AS coupon_type_subgroup_id
                             ,:3 AS coupon_type_desc
                             ,CURRENT_TIMESTAMP AS dwh_created
                             ,CURRENT_TIMESTAMP AS dwh_updated  
                           `
                    ,bind : [COUPON_TYPE_ID, COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_DESC]
                 };

    var nextval = { 
                     sql  : 'SELECT COALESCE(MAX(coupon_type_id) + 1, 0) FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_2'
                  };

    /* If value is NULL get next value*/
    if (COUPON_TYPE_ID == undefined) {

        res = snowflake.createStatement({sqlText: nextval.sql}).execute();
        res.next();

        apply.bind[0]   = res.getColumnValue(1); 
        check_1.bind[0] = res.getColumnValue(1); 
    }
        
    /* Check Uniqueness 1 */
    res = snowflake.createStatement({sqlText: check_1.sql, binds: check_1.bind}).execute();
    if (res.getRowCount() > 0) 
        throw new Error(check_1.err);

    /* Check Uniqueness 2 */
    res = snowflake.createStatement({sqlText: check_2.sql, binds: check_2.bind}).execute();
    if (res.getRowCount() > 0) 
        throw new Error(check_2.err);

    /* Apply operation */
    var stmt = snowflake.createStatement({sqlText: apply.sql, binds: apply.bind});
    stmt.execute();

    /* Commit transaction */
    snowflake.execute( {sqlText: 'COMMIT WORK;'} );

    /* return number of rows applied and query_id */
    return JSON.stringify({NumRowsInserted: stmt.getNumRowsInserted(), QueryId: stmt.getQueryId(), binds: apply.bind});
$$
;
