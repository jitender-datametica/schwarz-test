/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-08 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2021-12-22 Pawel Wieczorek          Add checking COUPON_TYPE_DESC
#  1.4 2021-12-23 Pawel Wieczorek          Skip checking decription for modified record
#                                          Add missing fix_null
#  1.5 2022-02-24 Rafal Rudnik             removed parameter COUPON_TYPE_DESC and 
#                                          check logic for it.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_COUPON_TYPE_MOD(
      COUPON_TYPE_ID FLOAT,  
      COUPON_TYPE_SUBGROUP_ID FLOAT
)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$

    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
    function fix_null(x) {
        return x === undefined ? null : x;
    }

    /* Initialisation */
    var res;
    
    var apply = { 
                     sql  : `UPDATE p_lew_process_mstr.t_ref_ldpl_coupon_type 
                            SET 
                                 coupon_type_subgroup_id = :2
                                ,dwh_updated             = CURRENT_TIMESTAMP
                            WHERE        
                            coupon_type_id = :1
                            `
                    ,bind : [COUPON_TYPE_ID, COUPON_TYPE_SUBGROUP_ID]
                 };        
              
    /* Apply operation */
    var stmt = snowflake.createStatement({sqlText: apply.sql, binds: apply.bind.map(fix_null)});
    stmt.execute();

    /* Commit transaction */
    snowflake.execute( {sqlText: 'COMMIT WORK;'} );

    /* return number of rows applied and query_id */
    return JSON.stringify({NumRowsUpdated: stmt.getNumRowsUpdated(), QueryId: stmt.getQueryId(), binds: apply.bind});
$$
;



