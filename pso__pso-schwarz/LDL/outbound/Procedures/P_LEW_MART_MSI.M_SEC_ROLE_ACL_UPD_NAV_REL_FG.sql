CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_acl_upd_nav_rel_fg(
  SECURITY_ROLE_ID FLOAT64, 
  NAV_REL_FG FLOAT64
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    -- Update nav_rel_fg
    UPDATE p_lew_mart_msi.t_ref_sec_role_acl
    SET nav_rel_fg = CAST(@NAV_REL_FG AS INT64)
    WHERE security_role_id = @SECURITY_ROLE_ID
  ''' USING NAV_REL_FG AS NAV_REL_FG, SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  COMMIT TRANSACTION;
END;