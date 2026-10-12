CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_process_change_level_lng (process_change_lvl_cd,
process_change_lvl_descr, `process_change_lvl_descr_bg-bg`, `process_change_lvl_descr_dk-dk`,
`process_change_lvl_descr_de-de`, `process_change_lvl_descr_en-us`, `process_change_lvl_descr_en-uk`,
`process_change_lvl_descr_en-ie`, `process_change_lvl_descr_ee-ee`, `process_change_lvl_descr_fi-fi`,
`process_change_lvl_descr_fr-fr`, `process_change_lvl_descr_fr-be`, `process_change_lvl_descr_gr-gr`,
`process_change_lvl_descr_it-it`, `process_change_lvl_descr_hr-hr`, `process_change_lvl_descr_lv-lv`,
`process_change_lvl_descr_lt-lt`, `process_change_lvl_descr_nl-nl`, `process_change_lvl_descr_nl-be`,
`process_change_lvl_descr_pl-pl`, `process_change_lvl_descr_pt-_u0028_brasil_u0029_`, `process_change_lvl_descr_ro-ro`,
`process_change_lvl_descr_se-se`, `process_change_lvl_descr_rs-rs`, `process_change_lvl_descr_sk-sk`,
`process_change_lvl_descr_si-si`, `process_change_lvl_descr_es-es`, `process_change_lvl_descr_cz-cz`,
`process_change_lvl_descr_hu-hu`, process_change_lvl_legende, `process_change_lvl_legende_bg-bg`,
`process_change_lvl_legende_dk-dk`, `process_change_lvl_legende_de-de`, `process_change_lvl_legende_en-us`,
`process_change_lvl_legende_en-uk`, `process_change_lvl_legende_en-ie`, `process_change_lvl_legende_ee-ee`,
`process_change_lvl_legende_fi-fi`, `process_change_lvl_legende_fr-fr`, `process_change_lvl_legende_fr-be`,
`process_change_lvl_legende_gr-gr`, `process_change_lvl_legende_it-it`, `process_change_lvl_legende_hr-hr`,
`process_change_lvl_legende_lv-lv`, `process_change_lvl_legende_lt-lt`, `process_change_lvl_legende_nl-nl`,
`process_change_lvl_legende_nl-be`, `process_change_lvl_legende_pl-pl`, `process_change_lvl_legende_pt-_u0028_brasil_u0029_`
, `process_change_lvl_legende_ro-ro`, `process_change_lvl_legende_se-se`, `process_change_lvl_legende_rs-rs`,
`process_change_lvl_legende_sk-sk`, `process_change_lvl_legende_si-si`, `process_change_lvl_legende_es-es`,
`process_change_lvl_legende_cz-cz`, `process_change_lvl_legende_hu-hu`, rank, dwh_created_tmsp, dwh_updated_tmsp) AS
SELECT *
FROM ugs_aris_production_core.t_dim_process_change_level_lng;