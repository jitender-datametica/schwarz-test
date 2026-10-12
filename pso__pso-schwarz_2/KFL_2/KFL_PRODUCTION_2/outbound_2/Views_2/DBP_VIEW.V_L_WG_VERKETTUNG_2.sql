CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_wg_verkettung_2 AS SELECT mandant_id,
 wg_verkett_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_wg_verkettung_2;