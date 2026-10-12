CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wetterzustand_spr_zu AS SELECT wetterzustand_id,
 spr_id,
 wetterzustand_bez
FROM kfl_production_dbp_data.wetterzustand_spr_zu;