CREATE OR REPLACE VIEW kfl_production_dbp_view.v_eps_druck_anlass_spr_zu AS SELECT mandant_id,
 druck_anlass_id,
 spr_id,
 druck_anlass_bez
FROM kfl_production_dbp_data.eps_druck_anlass_spr_zu;