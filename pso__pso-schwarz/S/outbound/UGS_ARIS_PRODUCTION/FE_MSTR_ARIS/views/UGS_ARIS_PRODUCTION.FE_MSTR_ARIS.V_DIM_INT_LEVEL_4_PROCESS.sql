CREATE OR REPLACE VIEW ugs_aris_production_fe_mstr_aris.v_dim_int_level_4_process (dwh_tenant_cd, country_org_sid,
int_process_sid, lvl_4_process_sid, process_name, `process_name_bg-bg`, `process_name_dk-dk`, `process_name_de-de`,
`process_name_en-us`, `process_name_en-uk`, `process_name_en-ie`, `process_name_ee-ee`, `process_name_fi-fi`,
`process_name_fr-fr`, `process_name_fr-be`, `process_name_gr-gr`, `process_name_it-it`, `process_name_hr-hr`,
`process_name_lv-lv`, `process_name_lt-lt`, `process_name_nl-nl`, `process_name_nl-be`, `process_name_pl-pl`,
`process_name_pt-_u0028_brasil_u0029_`, `process_name_ro-ro`, `process_name_se-se`, `process_name_rs-rs`,
`process_name_sk-sk`, `process_name_si-si`, `process_name_es-es`, `process_name_cz-cz`, `process_name_hu-hu`, path_name
, last_change_dt, lvl_3_process_sid, is_dummy, referenz) AS SELECT T1.dwh_tenant_cd,
 T1.country_org_sid,
 T1.process_sid AS int_process_sid,
 T1.process_sid AS lvl_4_process_sid,
 T2.process_name,
 T2.`process_name_bg-bg`,
 T2.`process_name_dk-dk`,
 T2.`process_name_de-de`,
 T2.`process_name_en-us`,
 T2.`process_name_en-uk`,
 T2.`process_name_en-ie`,
 T2.`process_name_ee-ee`,
 T2.`process_name_fi-fi`,
 T2.`process_name_fr-fr`,
 T2.`process_name_fr-be`,
 T2.`process_name_gr-gr`,
 T2.`process_name_it-it`,
 T2.`process_name_hr-hr`,
 T2.`process_name_lv-lv`,
 T2.`process_name_lt-lt`,
 T2.`process_name_nl-nl`,
 T2.`process_name_nl-be`,
 T2.`process_name_pl-pl`,
 T2.`process_name_pt-_u0028_brasil_u0029_`,
 T2.`process_name_ro-ro`,
 T2.`process_name_se-se`,
 T2.`process_name_rs-rs`,
 T2.`process_name_sk-sk`,
 T2.`process_name_si-si`,
 T2.`process_name_es-es`,
 T2.`process_name_cz-cz`,
 T2.`process_name_hu-hu`,
 T1.path_name,
 T1.last_change_dt,
  CASE
  WHEN T1.lvl_nr = 4
  THEN T1.lvl_3_process_sid
  ELSE CAST(T1.process_sid AS STRING)
  END AS lvl_3_process_sid,
  CASE
  WHEN T1.lvl_nr = 4
  THEN 0
  ELSE 1
  END AS is_dummy,
 1 AS referenz
FROM ugs_aris_production_fe_mstr_aris.v_dim_process AS T1
 LEFT JOIN ugs_aris_production_fe_mstr_aris.v_dim_process_name_lng AS T2 ON T1.int_process_sid = T2.process_sid
WHERE T1.process_scope_cd = 'INTEGER '
 AND T1.lvl_nr IN (1, 2, 3, 4);