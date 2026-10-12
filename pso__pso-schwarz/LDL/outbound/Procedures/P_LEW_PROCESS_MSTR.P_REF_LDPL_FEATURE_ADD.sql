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


CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_feature_add`(
  FEATURE_ID FLOAT64,
  FEATURE_SUBGROUP_ID FLOAT64,
  FEATURE_DESC STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE v_feature_id FLOAT64;
  DECLARE res INT64;
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* If value is NULL get next value*/
    IF FEATURE_ID IS NULL THEN
      EXECUTE IMMEDIATE """
        SELECT COALESCE(MAX(feature_id) + 1, 0) 
        FROM `p_lew_process_mstr.t_ref_ldpl_feature`
      """ INTO v_feature_id;
    ELSE
      SET v_feature_id = FEATURE_ID;
    END IF;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature` 
      WHERE feature_id = @id
    """ INTO res USING v_feature_id AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: FEATURE_ID: %f already exist in table T_REF_LDPL_FEATURE""", v_feature_id);
    END IF;

    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature` 
      WHERE feature_desc = @desc1
    """ INTO res USING FEATURE_DESC AS desc1;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: FEATURE_DESC: "%s" already exist in table T_REF_LDPL_FEATURE""", FEATURE_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_process_mstr.t_ref_ldpl_feature` (                              
        feature_id,
        feature_subgroup_id,
        feature_desc,
        dwh_created,
        dwh_updated                          
      )
      SELECT
        CAST(@id AS INT64) AS feature_id,
        CAST(@subgroup_id AS INT64) AS feature_subgroup_id,
        @desc1 AS feature_desc,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated  
    """ USING 
      v_feature_id AS id, 
      FEATURE_SUBGROUP_ID AS subgroup_id, 
      FEATURE_DESC AS desc1;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = FORMAT('{"NumRowsInserted": %d, "QueryId": "%s", "binds": [%f, %f, "%s"]}', row_count, stmt_getQueryId, v_feature_id, FEATURE_SUBGROUP_ID, FEATURE_DESC);

  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;