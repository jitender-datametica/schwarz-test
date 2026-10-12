/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-11-29 Rafal Rudnik             SD-2524 Added ADD/MOD Logic
#  1.3 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.4 2022-02-28 Rafal Rudnik             added NumRowsUpdated in procedure output
#----------------------------------------------------------------------------
*/
    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
        /* Initialisation */
            /* Commit transaction */
CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_feature_group_desc_add`(
  FEATURE_GROUP_ID FLOAT64,  
  FEATURE_GROUP_DESC STRING,      
  LANG_CD STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE res INT64;
  DECLARE stmt_getQueryId STRING;
  DECLARE rows_inserted INT64 DEFAULT 0;
  DECLARE rows_updated INT64 DEFAULT 0;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_feature_group_desc_2` 
      WHERE feature_group_id = CAST(@id AS INT64) AND lang_cd = @lang
    """ INTO res USING FEATURE_GROUP_ID AS id, LANG_CD AS lang;

    IF res > 0 THEN
      /* Apply Update operation */
      EXECUTE IMMEDIATE """
        UPDATE `p_lew_process_mstr.t_ref_ldpl_feature_group_desc_2`
        SET 
             feature_group_desc = @desc1 
            ,dwh_updated        = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE 
            feature_group_id    = @id
        AND lang_cd             = @lang
      """ USING 
        FEATURE_GROUP_DESC AS desc1, 
        FEATURE_GROUP_ID AS id, 
        LANG_CD AS lang;
      
      SET rows_updated = @@row_count;
    ELSE
      /* Apply Insert operation */
      EXECUTE IMMEDIATE """
        INSERT INTO `p_lew_process_mstr.t_ref_ldpl_feature_group_desc_2` 
        (                              
             feature_group_id              
            ,feature_group_desc  
            ,lang_cd
            ,dwh_created                   
            ,dwh_updated                          
        )
        SELECT
             CAST(@id AS INT64) AS feature_group_id
            ,@desc1 AS feature_group_desc1
            ,@lang AS lang_cd
            ,CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created
            ,CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated
      """ USING 
        FEATURE_GROUP_ID AS id, 
        FEATURE_GROUP_DESC AS desc1, 
        LANG_CD AS lang;
        
      SET rows_inserted = @@row_count;
    END IF;

    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
        STRUCT(
            rows_inserted AS NumRowsInserted, 
            rows_updated AS NumRowsUpdated, 
            stmt_getQueryId AS QueryId, 
            JSON_ARRAY(FEATURE_GROUP_ID, FEATURE_GROUP_DESC, LANG_CD) AS binds
        )
    );
    
END;