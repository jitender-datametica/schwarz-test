CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_de_pruef_kapitel_2 AS SELECT pruef_kapitel_id,
 pruefung_id,
 pruef_kapitel_bez,
 hauptbereich_id,
 teilbereich_id,
 kapitel_ergebnis_wert
FROM kfl_production_dbp_data.amx_de_pruef_kapitel_2;