CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_artkz_posten_1 (posten_id, mandant_id, spr_id, posten_bez,
td_insert, td_update) AS SELECT posten_id,
 mandant_id,
 spr_id,
 posten_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.artkz_posten_1;