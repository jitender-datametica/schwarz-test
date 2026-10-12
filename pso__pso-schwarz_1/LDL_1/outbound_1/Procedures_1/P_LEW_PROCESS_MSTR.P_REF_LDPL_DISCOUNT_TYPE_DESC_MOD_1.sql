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

CREATE OR REPLACE PROCEDURE p_lew_process_mstr.p_ref_ldpl_discount_type_desc_mod(
  DISCOUNT_TYPE_ID FLOAT64,  
  DISCOUNT_TYPE_DESC STRING,
  LANG_CD STRING,
  OUT out_param STRING
)
BEGIN
  DECLARE row_count INT64;
  DECLARE stmt_getQueryId STRING;

  BEGIN
    /* Apply operation */
    EXECUTE IMMEDIATE """
      UPDATE p_lew_process_mstr.t_ref_ldpl_discount_type_desc_1
      SET 
        discount_type_desc = @DISCOUNT_TYPE_DESC,
        dwh_updated        = CAST(CURRENT_TIMESTAMP() AS DATETIME)
      WHERE 
        discount_type_id = CAST(@DISCOUNT_TYPE_ID AS INT64)
      AND lang_cd = @LANG_CD
    """ USING 
      DISCOUNT_TYPE_DESC AS DISCOUNT_TYPE_DESC, 
      DISCOUNT_TYPE_ID AS DISCOUNT_TYPE_ID, 
      LANG_CD AS LANG_CD;

    SET row_count = @@row_count;
    SET stmt_getQueryId = @@current_job_id;

    /* return number of rows applied and query_id */
    SET out_param = TO_JSON_STRING(
        STRUCT(
            row_count AS NumRowsUpdated, 
            stmt_getQueryId AS QueryId, 
            JSON_ARRAY(DISCOUNT_TYPE_DESC, DISCOUNT_TYPE_ID, LANG_CD) AS binds
        )
    );

  EXCEPTION WHEN ERROR THEN
    SET out_param = 'MESSAGE: ' || @@error.message;
    RAISE USING MESSAGE=out_param;
  END;

END;