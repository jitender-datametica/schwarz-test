CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_process_1 (dwh_tenant_cd, process_sid, dwh_valid_from_tmsp,
dwh_valid_to_tmsp, dwh_valid_fg, process_nr, process_name, int_version_nr, wip_int_version_nr, nat_version_nr,
wip_nat_version_nr, sges_version_nr, wip_sges_version_nr, lvl_nr, path_name, process_guid_txt, process_url_txt,
process_comment_txt, change_to_prev_ver_txt, change_to_int_txt, change_of_int_to_prev_ver_txt, keywords_txt,
documents_txt, sales_processes_txt, process_valid_from_dt, process_valid_from_dt_fg, process_valid_to_dt,
eki_qm_created_txt, eki_qm_review_txt, eki_qm_approval_txt, rollout_dt, approval_dt, publish_in_store_dt, last_review_dt
, last_change_dt, process_scope_cd, process_scope_descr, process_type_cd, process_type_descr, process_status_cd,
process_status_descr, process_upd_status_cd, process_upd_status_descr, process_workflow_status_cd,
process_workflow_status_descr, business_area_cd, business_area_descr, resp_emp_pos_sid, resp_emp_pos_name, resp_emp_sid
, resp_emp_name, owner_emp_sid, owner_emp_name, workflow_approv_emp_sid, workflow_approv_emp_name, approv_emp_txt,
contact_emp_txt, country_org_sid, country_org_nr, country_org_name, store_relevant_fg, store_mgr_relevant_fg,
sales_relevant_fg, stationary_sales_relevant_fg, online_sales_relevant_fg, emp_terminal_relevant_fg,
regional_org_relevant_fg, sdl_szd_origin_fg, applicable_to_lidl_fg, applicable_to_kaufland_fg, semantic_check_ok_fg,
country_specific_process_fg, int_process_sid, int_process_name, cur_int_process_version_nr, int_process_guid_txt,
int_process_approval_dt, process_change_lvl_cd, process_change_lvl_descr, process_rollout_status_cd, rollout_dur_day_cnt
, orig_lvl_nr, lvl_1_process_sid, lvl_1_process_name, lvl_2_process_sid, lvl_2_process_name, lvl_2_skipped_fg,
lvl_3_process_sid, lvl_3_process_name, lvl_3_skipped_fg, lvl_4_process_sid, lvl_4_process_name, lvl_4_skipped_fg,
lvl_5_process_sid, lvl_5_process_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_tmsp,
lvl_1_online_process_sid, lvl_1_online_process_name, referenz, int_resp_emp_pos_sid, int_resp_emp_pos_name) AS SELECT A
 .dwh_tenant_cd,
 A.process_sid,
 A.dwh_valid_from_tmsp,
 A.dwh_valid_to_tmsp,
 A.dwh_valid_fg,
 A.process_nr,
 A.process_name,
 A.int_version_nr,
 A.wip_int_version_nr,
 A.nat_version_nr,
 A.wip_nat_version_nr,
 A.sges_version_nr,
 A.wip_sges_version_nr,
 A.lvl_nr,
 A.path_name,
 A.process_guid_txt,
 A.process_url_txt,
 A.process_comment_txt,
 A.change_to_prev_ver_txt,
 A.change_to_int_txt,
 A.change_of_int_to_prev_ver_txt,
 A.keywords_txt,
 A.documents_txt,
 A.sales_processes_txt,
 A.process_valid_from_dt,
  CASE
  WHEN A.process_upd_status_cd IN ('UPDT', 'NAPPR') AND A.process_valid_from_dt < CURRENT_DATE
  THEN 1
  ELSE 0
  END AS process_valid_from_dt_fg,
 A.process_valid_to_dt,
 A.eki_qm_created_txt,
 A.eki_qm_review_txt,
 A.eki_qm_approval_txt,
 A.rollout_dt,
 A.approval_dt,
 A.publish_in_store_dt,
 A.last_review_dt,
 A.last_change_dt,
 A.process_scope_cd,
 A.process_scope_descr,
 A.process_type_cd,
 A.process_type_descr,
 A.process_status_cd,
 A.process_status_descr,
 A.process_upd_status_cd,
 A.process_upd_status_descr,
 A.process_workflow_status_cd,
 A.process_workflow_status_descr,
 A.business_area_cd,
 A.business_area_descr,
 A.resp_emp_pos_sid,
 A.resp_emp_pos_name,
 A.resp_emp_sid,
 A.resp_emp_name,
 A.owner_emp_sid,
 A.owner_emp_name,
 A.workflow_approv_emp_sid,
 A.workflow_approv_emp_name,
 A.approv_emp_txt,
 A.contact_emp_txt,
 A.country_org_sid,
 A.country_org_nr,
 A.country_org_name,
 A.store_relevant_fg,
 A.store_mgr_relevant_fg,
 A.sales_relevant_fg,
 A.stationary_sales_relevant_fg,
 A.online_sales_relevant_fg,
 A.emp_terminal_relevant_fg,
 A.regional_org_relevant_fg,
 A.sdl_szd_origin_fg,
 A.applicable_to_lidl_fg,
 A.applicable_to_kaufland_fg,
 A.semantic_check_ok_fg,
 A.country_specific_process_fg,
 A.int_process_sid,
 A.int_process_name,
 A.cur_int_process_version_nr,
 A.int_process_guid_txt,
 A.int_process_approval_dt,
 A.process_change_lvl_cd,
 A.process_change_lvl_descr,
 A.process_rollout_status_cd,
 A.rollout_dur_day_cnt,
 A.orig_lvl_nr,
 A.lvl_1_process_sid,
 A.lvl_1_process_name,
  CASE
  WHEN A.lvl_nr = 2 AND A.orig_lvl_nr <> 2
  THEN '-2'
  WHEN A.orig_lvl_nr = 2 AND A.lvl_nr <> 2
  THEN CAST(A.process_sid AS STRING)
  ELSE CAST(A.lvl_2_process_sid AS STRING)
  END AS lvl_2_process_sid,
  CASE
  WHEN A.lvl_nr = 2 AND A.orig_lvl_nr <> 2
  THEN ''
  WHEN A.orig_lvl_nr = 2 AND A.lvl_nr <> 2
  THEN A.process_name
  ELSE A.lvl_2_process_name
  END AS lvl_2_process_name,
 A.lvl_2_skipped_fg,
  CASE
  WHEN A.lvl_nr = 3 AND A.orig_lvl_nr <> 3
  THEN '-2'
  WHEN A.orig_lvl_nr = 3 AND A.lvl_nr <> 3
  THEN CAST(A.process_sid AS STRING)
  ELSE CAST(A.lvl_3_process_sid AS STRING)
  END AS lvl_3_process_sid,
  CASE
  WHEN A.lvl_nr = 3 AND A.orig_lvl_nr <> 3
  THEN ''
  WHEN A.orig_lvl_nr = 3 AND A.lvl_nr <> 3
  THEN A.process_name
  ELSE A.lvl_3_process_name
  END AS lvl_3_process_name,
 A.lvl_3_skipped_fg,
  CASE
  WHEN A.lvl_nr = 4 AND A.orig_lvl_nr <> 4
  THEN '-2'
  WHEN A.orig_lvl_nr = 4 AND A.lvl_nr <> 4
  THEN CAST(A.process_sid AS STRING)
  ELSE CAST(A.lvl_4_process_sid AS STRING)
  END AS lvl_4_process_sid,
  CASE
  WHEN A.lvl_nr = 4 AND A.orig_lvl_nr <> 4
  THEN ''
  WHEN A.orig_lvl_nr = 4 AND A.lvl_nr <> 4
  THEN A.process_name
  ELSE A.lvl_4_process_name
  END AS lvl_4_process_name,
 A.lvl_4_skipped_fg,
  CASE
  WHEN A.lvl_nr = 5 AND A.orig_lvl_nr <> 5
  THEN '-2'
  WHEN A.orig_lvl_nr = 5 AND A.lvl_nr <> 5
  THEN CAST(A.process_sid AS STRING)
  ELSE CAST(A.lvl_5_process_sid AS STRING)
  END AS lvl_5_process_sid,
  CASE
  WHEN A.lvl_nr = 5 AND A.orig_lvl_nr <> 5
  THEN ''
  WHEN A.orig_lvl_nr = 5 AND A.lvl_nr <> 5
  THEN A.process_name
  ELSE A.lvl_5_process_name
  END AS lvl_5_process_name,
 A.dwh_created_tmsp,
 A.dwh_updated_tmsp,
 A.dwh_src_file_name,
 A.src_tmsp,
 A.lvl_1_online_process_sid,
 A.lvl_1_online_process_name,
 1 AS referenz,
 B.resp_emp_pos_sid AS int_resp_emp_pos_sid,
 B.resp_emp_pos_name AS int_resp_emp_pos_name
FROM ugs_aris_production_core.t_dim_process_1 AS A
 LEFT JOIN (SELECT process_guid_txt,
   resp_emp_pos_sid,
   resp_emp_pos_name,
   dwh_tenant_cd
  FROM ugs_aris_production_core.t_dim_process_1
  WHERE dwh_valid_fg
   AND process_sid > 0
   AND country_org_sid = - 1) AS B ON A.int_process_guid_txt = B.process_guid_txt AND A.dwh_tenant_cd = B.dwh_tenant_cd
WHERE A.dwh_valid_fg;