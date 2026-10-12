CREATE OR REPLACE VIEW kfl_production_dbp_view.v_drehklasse_spr_zu AS SELECT mandant_id,
 drehklasse_kz,
 spr_id,
 drehklasse_bez
FROM kfl_production_dbp_data.drehklasse_spr_zu;