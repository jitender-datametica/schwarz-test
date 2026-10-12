CREATE OR REPLACE VIEW kfl_production_dbp_view.v_belos_ladung_1 AS SELECT mandant_id,
 belos_ladung_id,
 spedition_hub_id,
 gewicht_gesamt,
 anzahl_auftrag,
 zusatz_spot
FROM kfl_production_dbp_data.belos_ladung_1;