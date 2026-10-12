CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tupel_spr_zu AS SELECT mandant_id,
 matching_id,
 kjwo_update,
 spr_id,
 tupel_bez
FROM kfl_production_dbp_data.tupel_spr_zu;