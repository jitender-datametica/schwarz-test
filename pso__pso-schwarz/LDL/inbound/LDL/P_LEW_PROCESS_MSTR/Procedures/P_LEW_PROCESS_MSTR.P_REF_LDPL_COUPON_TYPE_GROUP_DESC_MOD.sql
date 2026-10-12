/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_COUPON_TYPE_GROUP_DESC_MOD(
      COUPON_TYPE_GROUP_ID FLOAT,  
      COUPON_TYPE_GROUP_DESC VARCHAR,
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
    var apply = { 
                     sql  : `UPDATE p_lew_process_mstr.t_ref_ldpl_coupon_type_group_desc
                            SET 
                                  coupon_type_group_desc = :1 
                                 ,dwh_updated            = CURRENT_TIMESTAMP
                            WHERE 
                                coupon_type_group_id = :2
                            AND lang_cd              = :3
                            `  
                    ,bind : [COUPON_TYPE_GROUP_DESC, COUPON_TYPE_GROUP_ID, LANG_CD]
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
