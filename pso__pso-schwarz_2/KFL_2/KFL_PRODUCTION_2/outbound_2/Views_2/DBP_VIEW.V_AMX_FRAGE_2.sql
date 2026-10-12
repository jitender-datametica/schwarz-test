CREATE OR REPLACE VIEW kfl_production_dbp_view.v_amx_frage_2 AS SELECT amx_frage_id,
 amx_system_id,
 pruef_kapitel_id,
 antwort_wert,
 amx_frage_katalog_id,
 anmerkung,
 eingabe,
 anz_fehler_amx,
 stichprobe_umfang,
 frage_gewichtung,
 antwort_wert_text,
 td_insert,
 td_update
FROM kfl_production_dbp_data.amx_frage_2;