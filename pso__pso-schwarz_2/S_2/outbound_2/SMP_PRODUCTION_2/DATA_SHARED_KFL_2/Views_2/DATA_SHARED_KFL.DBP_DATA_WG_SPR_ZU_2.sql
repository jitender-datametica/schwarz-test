CREATE OR REPLACE VIEW smp_production_data_shared_kfl.dbp_data_wg_spr_zu_2 (wg_id, arthiertyp_id, mandant_id, spr_id,
wg_bez, td_update, td_insert) AS SELECT wg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 wg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wg_spr_zu_2;