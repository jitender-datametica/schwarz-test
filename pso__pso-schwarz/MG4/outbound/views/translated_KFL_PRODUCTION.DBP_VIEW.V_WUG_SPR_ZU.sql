CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wug_spr_zu (arthiertyp_id, mandant_id, wg_id, spr_id, wug_id, wug_bez,
td_update, td_insert) AS SELECT arthiertyp_id,
 mandant_id,
 wg_id,
 spr_id,
 wug_id,
 wug_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wug_spr_zu;