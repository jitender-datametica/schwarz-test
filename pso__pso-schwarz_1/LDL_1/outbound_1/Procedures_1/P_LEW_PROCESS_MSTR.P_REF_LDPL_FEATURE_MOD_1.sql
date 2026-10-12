/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-08 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-10-19 Pawel Wieczorek          SD-2524 FEATURE_DESC not editable 
#  1.2 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.3 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_process_mstr.p_ref_ldpl_feature_mod(
  FEATURE_ID FLOAT64,  
  FEATURE_SUBGROUP_ID FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE p_lew_process_mstr.t_ref_ldpl_feature_1 
      SET 
        feature_subgroup_id = CAST(@FEATURE_SUBGROUP_ID AS INT64),
        dwh_updated         = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE        
        feature_id = CAST(@FEATURE_ID AS INT64)
    """ USING 
      FEATURE_SUBGROUP_ID AS FEATURE_SUBGROUP_ID, 
      FEATURE_ID AS FEATURE_ID;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = FORMAT('{"NumRowsUpdated": %d, "QueryId": "%s", "binds": [%f, %f]}', row_count, stmt_getQueryId, FEATURE_ID, FEATURE_SUBGROUP_ID);

  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;