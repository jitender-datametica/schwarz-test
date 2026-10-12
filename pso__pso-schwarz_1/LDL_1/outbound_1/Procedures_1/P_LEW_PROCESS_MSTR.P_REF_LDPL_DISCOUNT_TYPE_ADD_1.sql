/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-06 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#
#----------------------------------------------------------------------------
*/
    /* fix null - assign null to undefinded, otherwise you got an error Unsupported type for binding argument */
        /* Initialisation */
            /* Commit transaction */
CREATE OR REPLACE PROCEDURE `p_lew_process_mstr.p_ref_ldpl_discount_type_add`(
  DISCOUNT_TYPE_ID FLOAT64,  
  DISCOUNT_TYPE_DESC STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE v_discount_type_id FLOAT64;
  DECLARE res INT64;
  DECLARE stmt_getQueryId STRING;
  DECLARE row_count INT64;

  BEGIN
    /* If value is NULL get next value*/
    IF DISCOUNT_TYPE_ID IS NULL THEN
      EXECUTE IMMEDIATE """
        SELECT COALESCE(MAX(discount_type_id) + 1, 0) 
        FROM `p_lew_process_mstr.t_ref_ldpl_discount_type_1`
      """ INTO v_discount_type_id;
    ELSE
      SET v_discount_type_id = DISCOUNT_TYPE_ID;
    END IF;

    /* Check Uniqueness 1 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_discount_type_1` 
      WHERE discount_type_id = @id
    """ INTO res USING v_discount_type_id AS id;

    IF res > 0 THEN
      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: DISCOUNT_TYPE_ID: %f already exist in table T_REF_LDPL_DISCOUNT_TYPE_1""", v_discount_type_id);
    END IF;

    /* Check Uniqueness 2 */
    EXECUTE IMMEDIATE """
      SELECT COUNT(1) 
      FROM `p_lew_process_mstr.t_ref_ldpl_discount_type_1` 
      WHERE discount_type_desc = @desc1
    """ INTO res USING DISCOUNT_TYPE_DESC AS desc1;

    IF res > 0 THEN
      RAISE USING MESSAGE = FORMAT("""Uniqueness violation: DISCOUNT_TYPE_DESC: "%s" already exist in table T_REF_LDPL_DISCOUNT_TYPE_1""", DISCOUNT_TYPE_DESC);
    END IF;

    /* Apply operation */
    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_process_mstr.t_ref_ldpl_discount_type_1` 
      (                              
           discount_type_id              
          ,discount_type_desc                                                              
          ,dwh_created                   
          ,dwh_updated                          
      )
      VALUES 
      (
           CAST(@id AS INT64)
          ,@desc1
          ,CAST(CURRENT_TIMESTAMP() AS DATETIME)
          ,CAST(CURRENT_TIMESTAMP() AS DATETIME)
      )
    """ USING 
      v_discount_type_id AS id, 
      DISCOUNT_TYPE_DESC AS desc1;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
        STRUCT(
            row_count AS NumRowsInserted, 
            stmt_getQueryId AS QueryId, 
            JSON_ARRAY(v_discount_type_id, DISCOUNT_TYPE_DESC) AS binds
        )
    );

    END;
END;