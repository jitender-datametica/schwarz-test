CREATE OR REPLACE PROCEDURE `p_lew_load.m_sec_role_add_sec`(
  SECURITY_ROLE_DESC STRING,
  NAV_REL_FG FLOAT64,
  ENTRY_USER STRING
)
BEGIN
DECLARE msg STRING;
  BEGIN
    EXECUTE IMMEDIATE """
      -- create new load_id if there is no load_id existing for the CURRENT_DATE("Europe/Berlin")
      INSERT INTO `p_lew_load.t_sys_wb_load_1` (
      jobname
      , instance_id
      , load_id) SELECT
      'sec_role'           AS jobname,
      CAST(CURRENT_TIMESTAMP() AS DATETIME) AS instance_id,
      l.load_id            AS load_id
      FROM
      (SELECT
      MAX(instance_id) AS max_date,
      CASE
      WHEN CURRENT_DATE("Europe/Berlin") <> CAST(MAX(instance_id) AS DATE) THEN (SELECT
      MAX(load_id) +1 AS load_id
      FROM `p_lew_load.t_sys_wb_load_1`)
      ELSE MAX(load_id) END AS load_id
      FROM `p_lew_load.t_sys_wb_load_1`
      WHERE CURRENT_DATE("Europe/Berlin") <> CAST((SELECT
      MAX(instance_id)
      FROM `p_lew_load.t_sys_wb_load_1`) AS DATE)
           GROUP BY jobname
        )AS l
    """;
    
    EXECUTE IMMEDIATE """
      -- at first, delete the last entry, just to ensure, that in the l_0 table are not duplicate change requests
      DELETE FROM `p_lew_load.t_sec_security_role_l_0_1`
      WHERE change_type = 'ADD_SEC'
      AND security_role_desc = @security_role_desc
    """ USING 
      SECURITY_ROLE_DESC AS security_role_desc;

    EXECUTE IMMEDIATE """
      -- Insert the change_request into the l_0
      -- Entry_user and Approval_user are not used actually. So its not important that there is the same value.
      INSERT INTO `p_lew_load.t_sec_security_role_l_0_1` (
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
      'ADD_SEC'            AS change_type,
      @security_role_desc  AS security_role_desc,
      CAST(NULL AS STRING) AS dashboard_name,
      @nav_rel_fg          AS authorized,
      CAST(CURRENT_TIMESTAMP() AS DATE) AS change_dat,
      load.load_id         AS load_id,
      @entry_user          AS approval_user,
      @entry_user          AS entry_user
      FROM (SELECT
      MAX(load_id) AS load_id
      FROM `p_lew_load.t_sys_wb_load_1`
             WHERE jobname LIKE 'sec_role'
             ) AS load
          ) AS mp
    """ USING 
      SECURITY_ROLE_DESC AS security_role_desc, 
      CAST(NAV_REL_FG AS INT64) AS nav_rel_fg, 
      ENTRY_USER AS entry_user;

  EXCEPTION WHEN ERROR THEN
    SET msg = 'MESSAGE: ' || @@error.message;
    RAISE USING MESSAGE = msg;
  END;

END;