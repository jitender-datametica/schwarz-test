CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_schwellwert_1 AS SELECT vis_schwellwert.mandant_id,
 vis_schwellwert.wup_id,
 vis_schwellwert.kjmo,
 vis_schwellwert.sw_thema_id,
 vis_schwellwert.sw_attribut_id,
 vis_schwellwert.sw_attribut_wert,
 vis_schwellwert.vis_schwellwert_1
FROM kfl_production_dbp_data.vis_schwellwert_1 AS vis_schwellwert_1;