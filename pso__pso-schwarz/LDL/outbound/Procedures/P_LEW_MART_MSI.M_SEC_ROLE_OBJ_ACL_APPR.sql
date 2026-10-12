CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_appr(
  SECURITY_ROLE_ID FLOAT64, 
  OBJECT_NAME STRING, 
  NSTD_LFT_ID FLOAT64, 
  APPROVAL_USER STRING, 
  APPROVING FLOAT64
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''-- At first, we are updating the actual live value to inactive
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
    SET
    active_fg = 0
    WHERE security_role_id = @SECURITY_ROLE_ID
    AND nstd_lft_id        = @NSTD_LFT_ID
    AND approved           = 1
    AND active_fg          = 1''' 
  USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID, NSTD_LFT_ID AS NSTD_LFT_ID;

  EXECUTE IMMEDIATE '''
    -- Now we are updating the last change request to the new live value
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
    SET
      approved          = 1
    , approval_user     = @APPROVAL_USER
    , approval_datetime = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE security_role_id = @SECURITY_ROLE_ID
    AND nstd_lft_id        = @NSTD_LFT_ID
    AND approved           = 0
    AND active_fg          = 1''' 
  USING APPROVAL_USER AS APPROVAL_USER, SECURITY_ROLE_ID AS SECURITY_ROLE_ID, NSTD_LFT_ID AS NSTD_LFT_ID;

  COMMIT TRANSACTION;
END;