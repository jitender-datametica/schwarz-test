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


CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_coupon_type_subgroup_add`(
  COUPON_TYPE_SUBGROUP_ID FLOAT64,
  COUPON_TYPE_GROUP_ID FLOAT64,
  COUPON_TYPE_SUBGROUP_DESC STRING,
  ACTIVE_FG FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE v_coupon_type_subgroup_id FLOAT64;
  DECLARE res INT64;
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* If value is NULL get next value*/
    IF COUPON_TYPE_SUBGROUP_ID IS NULL THEN
      EXECUTE IMMEDIATE """
        SELECT COALESCE(MAX(coupon_type_subgroup_id) + 1, 1) 
        FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_2`
      """ INTO v_coupon_type_subgroup_id;
    ELSE
      SET v_coupon_type_subgroup_id = COUPON_TYPE_SUBGROUP_ID;
    END IF;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_2` 
      WHERE coupon_type_subgroup_id = @id
    """ INTO res USING v_coupon_type_subgroup_id AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: COUPON_TYPE_SUBGROUP_ID: %f already exist in table T_REF_LDPL_COUPON_TYPE_SUBGROUP_2""", v_coupon_type_subgroup_id);
    END IF;

    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_2` 
      WHERE coupon_type_subgroup_desc = @desc1
    """ INTO res USING COUPON_TYPE_SUBGROUP_DESC AS desc1;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: COUPON_TYPE_SUBGROUP_DESC: "%s" already exist in table T_REF_LDPL_COUPON_TYPE_SUBGROUP_2""", COUPON_TYPE_SUBGROUP_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_process_mstr.t_ref_ldpl_coupon_type_subgroup_2` (                              
        coupon_type_subgroup_id,
        coupon_type_group_id,
        coupon_type_subgroup_desc,
        active_fg,
        dwh_created,
        dwh_updated                          
      )
      SELECT
        CAST(@id AS INT64) AS coupon_type_subgroup_id,
        CAST(@group_id AS INT64) AS coupon_type_group_id,
        @desc1 AS coupon_type_subgroup_desc,
        CAST(@active_fg AS INT64) AS active_fg,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated  
    """ USING 
      v_coupon_type_subgroup_id AS id, 
      COUPON_TYPE_GROUP_ID AS group_id, 
      COUPON_TYPE_SUBGROUP_DESC AS desc1, 
      ACTIVE_FG AS active_fg;

      SET row_count = @@row_count;

    SET stmt_getQueryId = @@current_job_id;


    /* return number of rows applied and binds */
    

    SET out_param = TO_JSON_STRING(
  JSON_OBJECT(
    'NumRowsInserted', row_count,
    'QueryId', stmt_getQueryId,
    'binds', JSON_ARRAY(v_coupon_type_subgroup_id, COUPON_TYPE_GROUP_ID, COUPON_TYPE_SUBGROUP_DESC, ACTIVE_FG)
  )
);



  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;