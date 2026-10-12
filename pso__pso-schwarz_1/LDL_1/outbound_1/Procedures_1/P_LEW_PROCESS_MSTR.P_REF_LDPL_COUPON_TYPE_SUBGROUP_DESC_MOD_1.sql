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


CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_coupon_type_subgroup_desc_mod`(
  COUPON_TYPE_SUBGROUP_ID FLOAT64,
  COUPON_TYPE_SUBGROUP_DESC STRING,
  LANG_CD STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc_1`
      SET 
        coupon_type_subgroup_desc = @desc1,
        dwh_updated               = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE coupon_type_subgroup_id = @id
        AND lang_cd                 = @lang
    """ USING 
      COUPON_TYPE_SUBGROUP_DESC AS desc1, 
      COUPON_TYPE_SUBGROUP_ID AS id, 
      LANG_CD AS lang;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
        STRUCT(
            row_count AS NumRowsUpdated, 
            stmt_getQueryId AS QueryId, 
            JSON_ARRAY(COUPON_TYPE_SUBGROUP_DESC, COUPON_TYPE_SUBGROUP_ID, LANG_CD) AS binds
        )
    );
  EXCEPTION WHEN ERROR THEN
    SET out_param = 'MESSAGE: ' || @@error.message;
    RAISE USING MESSAGE=out_param;
  END;

END;