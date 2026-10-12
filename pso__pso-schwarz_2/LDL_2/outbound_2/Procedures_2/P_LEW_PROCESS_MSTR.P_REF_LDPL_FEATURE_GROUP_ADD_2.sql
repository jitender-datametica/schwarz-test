/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.2 2021-12-22 Pawel Wieczorek          Fix passing nextval
#  1.3 2024-06-12 Marcin Kikola            Added default mapping for loyalty attribute
#----------------------------------------------------------------------------
*/
    /* Commit transaction */
    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
        /* Initialisation */
CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_feature_group_add`(
  FEATURE_GROUP_ID FLOAT64,     
  FEATURE_GROUP_DESC STRING,
  ACTIVE_FG FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE v_feature_group_id FLOAT64;
  DECLARE res INT64;
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* If value is NULL get next value*/
    IF FEATURE_GROUP_ID IS NULL THEN
      EXECUTE IMMEDIATE """
        SELECT COALESCE(MAX(feature_group_id) + 1, 1) 
        FROM `p_lew_process_mstr.t_ref_ldpl_feature_group_2`
      """ INTO v_feature_group_id;
    ELSE
      SET v_feature_group_id = FEATURE_GROUP_ID;
    END IF;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature_group_2` 
      WHERE feature_group_id = @id
    """ INTO res USING v_feature_group_id AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: FEATURE_GROUP_ID: %f already exist in table T_REF_LDPL_FEATURE_GROUP_2""", v_feature_group_id);
    END IF;

    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature_group_2` 
      WHERE feature_group_desc = @desc1
    """ INTO res USING FEATURE_GROUP_DESC AS desc1;

    IF res > 0 THEN
      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: FEATURE_GROUP_DESC: "%s" already exist in table T_REF_LDPL_FEATURE_GROUP_2""", FEATURE_GROUP_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_process_mstr.t_ref_ldpl_feature_group_2` (                              
           feature_group_id                                          
          ,feature_group_desc 
          ,active_fg
          ,loyalty_id
          ,dwh_created                  
          ,dwh_updated                          
      )
      SELECT
        CAST(@id AS INT64) AS feature_group_id,
        @desc1 AS feature_group_desc,
        CAST(@active_fg AS INT64) AS active_fg,
        1,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated  
    """ USING 
      v_feature_group_id AS id, 
      FEATURE_GROUP_DESC AS desc1, 
      ACTIVE_FG AS active_fg;
    
    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = FORMAT('{"NumRowsInserted": %d, "QueryId": "%s", "binds": [%f, "%s", %f]}', row_count, stmt_getQueryId, v_feature_group_id, FEATURE_GROUP_DESC, ACTIVE_FG);

  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE = out_param;
  END;

END;