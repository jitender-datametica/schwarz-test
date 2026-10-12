CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_frage_2 (amx_frage_id, pruef_kapitel_id, antwort_wert,
amx_frage_katalog_id, kmr_quelle_id, anmerkung, eingabe, anz_fehler_amx, stichprobe_umfang, dat_ende) AS SELECT v01.amx_frage_id
 ,
 v01.pruef_kapitel_id,
 v01.antwort_wert,
 v01.amx_frage_katalog_id,
 1 AS kmr_quelle_id,
 v01.anmerkung,
  CASE
  WHEN v01.antwort_wert IN (0, 1, 4)
  THEN ''
  ELSE v01.eingabe
  END AS eingabe,
 v01.anz_fehler_amx,
 v01.stichprobe_umfang,
 v03.dat_ende
FROM (SELECT amx_frage_id,
    pruef_kapitel_id,
    antwort_wert,
    amx_frage_katalog_id,
    anmerkung,
    eingabe,
    anz_fehler_amx,
    stichprobe_umfang,
    frage_gewichtung,
    antwort_wert_text
   FROM kfl_production_dbp_view.v_amx_frage_2
   WHERE amx_system_id = 1
   UNION ALL
   SELECT amx_frage_id,
    pruef_kapitel_id,
    antwort_wert,
    amx_frage_katalog_id,
    anmerkung,
    eingabe,
    anz_fehler_amx,
    stichprobe_umfang,
    frage_gewichtung,
    antwort_wert_text
   FROM kfl_production_dbp_view.v_amx_de_frage_2) AS v01
 INNER JOIN (SELECT pruef_kapitel_id,
    pruefung_id,
    pruef_kapitel_bez,
    hauptbereich_id,
    teilbereich_id,
    kapitel_ergebnis_wert
   FROM kfl_production_dbp_view.v_amx_pruef_kapitel_2
   WHERE amx_system_id = 1
   UNION ALL
   SELECT pruef_kapitel_id,
    pruefung_id,
    pruef_kapitel_bez,
    hauptbereich_id,
    teilbereich_id,
    kapitel_ergebnis_wert
   FROM kfl_production_dbp_view.v_amx_de_pruef_kapitel_2) AS v02 ON v01.pruef_kapitel_id = v02.pruef_kapitel_id
 INNER JOIN (SELECT pruefung_id,
    pruefung_nr,
    zustand_id,
    pruefung_bez,
    dat_start,
    dat_ende,
    revisor_id,
    pruefung_typ_id,
    pruefung_klasse_id,
    pruefung_ergebnis_wert,
    business_unit_id,
    mandant_id,
    wup_id
   FROM kfl_production_dbp_view.v_amx_pruefung_2
   WHERE amx_system_id = 1
    AND zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)
   UNION ALL
   SELECT pruefung_id,
    pruefung_nr,
    zustand_id,
    pruefung_bez,
    dat_start,
    dat_ende,
    revisor_id,
    pruefung_typ_id,
    pruefung_klasse_id,
    pruefung_ergebnis_wert,
    business_unit_id,
    mandant_id,
    wup_id
   FROM kfl_production_dbp_view.v_amx_de_pruefung_2
   WHERE zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)) AS v03 ON v02.pruefung_id = v03.pruefung_id
 INNER JOIN (SELECT business_process_id,
    pruefung_id
   FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu_2
   WHERE amx_system_id = 1
    AND business_process_id = 544687
   UNION ALL
   SELECT business_process_id,
    pruefung_id
   FROM kfl_production_dbp_view.v_amx_de_b_process_pruefung_zu_2
   WHERE business_process_id = 544687) AS v04 ON v03.pruefung_id = v04.pruefung_id
 INNER JOIN (SELECT amx_frage_katalog_id,
   hauptbereich_id,
   teilbereich_id,
   frage_nr,
   amx_frage_bez,
   amx_handlung_typ_id
  FROM kfl_production_dbp_view.v_amx_frage_katalog_2
  WHERE amx_system_id = 1
   AND hauptbereich_id > 0
   AND SUBSTR(frage_nr, 6, 25) NOT IN (SELECT platzhalter_string
     FROM kfl_production_dbp_view.v_amx_filter_benutzeroberflaeche_2
     WHERE amx_system_id = 1
      AND amx_filter_typ_id = 3)) AS v05 ON v01.amx_frage_katalog_id = v05.amx_frage_katalog_id;