CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_acl_ret_add_sec(
  DUMMY_ID FLOAT64, 
  SECURITY_ROLE_DESC STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    DELETE FROM p_lew_mart_msi.t_sec_role_acl_tmpl_1
    WHERE change_type = 'ADD_SEC'
    AND security_role_desc = @SECURITY_ROLE_DESC
  ''' USING SECURITY_ROLE_DESC AS SECURITY_ROLE_DESC;

  COMMIT TRANSACTION;
END;