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

CREATE OR REPLACE PROCEDURE p_lew_process_mstr.p_ref_ldpl_feature_group_desc_mod(
  FEATURE_GROUP_ID FLOAT64,  
  FEATURE_GROUP_DESC STRING,
  LANG_CD STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE p_lew_process_mstr.t_ref_ldpl_feature_group_desc
      SET 
        feature_group_desc = @FEATURE_GROUP_DESC,
        dwh_updated        = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE 
        feature_group_id = CAST(@FEATURE_GROUP_ID AS INT64)
      AND lang_cd = @LANG_CD
    """ USING 
      FEATURE_GROUP_DESC AS FEATURE_GROUP_DESC, 
      FEATURE_GROUP_ID AS FEATURE_GROUP_ID, 
      LANG_CD AS LANG_CD;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(JSON_OBJECT('NumRowsUpdated', row_count, 'QueryId', stmt_getQueryId, 'binds', JSON_ARRAY(FEATURE_GROUP_DESC, FEATURE_GROUP_ID, LANG_CD)));
  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;