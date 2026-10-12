/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-11-29 Rafal Rudnik             SD-2524 Added ADD/MOD Logic
#  1.3 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.4 2022-02-28 Rafal Rudnik             added NumRowsUpdated in procedure output
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_FEATURE_GROUP_DESC_ADD(
      FEATURE_GROUP_ID FLOAT,  
      FEATURE_GROUP_DESC VARCHAR,      
      LANG_CD VARCHAR
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
    var apply ={};
    var check_1 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_feature_group_desc_2 WHERE feature_group_id = :1 AND lang_cd = :2"
                    ,bind : [FEATURE_GROUP_ID, LANG_CD] 
                    ,err  : 'Uniqueness violation: FEATURE_GROUP_ID: ' + FEATURE_GROUP_ID + ' LANG_CD: ' + LANG_CD + ' already exist in table T_REF_LDPL_FEATURE_GROUP_DESC_2'
                 };

    var insertSql = { 
                     sql  : `INSERT INTO p_lew_process_mstr.t_ref_ldpl_feature_group_desc_2 
                            (                              
                                 feature_group_id              
                                ,feature_group_desc  
                                ,lang_cd
                                ,dwh_created                   
                                ,dwh_updated                          
                            )
                            VALUES 
                            (
                                 :1
                                ,:2
                                ,:3
                                ,CURRENT_TIMESTAMP
                                ,CURRENT_TIMESTAMP
                            )`
                    ,bind : [FEATURE_GROUP_ID, FEATURE_GROUP_DESC, LANG_CD]
                 };

    var updateSql = { 
                     sql  : `UPDATE p_lew_process_mstr.t_ref_ldpl_feature_group_desc_2
                            SET 
                                  feature_group_desc = :2 
                                 ,dwh_updated        = CURRENT_TIMESTAMP
                            WHERE 
                                feature_group_id     = :1
                            AND lang_cd              = :3
                            `  
                    ,bind : [FEATURE_GROUP_ID, FEATURE_GROUP_DESC, LANG_CD]
                 };
        
    /* Check Uniqueness 1 */
    res = snowflake.createStatement({sqlText: check_1.sql, binds: check_1.bind.map(fix_null)}).execute();
    if (res.getRowCount() > 0) {
        apply = updateSql;
    }else{
        apply = insertSql;
    }

    /* Apply operation */
    var stmt = snowflake.createStatement({sqlText: apply.sql, binds: apply.bind.map(fix_null)});
    stmt.execute();

    /* Commit transaction */
    snowflake.execute( {sqlText: 'COMMIT WORK;'} );

    /* return number of rows applied and query_id */
    return JSON.stringify({NumRowsInserted: stmt.getNumRowsInserted(), NumRowsUpdated: stmt.getNumRowsUpdated(), QueryId: stmt.getQueryId(), binds: apply.bind});
$$
;

