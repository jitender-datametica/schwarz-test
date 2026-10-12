CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_artkz_eigenmarke_1 (eigenmarke_id, mandant_id, spr_id,
eigenmarke_bez, td_update, td_insert) AS SELECT eigenmarke_id,
 mandant_id,
 spr_id,
 eigenmarke_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.artkz_eigenmarke_1;