CREATE OR REPLACE VIEW kfl_production_dbp_view.v_markant_spr_zu AS SELECT mandant_id,
 markant_id,
 spr_id,
 markant_bez
FROM kfl_production_dbp_data.markant_spr_zu;