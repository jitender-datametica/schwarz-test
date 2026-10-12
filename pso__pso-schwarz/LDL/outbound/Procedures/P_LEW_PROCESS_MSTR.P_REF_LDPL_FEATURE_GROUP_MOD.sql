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


CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_feature_group_mod`(
  FEATURE_GROUP_ID FLOAT64,
  FEATURE_GROUP_DESC STRING,
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
      FROM `p_lew_process_mstr.t_ref_ldpl_feature_group` 
      WHERE feature_group_desc = @desc1 
        AND feature_group_id <> @id
    """ INTO res USING 
      FEATURE_GROUP_DESC AS desc1, 
      FEATURE_GROUP_ID AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: FEATURE_GROUP_DESC: "%s" already exist in table T_REF_LDPL_FEATURE_GROUP""", FEATURE_GROUP_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_process_mstr.t_ref_ldpl_feature_group` 
      SET 
        feature_group_desc = @desc1,
        active_fg          = @active_fg, 
        dwh_updated        = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE feature_group_id = @id
    """ USING 
      FEATURE_GROUP_DESC AS desc1, 
      ACTIVE_FG AS active_fg, 
      FEATURE_GROUP_ID AS id;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
   SET out_param = TO_JSON_STRING(JSON_OBJECT('NumRowsUpdated', row_count, 'QueryId', stmt_getQueryId, 'binds', JSON_ARRAY(FEATURE_GROUP_ID, FEATURE_GROUP_DESC, ACTIVE_FG)));
  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;