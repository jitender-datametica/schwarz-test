CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_ct_sec_role_obj_acl
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT P.p_lft_id,
 P.p_rgt_id,
 P.p_object_name,
 act.nstd_lft_id,
 act.nstd_rgt_id,
 act.object_name,
 act.object_type_id,
 act.object_path,
 act.security_role_id,
 act.security_role_desc,
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
   object_name,
   object_type_id,
   object_path,
   nstd_lft_id,
   nstd_rgt_id,
   zero_val
  FROM ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl
  GROUP BY security_role_id,
   security_role_desc,
   object_name,
   object_type_id,
   object_path,
   nstd_lft_id,
   nstd_rgt_id,
   zero_val) AS act
 LEFT JOIN (SELECT security_role_id,
   authorized AS new_authorized,
   entry_user,
   nstd_lft_id
  FROM ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl
  WHERE active_fg = 1
   AND approved = 0) AS neu ON act.security_role_id = neu.security_role_id AND act.nstd_lft_id = neu.nstd_lft_id
 INNER JOIN (SELECT security_role_id,
   authorized,
   nstd_lft_id,
   entry_user
  FROM ldl_p_lew_mart_msi.t_ct_sec_role_obj_acl
  WHERE active_fg = 1
   AND approved = 1) AS alt ON act.security_role_id = alt.security_role_id AND act.nstd_lft_id = alt.nstd_lft_id
 INNER JOIN ldl_p_lew_mart_msi.t_ref_obj_acl_parent_child AS P ON act.nstd_lft_id = P.c_lft_id;