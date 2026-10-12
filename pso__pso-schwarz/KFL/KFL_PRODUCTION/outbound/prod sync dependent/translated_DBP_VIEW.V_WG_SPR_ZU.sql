CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_spr_zu (wg_id, arthiertyp_id, mandant_id, spr_id, wg_bez, td_update
, td_insert) AS SELECT wg_id,
 arthiertyp_id,
 mandant_id,
 spr_id,
 wg_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wg_spr_zu;