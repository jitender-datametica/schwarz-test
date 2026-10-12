/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-11 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_process_mstr.p_ref_ldpl_coupon_type_add(
  COUPON_TYPE_ID FLOAT64,  
  COUPON_TYPE_SUBGROUP_ID FLOAT64,      
  COUPON_TYPE_DESC STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE v_coupon_type_id FLOAT64;
  DECLARE res INT64;
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* If value is NULL get next value*/
    IF COUPON_TYPE_ID IS NULL THEN
      EXECUTE IMMEDIATE """
        SELECT COALESCE(MAX(coupon_type_id) + 1, 0) 
        FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_2
      """ INTO v_coupon_type_id;
    ELSE
      SET v_coupon_type_id = COUPON_TYPE_ID;
    END IF;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_2 
      WHERE coupon_type_id = @id
    """ INTO res USING v_coupon_type_id AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: COUPON_TYPE_ID: %f already exist in table T_REF_LDPL_COUPON_TYPE_2""", v_coupon_type_id);
    END IF;

    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM p_lew_process_mstr.t_ref_ldpl_coupon_type_2 
      WHERE coupon_type_desc = @COUPON_TYPE_DESC
    """ INTO res USING COUPON_TYPE_DESC AS COUPON_TYPE_DESC;

    IF res > 0 THEN
      RAISE USING MESSAGE=FORMAT("""Uniqueness violation: COUPON_TYPE_DESC: "%s" already exist in table T_REF_LDPL_COUPON_TYPE_2""", COUPON_TYPE_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      INSERT INTO p_lew_process_mstr.t_ref_ldpl_coupon_type_2 (                              
        coupon_type_id,
        coupon_type_subgroup_id,
        coupon_type_desc,
        dwh_created,
        dwh_updated                           
      )
      SELECT
        CAST(@id AS INT64) AS coupon_type_id,
        CAST(@COUPON_TYPE_SUBGROUP_ID AS INT64) AS coupon_type_subgroup_id,
        @COUPON_TYPE_DESC AS coupon_type_desc,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_created,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated  
    """ USING 
      v_coupon_type_id AS id, 
      COUPON_TYPE_SUBGROUP_ID AS COUPON_TYPE_SUBGROUP_ID, 
      COUPON_TYPE_DESC AS COUPON_TYPE_DESC;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and binds */
    SET out_param = FORMAT('{"NumRowsInserted": %d, "QueryId": "%s", "binds": [%f, %f, "%s"]}', row_count, stmt_getQueryId, v_coupon_type_id, COUPON_TYPE_SUBGROUP_ID, COUPON_TYPE_DESC);

  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;
