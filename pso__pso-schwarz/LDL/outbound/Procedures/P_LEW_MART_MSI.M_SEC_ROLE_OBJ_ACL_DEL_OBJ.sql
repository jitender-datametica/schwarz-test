CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_del_obj(
  OBJECT_NAME STRING, 
  NSTD_LFT_ID FLOAT64, 
  NSTD_RGT_ID FLOAT64, 
  DUMMYID FLOAT64,
  OUT out_param STRING
)
BEGIN
  BEGIN
    BEGIN TRANSACTION;

    -- Delete the object from the main table and update the lft and rgt idÝs
    EXECUTE IMMEDIATE """
      DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
      WHERE nstd_lft_id BETWEEN CAST(@NSTD_LFT_ID AS INT64) AND CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_LFT_ID AS NSTD_LFT_ID, 
      NSTD_RGT_ID AS NSTD_RGT_ID;

    EXECUTE IMMEDIATE """
      UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl 
      SET nstd_lft_id = CAST(nstd_lft_id - ROUND((CAST(@NSTD_RGT_ID AS INT64) - CAST(@NSTD_LFT_ID AS INT64) + 1)) AS INT64)
      WHERE nstd_lft_id > CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_RGT_ID AS NSTD_RGT_ID, 
      NSTD_LFT_ID AS NSTD_LFT_ID;

    EXECUTE IMMEDIATE """
      UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl 
      SET nstd_rgt_id = CAST(nstd_rgt_id - ROUND((CAST(@NSTD_RGT_ID AS INT64) - CAST(@NSTD_LFT_ID AS INT64) + 1)) AS INT64)
      WHERE nstd_rgt_id > CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_RGT_ID AS NSTD_RGT_ID, 
      NSTD_LFT_ID AS NSTD_LFT_ID;

    -- Delete the object from the parent child table and update the lft and rgt idÝs
    EXECUTE IMMEDIATE """
      DELETE FROM p_lew_mart_msi.t_ref_obj_acl_parent_child
      WHERE c_lft_id BETWEEN CAST(@NSTD_LFT_ID AS INT64) AND CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_LFT_ID AS NSTD_LFT_ID, 
      NSTD_RGT_ID AS NSTD_RGT_ID;

    EXECUTE IMMEDIATE """
      UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
      SET c_lft_id = CAST(c_lft_id - ROUND((CAST(@NSTD_RGT_ID AS INT64) - CAST(@NSTD_LFT_ID AS INT64) + 1)) AS INT64)
      WHERE c_lft_id > CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_RGT_ID AS NSTD_RGT_ID, 
      NSTD_LFT_ID AS NSTD_LFT_ID;

    EXECUTE IMMEDIATE """
      UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
      SET c_rgt_id = CAST(c_rgt_id - ROUND((CAST(@NSTD_RGT_ID AS INT64) - CAST(@NSTD_LFT_ID AS INT64) + 1)) AS INT64)
      WHERE c_rgt_id > CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_RGT_ID AS NSTD_RGT_ID, 
      NSTD_LFT_ID AS NSTD_LFT_ID;

    EXECUTE IMMEDIATE """
      UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
      SET p_lft_id = CAST(p_lft_id - ROUND((CAST(@NSTD_RGT_ID AS INT64) - CAST(@NSTD_LFT_ID AS INT64) + 1)) AS INT64)
      WHERE p_lft_id > CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_RGT_ID AS NSTD_RGT_ID, 
      NSTD_LFT_ID AS NSTD_LFT_ID;

    EXECUTE IMMEDIATE """
      UPDATE p_lew_mart_msi.t_ref_obj_acl_parent_child 
      SET p_rgt_id = CAST(p_rgt_id - ROUND((CAST(@NSTD_RGT_ID AS INT64) - CAST(@NSTD_LFT_ID AS INT64) + 1)) AS INT64)
      WHERE p_rgt_id > CAST(@NSTD_RGT_ID AS INT64)
    """ USING 
      NSTD_RGT_ID AS NSTD_RGT_ID, 
      NSTD_LFT_ID AS NSTD_LFT_ID;

    COMMIT TRANSACTION;

    SET out_param = 'SUCCESS';

  EXCEPTION WHEN ERROR THEN
    ROLLBACK TRANSACTION;
    SET out_param = 'MESSAGE: ' || @@error.message;
    RAISE USING MESSAGE=out_param;
  END;
END;