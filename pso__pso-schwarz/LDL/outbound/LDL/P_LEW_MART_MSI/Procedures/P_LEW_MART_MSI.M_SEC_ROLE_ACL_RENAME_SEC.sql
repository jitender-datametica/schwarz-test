CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_acl_rename_sec(
  SECURITY_ROLE_DESC_OLD STRING,
  SECURITY_ROLE_DESC_NEW STRING,
  ENTRY_USER STRING
)
BEGIN

  -- 1. Create new load_id if there is no load_id existing for the current_date
  INSERT INTO ldl_p_lew_mart_msi.t_sys_load_status_acl (
    jobname,
    instance_id,
    load_id,
    flag_change
  )
  SELECT
    'sec_role' AS jobname,
    CAST(TIMESTAMP_TRUNC(CURRENT_TIMESTAMP(), SECOND) AS DATETIME) AS instance_id,
    l.load_id AS load_id,
    1
  FROM (
    SELECT
      MAX(instance_id) AS max_date,
      CASE
        WHEN CURRENT_DATE() <> CAST(MAX(instance_id) AS DATE) THEN (
          SELECT MAX(load_id) + 1 FROM ldl_p_lew_mart_msi.t_sys_load_status_acl
        )
        ELSE MAX(load_id) 
      END AS load_id
    FROM ldl_p_lew_mart_msi.t_sys_load_status_acl
    WHERE CURRENT_DATE() <> CAST((
      SELECT MAX(instance_id) FROM ldl_p_lew_mart_msi.t_sys_load_status_acl
    ) AS DATE)
    GROUP BY jobname
  ) AS l;

  -- 2. Delete old change request template
  DELETE FROM ldl_p_lew_mart_msi.t_sec_role_obj_acl_tmpl
  WHERE attribute_frst = SECURITY_ROLE_DESC_OLD
    AND change_type = 'RENAME_SEC';

  -- 3. Insert the change_request into the tmpl
  -- entry_user and approval_user are not used actually. So its not important that there are the same values
  INSERT INTO ldl_p_lew_mart_msi.t_sec_role_obj_acl_tmpl (
    change_type,
    attribute_frst,
    attribute_scnd,
    change_type_value,
    change_dat,
    load_id,
    approval_user,
    entry_user
  ) 
  SELECT
    mp.change_type,
    mp.attribute_frst,
    mp.attribute_scnd,
    mp.change_type_value,
    mp.change_dat,
    mp.load_id,
    mp.approval_user,
    mp.entry_user
  FROM (
    SELECT
      'RENAME_SEC' AS change_type,
      SECURITY_ROLE_DESC_OLD AS attribute_frst,
      SECURITY_ROLE_DESC_NEW AS attribute_scnd,
      CAST(NULL AS INT64) AS change_type_value,
      CURRENT_DATE() AS change_dat,
      lid.load_id AS load_id,
      ENTRY_USER AS approval_user,
      ENTRY_USER AS entry_user
    FROM (
      SELECT MAX(load_id) AS load_id
      FROM ldl_p_lew_mart_msi.t_sys_load_status_acl
    ) AS lid
  ) AS mp;



EXCEPTION WHEN ERROR THEN
  ROLLBACK TRANSACTION;
  RAISE USING MESSAGE = @@error.message;

END;



