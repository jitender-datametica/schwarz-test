CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_wg_per (mandant_id, wg_id, arthiertyp_id, dat_von,
lead_mwst_id, abt_id, dat_bis, owg_id, td_update, td_insert) AS SELECT mandant_id,
 wg_id,
 arthiertyp_id,
 dat_von,
 lead_mwst_id,
 abt_id,
 dat_bis,
 owg_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wg_per;