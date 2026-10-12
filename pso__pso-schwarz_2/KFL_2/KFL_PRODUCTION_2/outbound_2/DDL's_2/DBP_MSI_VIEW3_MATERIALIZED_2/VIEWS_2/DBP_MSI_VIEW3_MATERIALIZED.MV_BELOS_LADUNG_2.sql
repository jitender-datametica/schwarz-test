CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_belos_ladung_2 (mandant_id, belos_ladung_id,
spedition_hub_id, gewicht_gesamt, anzahl_auftrag) AS SELECT mandant_id,
 belos_ladung_id,
 COALESCE(spedition_hub_id, -1) AS spedition_hub_id,
 gewicht_gesamt,
 anzahl_auftrag
FROM kfl_production_dbp_view.v_belos_ladung_2;