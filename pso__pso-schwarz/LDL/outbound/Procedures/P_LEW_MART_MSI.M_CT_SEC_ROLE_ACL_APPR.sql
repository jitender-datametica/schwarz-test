CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_ct_sec_role_acl_appr(
  SECURITY_ROLE_ID FLOAT64, 
  SECURITY_ROLE_DESC STRING, 
  DASHBOARD_NAME STRING, 
  AUTHORIZED FLOAT64, 
  ENTRY_USER STRING, 
  APPROVAL_USER STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''-- The last active live value is updated to inactive, but only if the approval_user <> entry_user
    UPDATE p_lew_mart_msi.t_ct_sec_role_acl
    SET
      active_fg = 0
    WHERE security_role_id = @SECURITY_ROLE_ID
    AND dashboard_name     = @DASHBOARD_NAME
    AND approved           = 1
    AND active_fg          = 1''' 
  USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID, DASHBOARD_NAME AS DASHBOARD_NAME;
    
  EXECUTE IMMEDIATE '''
    -- at last, the update statement for the last active request runs. In this statement, the last active request gets updated to the actual live value
    UPDATE p_lew_mart_msi.t_ct_sec_role_acl
    SET
      approved          = 1
    , approval_user     = @APPROVAL_USER
    , approval_datetime = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE security_role_id = @SECURITY_ROLE_ID
    AND dashboard_name     = @DASHBOARD_NAME
    AND approved           = 0
    AND active_fg          = 1''' 
  USING APPROVAL_USER AS APPROVAL_USER, SECURITY_ROLE_ID AS SECURITY_ROLE_ID, DASHBOARD_NAME AS DASHBOARD_NAME;

  COMMIT TRANSACTION;
END;