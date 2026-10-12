-- 20221116 twie: SPEC0166860 neue audimex View für Frage

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_kmr_frage_1 (amx_system_id, frage_id, sort_nr, frage_text,
anmerkung, kapitel_id, frage_status_id, frage_typ_id, stichprobe_umfang, ergebnis_num, ergebnis_text, ergebnis_man,
aufgedeckte_fehler_anz, feststellungen_anz, massnahmen_anz) AS SELECT amx_system_id,
 frage_id,
 sort_nr,
 frage_text,
 anmerkung,
 kapitel_id,
 frage_status_id,
 frage_typ_id,
 stichprobe_umfang,
 ergebnis_num,
 ergebnis_text,
 ergebnis_man,
 aufgedeckte_fehler_anz,
 feststellungen_anz,
 massnahmen_anz
FROM kfl_production_dbp_view.v_kmr_frage_1;