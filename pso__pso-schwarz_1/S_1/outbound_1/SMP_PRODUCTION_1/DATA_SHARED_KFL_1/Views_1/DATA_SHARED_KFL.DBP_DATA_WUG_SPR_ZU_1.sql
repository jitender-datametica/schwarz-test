CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_wug_spr_zu_1 (arthiertyp_id, mandant_id, wg_id, spr_id,
wug_id, wug_bez, td_update, td_insert) AS SELECT arthiertyp_id,
 mandant_id,
 wg_id,
 spr_id,
 wug_id,
 wug_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wug_spr_zu_1;