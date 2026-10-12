/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-02 Rafal Rudnik             SD-2524 Adding ADD/MOD logic
#  1.3 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.4 2022-02-28 Rafal Rudnik             added NumRowsUpdated in procedure output
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_feature_subgroup_desc_add`(
  FEATURE_SUBGROUP_ID FLOAT64,
  FEATURE_SUBGROUP_DESC STRING,
  LANG_CD STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE res INT64;
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;
  DECLARE num_inserted INT64 DEFAULT 0;
  DECLARE num_updated INT64 DEFAULT 0;

  BEGIN
    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature_subgroup_desc_1` 
      WHERE feature_subgroup_id = @id 
        AND lang_cd = @lang
    """ INTO res USING 
      CAST(FEATURE_SUBGROUP_ID AS INT64) AS id, 
      LANG_CD AS lang;

    IF res > 0 THEN
      /* Apply operation: Update */
      EXECUTE IMMEDIATE """
        UPDATE `p_lew_process_mstr.t_ref_ldpl_feature_subgroup_desc_1`
        SET 
          feature_subgroup_desc = @desc1,
          dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE feature_subgroup_id = @id
          AND lang_cd = @lang
      """ USING 
        FEATURE_SUBGROUP_DESC AS desc1, 
        FEATURE_SUBGROUP_ID AS id, 
        LANG_CD AS lang;
        
      SET row_count = @@row_count;
      SET num_updated = row_count;
    ELSE
      /* Apply operation: Insert */
      EXECUTE IMMEDIATE """
        INSERT INTO `p_lew_process_mstr.t_ref_ldpl_feature_subgroup_desc_1` (                              
          feature_subgroup_id,
          feature_subgroup_desc,
          lang_cd,
          dwh_created,
          dwh_updated                          
        )
        VALUES (
          CAST(@id AS INT64),
          @desc1,
          @lang,
          CAST(CURRENT_TIMESTAMP() AS DATETIME),
          CAST(CURRENT_TIMESTAMP() AS DATETIME)
        )
      """ USING 
        FEATURE_SUBGROUP_ID AS id, 
        FEATURE_SUBGROUP_DESC AS desc1, 
        LANG_CD AS lang;
        
      SET row_count = @@row_count;
      SET num_inserted = row_count;
    END IF;

    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
  JSON_OBJECT(
    'NumRowsInserted', num_inserted,
    'NumRowsUpdated', num_updated,
    'QueryId', stmt_getQueryId,
    'binds', JSON_ARRAY(FEATURE_SUBGROUP_ID, FEATURE_SUBGROUP_DESC, LANG_CD)
  )
);

  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;