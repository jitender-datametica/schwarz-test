CREATE OR REPLACE VIEW kfl_production_dbp_view.v_hyg_spr_zu AS SELECT hyg_text_id,
 gj,
 hyg_ref_id,
 spr_id,
 hyg_column,
 hyg_text
FROM kfl_production_dbp_data.hyg_spr_zu;