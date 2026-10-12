CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_process_status_lng_2 (process_status_cd,
process_status_descr, `process_status_descr_bg-bg`, `process_status_descr_dk-dk`, `process_status_descr_de-de`,
`process_status_descr_en-us`, `process_status_descr_en-uk`, `process_status_descr_en-ie`, `process_status_descr_ee-ee`,
`process_status_descr_fi-fi`, `process_status_descr_fr-fr`, `process_status_descr_fr-be`, `process_status_descr_gr-gr`,
`process_status_descr_it-it`, `process_status_descr_hr-hr`, `process_status_descr_lv-lv`, `process_status_descr_lt-lt`,
`process_status_descr_nl-nl`, `process_status_descr_nl-be`, `process_status_descr_pl-pl`,
`process_status_descr_pt-_u0028_brasil_u0029_`, `process_status_descr_ro-ro`, `process_status_descr_se-se`,
`process_status_descr_rs-rs_2`, `process_status_descr_sk-sk`, `process_status_descr_si-si`, `process_status_descr_es-es`,
`process_status_descr_cz-cz`, `process_status_descr_hu-hu`, dwh_created_tmsp, dwh_updated_tmsp) AS SELECT *
FROM ugs_aris_production_core.t_dim_process_status_lng_2;