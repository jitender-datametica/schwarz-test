CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ct_sec_role_obj_acl_perms
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT act.security_role_id,
 act.security_role_desc,
 act.permission_type,
 alt.authorized AS actual_entry_auth,
  CASE
  WHEN neu.new_authorized IS NULL
  THEN alt.authorized
  ELSE neu.new_authorized
  END AS change_entry_auth,
  CASE
  WHEN neu.entry_user IS NULL
  THEN alt.entry_user
  ELSE neu.entry_user
  END AS entry_user,
 act.zero_val
FROM (SELECT security_role_id,
   security_role_desc,
   permission_type,
   zero_val
  FROM ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl_perms
  GROUP BY security_role_id,
   security_role_desc,
   permission_type,
   zero_val) AS act
 LEFT JOIN (SELECT security_role_id,
   authorized AS new_authorized,
   entry_user,
   permission_type
  FROM ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl_perms
  WHERE active_fg = 1
   AND approved = 0) AS neu ON act.security_role_id = neu.security_role_id AND act.permission_type = neu.permission_type
   
 INNER JOIN (SELECT security_role_id,
   authorized,
   permission_type,
   entry_user
  FROM ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl_perms
  WHERE active_fg = 1
   AND approved = 1) AS alt ON act.security_role_id = alt.security_role_id AND act.permission_type = alt.permission_type;