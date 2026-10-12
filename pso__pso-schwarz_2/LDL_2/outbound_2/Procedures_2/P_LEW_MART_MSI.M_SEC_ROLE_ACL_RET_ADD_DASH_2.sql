CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_acl_ret_add_dash(
  DUMMY_ID FLOAT64, 
  DASHBOARD_NAME STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    DELETE FROM p_lew_mart_msi.t_sec_role_acl_tmpl_2
    WHERE change_type = 'ADD_DASHBOARD'
    AND dashboard_name = @DASHBOARD_NAME
  ''' USING DASHBOARD_NAME AS DASHBOARD_NAME;

  COMMIT TRANSACTION;
END;