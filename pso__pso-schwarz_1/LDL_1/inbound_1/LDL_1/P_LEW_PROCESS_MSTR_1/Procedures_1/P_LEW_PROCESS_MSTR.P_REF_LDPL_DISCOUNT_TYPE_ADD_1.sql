/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_DISCOUNT_TYPE_ADD(
      DISCOUNT_TYPE_ID FLOAT,  
      DISCOUNT_TYPE_DESC VARCHAR
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
    var check_1 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_discount_type_1 WHERE discount_type_id = :1"
                    ,bind : [DISCOUNT_TYPE_ID] 
                    ,err  : 'Uniqueness violation: DISCOUNT_TYPE_ID: ' + DISCOUNT_TYPE_ID + ' already exist in table T_REF_LDPL_DISCOUNT_TYPE_1'
                 };

    var check_2 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_discount_type_1 WHERE DISCOUNT_TYPE_DESC = :1"
                    ,bind : [DISCOUNT_TYPE_DESC] 
                    ,err  : 'Uniqueness violation: DISCOUNT_TYPE_DESC: "' + DISCOUNT_TYPE_DESC + '" already exist in table T_REF_LDPL_DISCOUNT_TYPE_1'
                 };

    var apply = { 
                     sql  : `INSERT INTO p_lew_process_mstr.t_ref_ldpl_discount_type_1 
                            (                              
                                 discount_type_id              
                                ,discount_type_desc                                              
                                ,dwh_created                   
                                ,dwh_updated                          
                            )
                            VALUES 
                            (
                                 :1
                                ,:2
                                ,CURRENT_TIMESTAMP
                                ,CURRENT_TIMESTAMP
                            )`
                    ,bind : [DISCOUNT_TYPE_ID, DISCOUNT_TYPE_DESC]
                 };

    var nextval = { 
                     sql  : 'SELECT COALESCE(MAX(discount_type_id) + 1, 0) FROM p_lew_process_mstr.t_ref_ldpl_discount_type_1'
                  };

    /* If value is NULL get next value*/
    if (DISCOUNT_TYPE_ID == undefined) {

        res = snowflake.createStatement({sqlText: nextval.sql}).execute();
        res.next();

        apply.bind[0]   = res.getColumnValue(1); 
        check_1.bind[0] = res.getColumnValue(1); 
    }
        
    /* Check Uniqueness 1 */
    res = snowflake.createStatement({sqlText: check_1.sql, binds: check_1.bind.map(fix_null)}).execute();
    if (res.getRowCount() > 0) 
        throw new Error(check_1.err);

    /* Check Uniqueness 2 */
    res = snowflake.createStatement({sqlText: check_2.sql, binds: check_2.bind.map(fix_null)}).execute();
    if (res.getRowCount() > 0) 
        throw new Error(check_2.err);

    /* Apply operation */
    var stmt = snowflake.createStatement({sqlText: apply.sql, binds: apply.bind.map(fix_null)});
    stmt.execute();

    /* Commit transaction */
    snowflake.execute( {sqlText: 'COMMIT WORK;'} );

    /* return number of rows applied and query_id */
    return JSON.stringify({NumRowsInserted: stmt.getNumRowsInserted(), QueryId: stmt.getQueryId(), binds: apply.bind});
$$
;
