CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belegart_gruppe_spr_zu AS SELECT system_id,
 mandant_id,
 belegart_gruppe_id,
 spr_id,
 belegart_gruppe_bez
FROM kfl_production_dbp_data.belegart_gruppe_spr_zu;