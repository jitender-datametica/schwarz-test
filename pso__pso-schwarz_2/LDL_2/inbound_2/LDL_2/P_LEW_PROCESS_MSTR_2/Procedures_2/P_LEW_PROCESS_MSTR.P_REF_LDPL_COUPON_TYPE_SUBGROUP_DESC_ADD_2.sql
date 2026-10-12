/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2022-02-22 Rafal Rudnik             SD-2524 added Insert/Update logic
#  1.4 2022-02-28 Rafal Rudnik             added NumRowsUpdated in procedure output
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_COUPON_TYPE_SUBGROUP_DESC_ADD(
      COUPON_TYPE_SUBGROUP_ID FLOAT,  
      COUPON_TYPE_SUBGROUP_DESC VARCHAR,      
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
    var check_1 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc_2 WHERE coupon_type_subgroup_id = :1 AND lang_cd = :2"
                    ,bind : [COUPON_TYPE_SUBGROUP_ID, LANG_CD] 
                    ,err  : 'Uniqueness violation: COUPON_TYPE_SUBGROUP_ID: ' + COUPON_TYPE_SUBGROUP_ID + ' LANG_CD: ' + LANG_CD + ' already exist in table T_REF_LDPL_COUPON_TYPE_SUBGROUP_DESC_2'
                 };

    var sql_insert = { 
                     sql  : `INSERT INTO p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc_2 
                            (                              
                                 coupon_type_subgroup_id              
                                ,coupon_type_subgroup_desc  
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
                    ,bind : [COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_SUBGROUP_DESC, LANG_CD]
                 };

    var sql_update = { 
                     sql  : `UPDATE p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc_2
                            SET 
                                  coupon_type_subgroup_desc = :2 
                                 ,dwh_updated               = CURRENT_TIMESTAMP
                            WHERE 
                                coupon_type_subgroup_id = :1
                            AND lang_cd                 = :3
                            `  
                    ,bind : [COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_SUBGROUP_DESC, LANG_CD]
                 };
        
    /* Check Uniqueness 1 */
    res = snowflake.createStatement({sqlText: check_1.sql, binds: check_1.bind.map(fix_null)}).execute();
    if (res.getRowCount() > 0) {
        apply = sql_update;
    }else{
        apply = sql_insert;
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

