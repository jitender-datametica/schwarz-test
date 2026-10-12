CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ct_sec_security_role
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT act.security_role_id,
 act.security_role_desc,
 act.dashboard_name,
  CASE
  WHEN n.new_authorized IS NULL
  THEN a.authorized
  ELSE n.new_authorized
  END AS change_entry,
 a.authorized AS actual_entry,
  CASE
  WHEN n.entry_user IS NULL
  THEN a.entry_user
  ELSE n.entry_user
  END AS entry_user
FROM (SELECT security_role_id,
   security_role_desc,
   dashboard_name
  FROM ldl_p_lew_mart_msi.t_msi_ct_sec_security_role AS T
  GROUP BY security_role_id,
   security_role_desc,
   dashboard_name) AS act
 LEFT JOIN (SELECT security_role_id,
   dashboard_name,
   authorized AS new_authorized,
   entry_user
  FROM ldl_p_lew_mart_msi.t_msi_ct_sec_security_role
  WHERE active_fg = 1
   AND approved = 0) AS n ON act.security_role_id = n.security_role_id AND act.dashboard_name = n.dashboard_name
 INNER JOIN (SELECT security_role_id,
   dashboard_name,
   authorized,
   entry_user
  FROM ldl_p_lew_mart_msi.t_msi_ct_sec_security_role
  WHERE active_fg = 1
   AND approved = 1) AS a ON act.security_role_id = a.security_role_id AND act.dashboard_name = a.dashboard_name;