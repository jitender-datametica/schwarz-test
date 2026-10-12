CREATE OR REPLACE VIEW kfl_production_dbp_view.v_immo_anrede_spr_zu AS SELECT mandant_id,
 anrede_id,
 spr_id,
 anrede_bez
FROM kfl_production_dbp_data.immo_anrede_spr_zu;