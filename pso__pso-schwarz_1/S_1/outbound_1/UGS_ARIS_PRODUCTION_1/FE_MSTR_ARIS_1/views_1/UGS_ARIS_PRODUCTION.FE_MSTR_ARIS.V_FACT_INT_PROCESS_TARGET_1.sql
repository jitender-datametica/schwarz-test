CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_fact_int_process_target_1 (dwh_tenant_cd, process_sid,
country_org_sid, resp_emp_pos_name, contact_emp_txt, resp_emp_name, process_upd_status_cd, process_change_lvl_cd,
sales_relevant_fg, store_relevant_fg, orig_lvl_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_tmsp) AS
SELECT T.dwh_tenant_cd,
 T.process_sid,
 T.country_org_sid,
 P.resp_emp_pos_name,
 P.contact_emp_txt,
 P.resp_emp_name,
 P.process_upd_status_cd,
 P.process_change_lvl_cd,
 P.sales_relevant_fg,
 P.store_relevant_fg,
 P.orig_lvl_nr,
 T.dwh_created_tmsp,
 T.dwh_updated_tmsp,
 T.dwh_src_file_name,
 T.src_tmsp
FROM ugs_aris_production_core.t_fact_int_process_target_1 AS T
 INNER JOIN ugs_aris_production_core.t_dim_process_1 AS P ON T.process_sid = P.process_sid
WHERE T.dwh_valid_fg
 AND P.dwh_valid_fg;