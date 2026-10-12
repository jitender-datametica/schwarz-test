CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_jahr_kj_2 (kj, akt_kj, akt_kj_komplett, td_update,
td_insert) AS SELECT kj,
 akt_kj,
 akt_kj_komplett,
 td_update,
 td_insert
FROM kfl_production_dbp_data.jahr_kj_2;