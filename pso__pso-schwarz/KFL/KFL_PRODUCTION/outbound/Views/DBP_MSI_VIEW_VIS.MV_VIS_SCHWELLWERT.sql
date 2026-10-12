CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_schwellwert (mandant_id, wup_id, kjmo, sw_thema_id,
sw_attribut_id, sw_attribut_wert, vis_schwellwert) AS SELECT mandant_id,
 wup_id,
 kjmo,
 sw_thema_id,
 sw_attribut_id,
 sw_attribut_wert,
 vis_schwellwert
FROM kfl_production_dbp_view.v_vis_schwellwert;