/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2021-10-08 Pawel Wieczorek          SD-2524 Initial version
#  1.1 2021-11-16 Pawel Wieczorek          SD-2524 Commit added
#  1.2 2021-12-15 Pawel Wieczorek          SD-2524 add fix_null
#  1.3 2021-12-22 Pawel Wieczorek          Add checking COUPON_TYPE_DESC
#  1.4 2021-12-23 Pawel Wieczorek          Skip checking decription for modified record
#                                          Add missing fix_null
#  1.5 2022-02-24 Rafal Rudnik             removed parameter COUPON_TYPE_DESC and 
#                                          check logic for it.
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_process_mstr.p_ref_ldpl_coupon_type_mod(
  COUPON_TYPE_ID FLOAT64,  
  COUPON_TYPE_SUBGROUP_ID FLOAT64,
  OUT out_param STRING
)
BEGIN
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE p_lew_process_mstr.t_ref_ldpl_coupon_type_1 
      SET 
        coupon_type_subgroup_id = CAST(@COUPON_TYPE_SUBGROUP_ID AS INT64),
        dwh_updated             = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE        
        coupon_type_id = CAST(@COUPON_TYPE_ID AS INT64)
    """ USING 
      COUPON_TYPE_SUBGROUP_ID AS COUPON_TYPE_SUBGROUP_ID, 
      COUPON_TYPE_ID AS COUPON_TYPE_ID;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
   SET out_param = TO_JSON_STRING(JSON_OBJECT('NumRowsUpdated', row_count, 'QueryId', stmt_getQueryId, 'binds', JSON_ARRAY(COUPON_TYPE_ID, COUPON_TYPE_SUBGROUP_ID)));
  EXCEPTION WHEN ERROR THEN
    SET out_param = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=out_param;
  END;

END;