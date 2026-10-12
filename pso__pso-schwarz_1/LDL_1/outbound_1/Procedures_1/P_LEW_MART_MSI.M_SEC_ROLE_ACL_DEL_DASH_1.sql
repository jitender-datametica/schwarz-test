CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_acl_del_dash(
  DUMMY_ID FLOAT64, 
  DASHBOARD_NAME STRING, 
  ENTRY_USER STRING
)
BEGIN
  BEGIN TRANSACTION;

  -- Create new load_id if there is no load_id existing for the CURRENT_DATE("Europe/Berlin")
  EXECUTE IMMEDIATE '''
    INSERT INTO p_lew_mart_msi.t_sys_load_status_acl_1 (
      jobname, instance_id, load_id, flag_change
    ) 
    SELECT
      'sec_role'          AS jobname,
      CAST(CURRENT_TIMESTAMP() AS DATETIME) AS instance_id,
      CASE 
        WHEN CURRENT_DATE("Europe/Berlin") <> DATE(agg.max_date) THEN agg.max_load + 1
        ELSE agg.max_load 
      END                 AS load_id,
      1
    FROM (
      SELECT 
        MAX(instance_id) AS max_date,
        MAX(load_id)     AS max_load
      FROM p_lew_mart_msi.t_sys_load_status_acl_1
    ) AS agg
    -- This filter ensures we only insert if the date condition is met
    WHERE CURRENT_DATE("Europe/Berlin") <> DATE(agg.max_date)
  ''';

  EXECUTE IMMEDIATE '''
    -- at first, delete the last entry, just to ensure, that in the tmpl table are not duplicate change requests
    DELETE FROM p_lew_mart_msi.t_sec_role_acl_tmpl_1
    WHERE change_type = 'DELETE_DASHBOARD'
    AND dashboard_name = @DASHBOARD_NAME
  ''' USING DASHBOARD_NAME AS DASHBOARD_NAME;

  EXECUTE IMMEDIATE '''
    -- Insert the change_request into the tmpl
    INSERT INTO p_lew_mart_msi.t_sec_role_acl_tmpl_1 (
      change_type, security_role_desc, dashboard_name, authorized, 
      change_dat, load_id, approval_user, entry_user
    ) 
    SELECT
      'DELETE_DASHBOARD'    AS change_type,
      NULL                  AS security_role_desc,
      @DASHBOARD_NAME       AS dashboard_name,
      NULL                  AS authorized,
      CAST(CURRENT_TIMESTAMP() AS DATE)   AS change_dat,
      load.max_load         AS load_id,
      @ENTRY_USER           AS approval_user,
      @ENTRY_USER_1         AS entry_user
    FROM (
      SELECT MAX(load_id) AS max_load
      FROM p_lew_mart_msi.t_sys_load_status_acl_1
    ) AS load
  ''' USING DASHBOARD_NAME AS DASHBOARD_NAME, ENTRY_USER AS ENTRY_USER, ENTRY_USER AS ENTRY_USER_1;

  COMMIT TRANSACTION;
END;