CREATE OR REPLACE VIEW kfl_production_dbp_view.v_sonderabwicklung_spr_zu AS SELECT mandant_id,
 sonderabwicklung_id,
 spr_id,
 sonderabwicklung_bez
FROM kfl_production_dbp_data.sonderabwicklung_spr_zu;