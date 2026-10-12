/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-12 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2021-12-22 Pawel Wieczorek          Fix missing id for group, add checking COUPON_TYPE_SUBGROUP_DESC
#  1.4 2021-12-23 Pawel Wieczorek          Skip checking decription for modified record
#  1.5 2022-08-10 Pawel Wieczorek          AP0056182 #266102 Fixing not passing coupon_type_subgroup_desc or active_fg while coupon_type_group_id was modified
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_COUPON_TYPE_SUBGROUP_MOD(
      COUPON_TYPE_SUBGROUP_ID FLOAT,  
      COUPON_TYPE_GROUP_ID FLOAT,  
      COUPON_TYPE_SUBGROUP_DESC VARCHAR,
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
                     sql  : `UPDATE p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_1 
                            SET 
                                 coupon_type_group_id      = COALESCE(:2, t_ref_ldpl_coupon_type_subgroup.coupon_type_group_id)
                                ,coupon_type_subgroup_desc = COALESCE(:3, coupon_type_subgroup_desc)
                                ,active_fg                 = COALESCE(:4, active_fg)
                                ,dwh_updated               = CURRENT_TIMESTAMP
                            WHERE        
                            coupon_type_subgroup_id = :1
                            `
                    ,bind : [COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_GROUP_ID, COUPON_TYPE_SUBGROUP_DESC, ACTIVE_FG]
                 };

    var check_2 = { 
                     sql  : "SELECT 1 FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_1 WHERE coupon_type_subgroup_desc = :1 AND coupon_type_subgroup_id <> :2"
                    ,bind : [COUPON_TYPE_SUBGROUP_DESC, COUPON_TYPE_SUBGROUP_ID] 
                    ,err  : 'Uniqueness violation: COUPON_TYPE_SUBGROUP_DESC: "' + COUPON_TYPE_SUBGROUP_DESC + '" already exist in table T_REF_LDPL_COUPON_TYPE_SUBGROUP_1'
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



