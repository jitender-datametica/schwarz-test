CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_abt_per_1 (abt_id, arthiertyp_id, mandant_id, dat_von,
dat_bis, td_insert, td_update) AS SELECT abt_id,
 arthiertyp_id,
 mandant_id,
 dat_von,
 dat_bis,
 td_insert,
 td_update
FROM kfl_production_dbp_data.abt_per_1;