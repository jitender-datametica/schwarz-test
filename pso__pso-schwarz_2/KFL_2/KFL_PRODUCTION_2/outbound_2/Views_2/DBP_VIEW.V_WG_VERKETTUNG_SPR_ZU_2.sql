CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wg_verkettung_spr_zu_2 AS SELECT mandant_id,
 wg_verkett_id,
 spr_id,
 wg_verkett_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.wg_verkettung_spr_zu_2;