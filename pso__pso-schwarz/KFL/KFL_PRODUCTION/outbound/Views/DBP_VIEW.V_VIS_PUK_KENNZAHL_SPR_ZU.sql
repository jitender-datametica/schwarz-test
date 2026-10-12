CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_puk_kennzahl_spr_zu AS SELECT kennzahl_id,
 spr_id,
 kennzahl_bez
FROM kfl_production_dbp_data.vis_puk_kennzahl_spr_zu;