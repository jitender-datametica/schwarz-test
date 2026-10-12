/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-12 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_FEATURE_SUBGROUP_ADD(
      FEATURE_SUBGROUP_ID FLOAT, 
      FEATURE_GROUP_ID FLOAT, 
      FEATURE_SUBGROUP_DESC VARCHAR,
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
    var check_1 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_feature_subgroup WHERE feature_subgroup_id = :1"
                    ,bind : [FEATURE_SUBGROUP_ID] 
                    ,err  : 'Uniqueness violation: FEATURE_SUBGROUP_ID: ' + FEATURE_SUBGROUP_ID + ' already exist in table T_REF_LDPL_FEATURE_SUBGROUP'
                  };

    var check_2 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_feature_subgroup WHERE feature_subgroup_desc = :1"
                    ,bind : [FEATURE_SUBGROUP_DESC] 
                    ,err  : 'Uniqueness violation: FEATURE_SUBGROUP_DESC: "' + FEATURE_SUBGROUP_DESC + '" already exist in table T_REF_LDPL_FEATURE_SUBGROUP'
                  };

    var apply = { 
                     sql  : `INSERT INTO p_lew_process_mstr.t_ref_ldpl_feature_subgroup 
                            (                              
                                 feature_subgroup_id 
                                ,feature_group_id
                                ,feature_subgroup_desc 
                                ,active_fg
                                ,dwh_created                   
                                ,dwh_updated                          
                            )
                            SELECT
                              :1 AS feature_subgroup_id
                             ,:2 AS feature_group_id
                             ,:3 AS feature_subgroup_desc
                             ,:4 AS active_fg
                             ,CURRENT_TIMESTAMP AS dwh_created
                             ,CURRENT_TIMESTAMP AS dwh_updated  
                           `
                    ,bind : [FEATURE_SUBGROUP_ID, FEATURE_GROUP_ID, FEATURE_SUBGROUP_DESC, ACTIVE_FG]
                 };

    var nextval = { 
                     sql  : 'SELECT COALESCE(MAX(feature_subgroup_id) + 1, 1) FROM p_lew_process_mstr.t_ref_ldpl_feature_subgroup'
                  };

    /* If value is NULL get next value*/
    if (FEATURE_SUBGROUP_ID == undefined) {

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

