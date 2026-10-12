CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_quartal_gj_2 (gjqu, akt_gjqu, akt_gjqu_komplett, gj, akt_gj
, akt_gj_komplett, gjhj, td_insert, td_update) AS SELECT gjqu,
 akt_gjqu,
 akt_gjqu_komplett,
 gj,
 akt_gj,
 akt_gj_komplett,
 gjhj,
 td_insert,
 td_update
FROM kfl_production_dbp_data.quartal_gj_2;