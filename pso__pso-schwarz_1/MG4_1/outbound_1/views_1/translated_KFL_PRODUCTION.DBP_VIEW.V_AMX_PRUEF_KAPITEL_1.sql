CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_pruef_kapitel_1 (pruef_kapitel_id, amx_system_id, pruefung_id,
pruef_kapitel_bez, hauptbereich_id, teilbereich_id, kapitel_ergebnis_wert, td_insert, td_update) AS SELECT *
FROM kfl_production_dbp_data.amx_pruef_kapitel_1;