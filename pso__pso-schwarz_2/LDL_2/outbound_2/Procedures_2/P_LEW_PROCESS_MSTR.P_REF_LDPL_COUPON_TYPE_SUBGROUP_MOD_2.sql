/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-12 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2021-12-22 Pawel Wieczorek          Fix missing id for group, add checking COUPON_TYPE_SUBGROUP_DESC
#  1.4 2021-12-23 Pawel Wieczorek          Skip checking decription for modified record
#  1.5 2022-08-10 Pawel Wieczorek          AP0056182 #266102 Fixing not passing coupon_type_subgroup_desc or active_fg while coupon_type_group_id was modified
#
#----------------------------------------------------------------------------
*/
    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
        /* Initialisation */
            /* Commit transaction */

CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_coupon_type_subgroup_mod`(
  COUPON_TYPE_SUBGROUP_ID FLOAT64,  
  COUPON_TYPE_GROUP_ID FLOAT64,  
  COUPON_TYPE_SUBGROUP_DESC STRING,
  ACTIVE_FG FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE res INT64;
  DECLARE stmt_getQueryId STRING;
  DECLARE num_updated INT64 DEFAULT 0;

  BEGIN
    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_2` 
      WHERE coupon_type_subgroup_desc = @desc1 AND coupon_type_subgroup_id <> CAST(@id AS INT64)
    """ INTO res USING COUPON_TYPE_SUBGROUP_DESC AS desc1, COUPON_TYPE_SUBGROUP_ID AS id;

    IF res > 0 THEN

      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: COUPON_TYPE_SUBGROUP_DESC: "%s" already exist in table T_REF_LDPL_COUPON_TYPE_SUBGROUP_2""", COUPON_TYPE_SUBGROUP_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_2` 
      SET 
           coupon_type_group_id      = COALESCE(CAST(@group_id AS INT64), coupon_type_group_id)
          ,coupon_type_subgroup_desc = COALESCE(@desc1, coupon_type_subgroup_desc)
          ,active_fg                 = COALESCE(CAST(@active_fg AS INT64), active_fg)
          ,dwh_updated               = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE        
          coupon_type_subgroup_id = @id
    """ USING 
      COUPON_TYPE_GROUP_ID AS group_id, 
      COUPON_TYPE_SUBGROUP_DESC AS desc1, 
      ACTIVE_FG AS active_fg,
      COUPON_TYPE_SUBGROUP_ID AS id;

    SET num_updated = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    
    SET out_param = TO_JSON_STRING(JSON_OBJECT('NumRowsUpdated', num_updated, 'QueryId', stmt_getQueryId, 'binds', JSON_ARRAY(COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_GROUP_ID, COUPON_TYPE_SUBGROUP_DESC, ACTIVE_FG)));

  SELECT out_param;
END;
END;