CREATE OR REPLACE VIEW kfl_production_dbp_view.v_dienstleister_spr_zu AS SELECT mandant_id,
 dienstleister_id,
 spr_id,
 dienstleister_bez
FROM kfl_production_dbp_data.dienstleister_spr_zu;