CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_mwst_per_2 (mwst_id, dat_von, mandant_id, mwst, dat_bis,
mwst_bez, spr_id, sap_mwst_id, td_insert, td_update) AS SELECT mwst_id,
 dat_von,
 mandant_id,
 mwst,
 dat_bis,
 mwst_bez,
 spr_id,
 sap_mwst_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.mwst_per_2;