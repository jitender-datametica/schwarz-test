CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_ct_sec_role_acl_req(
  SECURITY_ROLE_ID FLOAT64, 
  SECURITY_ROLE_DESC STRING, 
  DASHBOARD_NAME STRING, 
  AUTHORIZED FLOAT64, 
  ENTRY_USER STRING
)
BEGIN

  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    UPDATE p_lew_mart_msi.t_ct_sec_role_acl_1
    SET
      active_fg = 0
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND dashboard_name = @DASHBOARD_NAME
      AND approved = 0
  ''' USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID , DASHBOARD_NAME AS DASHBOARD_NAME;

  EXECUTE IMMEDIATE ''' -- second step is to insert the new request into the table with active_fg = 1
    INSERT INTO p_lew_mart_msi.t_ct_sec_role_acl_1 (
        security_role_id
      , security_role_desc
      , dashboard_name
      , authorized
      , entry_user
      , entry_datetime
      , approval_user
      , approval_datetime
      , approved
      , active_fg
    ) VALUES (
        CAST(@SECURITY_ROLE_ID AS INT64)
      , @SECURITY_ROLE_DESC
      , @DASHBOARD_NAME
      , CAST(@AUTHORIZED AS INT64)
      , @ENTRY_USER
      , CAST(CURRENT_TIMESTAMP() AS DATETIME)
      , 'NOT_APPROVED'
      , NULL
      , 0
      , 1
    )
  ''' USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID, SECURITY_ROLE_DESC AS SECURITY_ROLE_DESC, DASHBOARD_NAME AS DASHBOARD_NAME, AUTHORIZED AS AUTHORIZED, ENTRY_USER AS ENTRY_USER;

  COMMIT TRANSACTION;

END;