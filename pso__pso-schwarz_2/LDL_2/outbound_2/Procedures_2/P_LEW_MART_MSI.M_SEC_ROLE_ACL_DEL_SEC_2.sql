CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_sec_role_acl_del_sec`(
  DUMMY_ID FLOAT64,
  SECURITY_ROLE_ID FLOAT64,
  SECURITY_ROLE_DESC STRING,
  ENTRY_USER STRING)
BEGIN
  DECLARE msg STRING;
  BEGIN
    EXECUTE IMMEDIATE """
      -- create new load_id if there is no load_id existing for the CURRENT_DATE("Europe/Berlin")
      INSERT INTO `p_lew_mart_msi.t_sys_load_status_acl_2` (
      jobname
      , instance_id
      , load_id
      , flag_change) SELECT
      'sec_role'       AS jobname,
      CAST(CURRENT_TIMESTAMP() AS DATETIME) AS instance_id,
      l.load_id            AS load_id,
      1
      FROM
      (SELECT
      MAX(instance_id) AS max_date,
      CASE
      WHEN CURRENT_DATE("Europe/Berlin") <> DATE(MAX(instance_id)) THEN (SELECT
      MAX(load_id) +1 AS load_id
      FROM `p_lew_mart_msi.t_sys_load_status_acl_2`)
      ELSE MAX(load_id) END AS load_id
      FROM `p_lew_mart_msi.t_sys_load_status_acl_2`
      WHERE CURRENT_DATE("Europe/Berlin") <> CAST((SELECT
      MAX(instance_id)
      FROM `p_lew_mart_msi.t_sys_load_status_acl_2`) AS DATE)
           GROUP BY jobname
        )AS l
    """;

    EXECUTE IMMEDIATE """
      -- at first, delete the last entry, just to ensure, that in the tmpl table are not duplicate change requests
      DELETE FROM `p_lew_mart_msi.t_sec_role_acl_tmpl_2`
      WHERE change_type = 'DELETE_SEC'
      AND security_role_desc = @security_role_desc
    """ USING 
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
      'DELETE_SEC'         AS change_type,
      @security_role_desc  AS security_role_desc,
      CAST(NULL AS STRING) AS dashboard_name,
      CAST(NULL AS INT64)AS authorized,
      CAST(CURRENT_TIMESTAMP() AS DATETIME)  AS change_dat,
      load.load_id         AS load_id,
      @entry_user          AS approval_user,
      @entry_user          AS entry_user
      FROM (SELECT
      MAX(load_id) AS load_id
      FROM `p_lew_mart_msi.t_sys_load_status_acl_2`
             ) AS load
        ) AS mp
    """ USING 
      SECURITY_ROLE_DESC AS security_role_desc, 
      ENTRY_USER AS entry_user;


  EXCEPTION WHEN ERROR THEN
    SET msg = FORMAT("""MESSAGE: %s""", @@error.message);
    RAISE USING MESSAGE= msg;
  END;

END;