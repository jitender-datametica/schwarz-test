CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_quartal_kj_1 (kjqu, kj, akt_kjqu, akt_kjqu_komplett, akt_kj
, akt_kj_komplett, td_insert, td_update) AS SELECT kjqu,
 kj,
 akt_kjqu,
 akt_kjqu_komplett,
 akt_kj,
 akt_kj_komplett,
 td_insert,
 td_update
FROM kfl_production_dbp_data.quartal_kj_1;