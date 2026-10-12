CREATE OR REPLACE VIEW kfl_production_dbp_view.v_zaehl_grund_spr_zu_2 AS SELECT mandant_id,
 zaehl_grund_id,
 spr_id,
 zaehl_grund_bez
FROM kfl_production_dbp_data.zaehl_grund_spr_zu_2;