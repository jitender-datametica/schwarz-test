CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_risiko_bewertung_1 (risiko_bewertung_id, amx_system_id,
risiko_wert_von, risiko_wert_bis, risiko_farbe, td_update, td_insert) AS SELECT *
FROM kfl_production_dbp_data.amx_risiko_bewertung_1;