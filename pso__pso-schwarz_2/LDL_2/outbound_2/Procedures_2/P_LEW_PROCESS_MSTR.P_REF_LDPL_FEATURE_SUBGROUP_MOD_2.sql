/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-12 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-02 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2021-12-22 Pawel Wieczorek          Fix missing id for group
#  1.3 2021-12-22 Pawel Wieczorek          Add checking FEATURE_SUBGROUP_DESC
#  1.4 2021-12-23 Pawel Wieczorek          Skip checking decription for modified record
#  1.5 2022-08-10 Pawel Wieczorek          AP0056182 #266102 similar situaltion as in the p_ref_ldpl_coupon_type_subgroup_mod
#
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_feature_subgroup_mod`(
  FEATURE_SUBGROUP_ID FLOAT64,
  FEATURE_GROUP_ID FLOAT64,
  FEATURE_SUBGROUP_DESC STRING,
  ACTIVE_FG FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE res INT64;
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature_subgroup_2` 
      WHERE feature_subgroup_desc = @desc1 
        AND feature_subgroup_id <> @id
    """ INTO res USING 
      FEATURE_SUBGROUP_DESC AS desc1, 
      FEATURE_SUBGROUP_ID AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: FEATURE_SUBGROUP_DESC: "%s" already exist in table T_REF_LDPL_FEATURE_SUBGROUP_2""", FEATURE_SUBGROUP_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_process_mstr.t_ref_ldpl_feature_subgroup_2` 
      SET 
        feature_group_id      = COALESCE(@group_id, feature_group_id),
        feature_subgroup_desc = COALESCE(@desc1, feature_subgroup_desc),
        active_fg             = COALESCE(@active_fg, active_fg),
        dwh_updated           = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE feature_subgroup_id = @id
    """ USING 
      CAST(FEATURE_GROUP_ID AS INT64) AS group_id, 
      FEATURE_SUBGROUP_DESC AS desc1, 
      CAST(ACTIVE_FG AS INT64) AS active_fg, 
      FEATURE_SUBGROUP_ID AS id;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
        STRUCT(
            row_count AS NumRowsUpdated, 
            stmt_getQueryId AS QueryId, 
            JSON_ARRAY(FEATURE_SUBGROUP_ID, FEATURE_GROUP_ID, FEATURE_SUBGROUP_DESC, ACTIVE_FG) AS binds
        )
    );

  EXCEPTION WHEN ERROR THEN
    SET out_param = out_param = 'MESSAGE: ' || @@error.message;
    RAISE USING MESSAGE=out_param;
  END;

END;