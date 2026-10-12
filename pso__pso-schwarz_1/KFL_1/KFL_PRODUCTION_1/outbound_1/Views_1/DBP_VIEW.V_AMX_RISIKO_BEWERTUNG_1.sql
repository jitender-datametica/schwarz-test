CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_risiko_bewertung_1 AS SELECT risiko_bewertung_id,
 amx_system_id,
 risiko_wert_von,
 risiko_wert_bis,
 risiko_farbe,
 td_update,
 td_insert
FROM kfl_production_dbp_data.amx_risiko_bewertung_1;