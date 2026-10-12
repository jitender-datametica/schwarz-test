/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-12 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2021-12-22 Pawel Wieczorek          Add checking FEATURE_GROUP_DESC
#  1.4 2021-12-23 Pawel Wieczorek          Skip checking decription for modified record
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_FEATURE_GROUP_MOD(
      FEATURE_GROUP_ID FLOAT,  
      FEATURE_GROUP_DESC VARCHAR,
      ACTIVE_FG FLOAT
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
                     sql  : `UPDATE p_lew_process_mstr.t_ref_ldpl_feature_group 
                            SET 
                                 feature_group_desc  = :2
                                ,active_fg           = :3 
                                ,dwh_updated         = CURRENT_TIMESTAMP
                            WHERE        
                            feature_group_id         = :1
                            `
                    ,bind : [FEATURE_GROUP_ID, FEATURE_GROUP_DESC, ACTIVE_FG]
                 };
             
    var check_2 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_feature_group WHERE feature_group_desc = :1 AND feature_group_id <> :2"
                    ,bind : [FEATURE_GROUP_DESC, FEATURE_GROUP_ID] 
                    ,err  : 'Uniqueness violation: FEATURE_GROUP_DESC: "' + FEATURE_GROUP_DESC + '" already exist in table T_REF_LDPL_FEATURE_GROUP'
                  };
              
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
    return JSON.stringify({NumRowsUpdated: stmt.getNumRowsUpdated(), QueryId: stmt.getQueryId(), binds: apply.bind});
$$
;



