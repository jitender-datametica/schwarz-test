CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_sec_role_acl_upd_access`(
  SECURITY_ROLE_DESC STRING,
  DASHBOARD_NAME STRING,
  ENTRY_USER STRING,
  AUTHORIZED FLOAT64,
  APPROVAL_USER STRING)
BEGIN
  DECLARE msg STRING;
  BEGIN
    EXECUTE IMMEDIATE """
      -- create new load_id if there is no load_id existing for the CURRENT_DATE("Europe/Berlin")
      INSERT INTO `p_lew_mart_msi.t_sys_load_status_acl_2` (
          jobname
          , instance_id
          , load_id
          , flag_change
          ) 
      SELECT
          'sec_role' AS jobname,
          CAST(CURRENT_TIMESTAMP() AS DATETIME) AS instance_id,
          l.load_id AS load_id,
          1
      FROM (
          SELECT MAX(instance_id) AS max_date,
              CASE 
                  WHEN CURRENT_DATE("Europe/Berlin") <> CAST(MAX(instance_id) AS DATE) 
                  THEN (SELECT MAX(load_id) + 1 AS load_id FROM `p_lew_mart_msi.t_sys_load_status_acl_2`)
                  ELSE MAX(load_id) 
              END AS load_id,
              MAX(CASE WHEN jobname = 'sec_role' THEN 1 ELSE 0 END) OVER () AS sec_role_job_exist,
              CASE WHEN jobname = 'sec_role' THEN 1 ELSE 0 END AS sec_role_row,
              ROW_NUMBER() OVER (PARTITION BY CASE WHEN jobname = 'sec_role' THEN 1 ELSE 0 END ORDER BY jobname) AS rownum
          FROM `p_lew_mart_msi.t_sys_load_status_acl_2`
          WHERE CURRENT_DATE("Europe/Berlin") <> CAST((SELECT MAX(instance_id) FROM `p_lew_mart_msi.t_sys_load_status_acl_2`) AS DATE)
          GROUP BY jobname
          QUALIFY sec_role_job_exist = sec_role_row AND rownum = 1
          ) AS l
    """;

    EXECUTE IMMEDIATE """
      -- at first, delete the last entry, just to ensure, that in the tmpl table are not duplicate change requests
      DELETE FROM `p_lew_mart_msi.t_sec_role_acl_tmpl_2`
      WHERE dashboard_name = @dashboard_name
      AND security_role_desc = @security_role_desc
      AND change_type LIKE 'UPDATE_ACCESS'
    """ USING 
      DASHBOARD_NAME AS dashboard_name, 
      SECURITY_ROLE_DESC AS security_role_desc;

    EXECUTE IMMEDIATE """
      -- Insert the change_request into the tmpl
      INSERT INTO `p_lew_mart_msi.t_sec_role_acl_tmpl_2` (
      change_type
      , security_role_desc
      , dashboard_name
      , authorized
      , change_dat
      , load_id
      , approval_user
      , entry_user) SELECT
      mp.change_type,
      mp.security_role_desc,
      mp.dashboard_name,
      mp.authorized,
      mp.change_dat,
      mp.load_id,
      mp.approval_user,
      mp.entry_user
      FROM
      (SELECT
      'UPDATE_ACCESS' AS change_type,
      @security_role_desc AS security_role_desc,
      @dashboard_name AS dashboard_name,
      @authorized AS authorized,
      CAST(CURRENT_TIMESTAMP() AS DATE) AS change_dat,
      load.load_id AS load_id,
      @approval_user AS approval_user,
      @entry_user AS entry_user
      FROM (SELECT
      MAX(load_id) AS load_id
      FROM `p_lew_mart_msi.t_sys_load_status_acl_2`
             ) AS load
          ) AS mp
    """ USING 
      SECURITY_ROLE_DESC AS security_role_desc,
      DASHBOARD_NAME AS dashboard_name,
      CAST(AUTHORIZED AS INT64) AS authorized,
      APPROVAL_USER AS approval_user,
      ENTRY_USER AS entry_user;


  EXCEPTION WHEN ERROR THEN
    SET msg = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE=msg;
  END;

END;