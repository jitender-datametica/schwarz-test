CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_perms_appr(
  SECURITY_ROLE_ID FLOAT64, 
  PERMISSION_TYPE STRING, 
  DUMMY_ID FLOAT64, 
  ENTRY_USER STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''-- Updating the actual live value to inactive
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_1
    SET active_fg = 0
    WHERE security_role_id = @SECURITY_ROLE_ID
    AND permission_type    = @PERMISSION_TYPE
    AND approved           = 1
    AND active_fg          = 1
  ''' USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID, PERMISSION_TYPE AS PERMISSION_TYPE;

  EXECUTE IMMEDIATE '''
    -- Updating the last actual request to the new actual live value
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_1
    SET
      approved          = 1
    , approval_user     = @ENTRY_USER
    , approval_datetime = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE security_role_id = @SECURITY_ROLE_ID
    AND permission_type    = @PERMISSION_TYPE
    AND approved           = 0
    AND active_fg          = 1
  ''' USING ENTRY_USER AS ENTRY_USER, SECURITY_ROLE_ID AS SECURITY_ROLE_ID, PERMISSION_TYPE AS PERMISSION_TYPE;

  COMMIT TRANSACTION;
END;