/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2022-02-22 Rafal Rudnik             SD-2524 added Insert/Update logic
#  1.4 2022-02-28 Rafal Rudnik             added NumRowsUpdated in procedure output
#----------------------------------------------------------------------------
*/
    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
        /* Initialisation */
            /* Commit transaction */
CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_coupon_type_subgroup_desc_add`(
  COUPON_TYPE_SUBGROUP_ID FLOAT64,  
  COUPON_TYPE_SUBGROUP_DESC STRING,      
  LANG_CD STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE res INT64;
  DECLARE stmt_getQueryId STRING;
  DECLARE num_inserted INT64 DEFAULT 0;
  DECLARE num_updated INT64 DEFAULT 0;

  BEGIN
    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc` 
      WHERE coupon_type_subgroup_id = CAST(@id AS INT64) AND lang_cd = @lang
    """ INTO res USING COUPON_TYPE_SUBGROUP_ID AS id, LANG_CD AS lang;

    IF res > 0 THEN
      /* Apply Update operation */
      EXECUTE IMMEDIATE """
        UPDATE `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc`
        SET 
             coupon_type_subgroup_desc = @desc1 
            ,dwh_updated               = CAST(CURRENT_TIMESTAMP() AS DATETIME)
        WHERE 
            coupon_type_subgroup_id = CAST(@id AS INT64)
        AND lang_cd                 = @lang
      """ USING 
        COUPON_TYPE_SUBGROUP_DESC AS desc1, 
        COUPON_TYPE_SUBGROUP_ID AS id, 
        LANG_CD AS lang;
      
      SET num_updated = @@row_count;
    ELSE
      /* Apply Insert operation */
      EXECUTE IMMEDIATE """
        INSERT INTO `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_desc` 
        (                              
             coupon_type_subgroup_id              
            ,coupon_type_subgroup_desc  
            ,lang_cd
            ,dwh_created                   
            ,dwh_updated                          
        )
        SELECT
             CAST(@id AS INT64) AS coupon_type_subgroup_id
            ,@desc1 AS coupon_type_subgroup_desc
            ,@lang AS lang_cd
            ,CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created
            ,CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated
      """ USING 
        COUPON_TYPE_SUBGROUP_ID AS id, 
        COUPON_TYPE_SUBGROUP_DESC AS desc1, 
        LANG_CD AS lang;
        
      SET num_inserted = @@row_count;
    END IF;

    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
        STRUCT(
            num_inserted AS NumRowsInserted, 
            num_updated AS NumRowsUpdated, 
            stmt_getQueryId AS QueryId, 
            JSON_ARRAY(COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_SUBGROUP_DESC, LANG_CD) AS binds
        )
    );
    
  END;
END;