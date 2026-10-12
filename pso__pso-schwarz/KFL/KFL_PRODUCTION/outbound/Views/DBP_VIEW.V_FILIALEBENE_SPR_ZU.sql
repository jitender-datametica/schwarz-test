CREATE OR REPLACE VIEW kfl_production_dbp_view.v_filialebene_spr_zu AS SELECT filialebene_id,
 spr_id,
 mandant_id,
 filialebene_bez
FROM kfl_production_dbp_data.filialebene_spr_zu;