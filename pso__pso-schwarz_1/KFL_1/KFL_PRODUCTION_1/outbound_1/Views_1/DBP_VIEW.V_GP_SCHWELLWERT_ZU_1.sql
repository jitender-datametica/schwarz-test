CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gp_schwellwert_zu_1 AS SELECT mandant_id,
 gp_id,
 sw_id,
 kj,
 sw_oben,
 sw_unten,
 sw_fg
FROM kfl_production_dbp_data.gp_schwellwert_zu_1;