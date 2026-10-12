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
    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
        /* Initialisation */
            /* Commit transaction */
CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_coupon_type_group_add`(
  COUPON_TYPE_GROUP_ID FLOAT64,
  COUPON_TYPE_GROUP_DESC STRING,
  ACTIVE_FG FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE v_coupon_type_group_id FLOAT64;
  DECLARE res INT64;
  DECLARE stmt_getQueryId STRING;
  DECLARE row_count INT64;

  BEGIN
    
    IF COUPON_TYPE_GROUP_ID IS NULL THEN
      EXECUTE IMMEDIATE """
        SELECT COALESCE(MAX(coupon_type_group_id) + 1, 1) 
        FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_group`
      """ INTO v_coupon_type_group_id;
    ELSE
      SET v_coupon_type_group_id = COUPON_TYPE_GROUP_ID;
    END IF;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_group` 
      WHERE coupon_type_group_id = @id
    """ INTO res USING v_coupon_type_group_id AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: COUPON_TYPE_GROUP_ID: %f already exist in table T_REF_LDPL_COUPON_TYPE_GROUP""", v_coupon_type_group_id);
    END IF;

    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_group` 
      WHERE coupon_type_group_desc = @desc1
    """ INTO res USING COUPON_TYPE_GROUP_DESC AS desc1;

    IF res > 0 THEN
      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: COUPON_TYPE_GROUP_DESC: "%s" already exist in table T_REF_LDPL_COUPON_TYPE_GROUP""", COUPON_TYPE_GROUP_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_process_mstr.t_ref_ldpl_coupon_type_group` (                              
        coupon_type_group_id,
        coupon_type_group_desc,
        active_fg,
        dwh_created,
        dwh_updated                          
      )
      SELECT
        CAST(@id AS INT64) AS coupon_type_group_id,
        @desc1 AS coupon_type_group_desc,
        CAST(@active_fg AS INT64) AS active_fg,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated  
    """ USING 
      v_coupon_type_group_id AS id, 
      COUPON_TYPE_GROUP_DESC AS desc1, 
      ACTIVE_FG AS active_fg;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
      STRUCT(
          row_count AS NumRowsInserted, 
          stmt_getQueryId AS QueryId, 
          JSON_ARRAY(v_coupon_type_group_id, COUPON_TYPE_GROUP_DESC, ACTIVE_FG) AS binds
      )
  );
  END;
END;