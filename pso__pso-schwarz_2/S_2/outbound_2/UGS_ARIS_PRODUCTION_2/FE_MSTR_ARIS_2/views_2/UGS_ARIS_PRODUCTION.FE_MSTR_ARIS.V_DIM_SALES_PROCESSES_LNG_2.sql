CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_sales_processes_lng_2 (dwh_tenant_cd, process_sid,
modell_guid, orig_lvl_nr, country_org_nr, dwh_src_file_name, sales_processes_txt, `sales_processes_txt_bg-bg`,
`sales_processes_txt_dk-dk`, `sales_processes_txt_de-de`, `sales_processes_txt_en-us`, `sales_processes_txt_en-uk`,
`sales_processes_txt_en-ie`, `sales_processes_txt_ee-ee`, `sales_processes_txt_fi-fi`, `sales_processes_txt_fr-fr`,
`sales_processes_txt_fr-be`, `sales_processes_txt_gr-gr`, `sales_processes_txt_it-it`, `sales_processes_txt_hr-hr`,
`sales_processes_txt_lv-lv`, `sales_processes_txt_lt-lt`, `sales_processes_txt_nl-nl`, `sales_processes_txt_nl-be`,
`sales_processes_txt_pl-pl`, `sales_processes_txt_pt-_u0028_brasil_u0029_`, `sales_processes_txt_ro-ro`,
`sales_processes_txt_se-se`, `sales_processes_txt_rs-rs_2`, `sales_processes_txt_sk-sk`, `sales_processes_txt_si-si`,
`sales_processes_txt_es-es`, `sales_processes_txt_cz-cz`, `sales_processes_txt_hu-hu`, dwh_created_tmsp,
dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_fe_mstr_aris.t_dim_sales_processes_lng_2;