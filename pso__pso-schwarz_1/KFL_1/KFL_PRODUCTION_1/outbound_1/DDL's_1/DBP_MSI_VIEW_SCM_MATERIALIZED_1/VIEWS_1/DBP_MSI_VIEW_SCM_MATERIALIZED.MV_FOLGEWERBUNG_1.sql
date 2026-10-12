CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_folgewerbung_1 (mandant_id, wup_id, nb_id, art_id,
kjwo, kjwo_werbung, aktion_thema_id_folgewerbung, aktion_thema_bez_folgewerbung, kjwo_naechste_folgewerbung,
kjwo_letzte_folgewerbung) AS SELECT WKW.mandant_id,
 V05.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 WKW.art_id,
 WKW.kjwo,
 WKW.kjwo AS kjwo_werbung,
 akt.aktion_thema_id AS aktion_thema_id_folgewerbung,
 akt.aktion_thema_bez AS aktion_thema_bez_folgewerbung,
 MIN(akt.kjwo_von) AS kjwo_naechste_folgewerbung,
 MAX(akt.kjwo_von) AS kjwo_letzte_folgewerbung
FROM kfl_production_dbp_view.v_werbung_kennzahlen_woche_1 AS WKW
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON WKW.mandant_id = V05.mandant_id AND WKW.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, -111) AND V05.wup_id > 0 OR V05.nb_id = -1 AND V05.wup_id = 0)
 LEFT JOIN (SELECT AAW.mandant_id,
   AAW.wup_id,
   AAW.art_id,
   COALESCE(ATS.aktion_thema_id, '0') AS aktion_thema_id,
   COALESCE(ATS.aktion_thema_bez, 'N/A') AS aktion_thema_bez,
   A.kjwo_von
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS AAW
   INNER JOIN kfl_production_dbp_view.v_aktion_1 AS A ON AAW.mandant_id = A.mandant_id AND AAW.aktion_id = A.aktion_id
   LEFT JOIN kfl_production_dbp_view.v_aktion_thema_spr_zu_1 AS ATS ON AAW.mandant_id = ATS.mandant_id AND AAW.aktion_thema_id
      = ATS.aktion_thema_id) AS akt ON WKW.mandant_id = akt.mandant_id AND WKW.art_id = akt.art_id AND WKW.wup_id = akt
    .wup_id AND WKW.kjwo < akt.kjwo_von
WHERE COALESCE(WKW.avq_relevant_fg, 1) = 1
 AND WKW.kjwo IN (SELECT kjwo
   FROM kfl_production_dbp_view.v_tag_1
   WHERE akt_kj BETWEEN -2 AND 1
   GROUP BY kjwo)
GROUP BY WKW.mandant_id,
 wup_id,
 nb_id,
 WKW.art_id,
 WKW.kjwo,
 kjwo_werbung,
 aktion_thema_id_folgewerbung,
 aktion_thema_bez_folgewerbung;