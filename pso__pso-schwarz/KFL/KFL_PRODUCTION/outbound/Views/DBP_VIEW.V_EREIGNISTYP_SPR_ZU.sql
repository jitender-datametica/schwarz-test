CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ereignistyp_spr_zu AS SELECT ereignistyp_id,
 ereignistyp_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_data.ereignistyp_spr_zu;