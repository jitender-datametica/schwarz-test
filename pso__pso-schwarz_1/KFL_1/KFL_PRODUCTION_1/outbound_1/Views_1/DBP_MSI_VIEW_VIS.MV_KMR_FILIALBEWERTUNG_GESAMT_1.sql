CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_filialbewertung_gesamt_1 (mandant_id, nb_id, wup_id, kjmo,
kmr_gesamt_anzahl, kmr_gesamt_ok, kmr_gesamt_nok, kmr_gesamt_ges) AS SELECT kmr.mandant_id,
 kmr.nb_id,
 kmr.wup_id,
 ZEIT.kjmo,
 COUNT(DISTINCT kmr.pruefung_id) AS kmr_gesamt_pruefung,
 SUM(kmr.ergebnis_ok) AS kmr_gesamt_ok,
 SUM(kmr.ergebnis_nok) AS kmr_gesamt_nok,
 SUM(kmr.ergebnis_anz) AS kmr_gesamt_anz
FROM (SELECT WUP.mandant_id,
   WUP.nb_id,
   WUP.aktuell_wup_id AS wup_id,
   KMR_PRF.dat_pruef_zeitraum_bis AS dat,
   KMR_FRG.sort_nr,
   ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 12, 4) AS BIGNUMERIC), 0) AS frage_nr,
   ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 14, 2) AS BIGNUMERIC), 0) AS bereich_nr,
   ROUND(CAST(SUBSTR(KMR_FRG.sort_nr, 12, 2) AS BIGNUMERIC), 0) AS kategorie_nr,
   KMR_FRG.ergebnis_num,
   KMR_FRG.ergebnis_text,
    CASE
    WHEN KMR_FRG.ergebnis_num = 0
    THEN 1
    ELSE 0
    END AS ergebnis_ok,
    CASE
    WHEN KMR_FRG.ergebnis_num = 1
    THEN 1
    ELSE 0
    END AS ergebnis_nok,
    CASE
    WHEN KMR_FRG.ergebnis_num >= 0
    THEN 1
    ELSE 0
    END AS ergebnis_anz,
    CASE
    WHEN KMR_FRG.ergebnis_num = - 1
    THEN 1
    ELSE 0
    END AS ergebnis_na,
   KMR_KAP.pruefung_id
  FROM kfl_production_dbp_view.v_kmr_frage_1 AS KMR_FRG
   INNER JOIN kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel_1 AS KMR_KAP ON KMR_FRG.kapitel_id = KMR_KAP.kapitel_id
    AND KMR_FRG.amx_system_id = KMR_KAP.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_pruefung_1 AS KMR_PRF ON KMR_KAP.pruefung_id = KMR_PRF.pruefung_id AND KMR_KAP
     .amx_system_id = KMR_PRF.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefung_klasse_1 AS KMR_LPK ON KMR_PRF.pruefung_klasse_id = KMR_LPK.pruefung_klasse_id
      AND KMR_PRF.amx_system_id = KMR_LPK.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefung_status_1 AS KMR_LPS ON KMR_PRF.pruefung_status_id = KMR_LPS.pruefung_status_id
      AND KMR_PRF.amx_system_id = KMR_LPS.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_organisationseinheit_1 AS KMR_LOE ON KMR_PRF.gepr_oe_id = KMR_LOE.orga_einheit_id
      AND KMR_PRF.amx_system_id = KMR_LOE.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON KMR_LOE.wup_id = WUP.wup_id AND KMR_LOE.mandant_id = WUP.mandant_id
     
   INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefprozess_1 AS KMR_LPP ON KMR_KAP.gepr_prozess_id = KMR_LPP.gepr_prozess_id
      AND KMR_KAP.amx_system_id = KMR_LPP.amx_system_id
  WHERE KMR_FRG.amx_system_id = 1
   AND KMR_PRF.pruefung_klasse_id IN (100003)
   AND KMR_PRF.pruefung_status_id IN (100005, 100041)
   AND ROUND(SAFE_CAST(SUBSTR(KMR_FRG.sort_nr, 12, 4) AS BIGNUMERIC), 0) = 0
   AND WUP.mandant_id <> 1) AS kmr
 INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT_1 ON kmr.dat = ZEIT.dat
GROUP BY kmr.mandant_id,
 kmr.nb_id,
 kmr.wup_id,
 ZEIT.kjmo
UNION ALL
SELECT amx.mandant_id,
 amx.nb_id,
 amx.wup_id,
 ZEIT.kjmo,
 COUNT(DISTINCT amx.pruefung_id) AS kmr_gesamt_pruefung,
 SUM(amx.antwort_ok) AS kmr_gesamt_ok,
 SUM(amx.antwort_nok) AS kmr_gesamt_nok,
 SUM(amx.antwort_ges) AS kmr_gesamt_anz
FROM (SELECT WUP.mandant_id,
   WUP.nb_id,
   WUP.aktuell_wup_id AS wup_id,
   amx_prf.dat_ende,
   amx_prf.pruefung_id,
    CASE
    WHEN amx_frg.antwort_wert IN (1, 4)
    THEN 1
    ELSE 0
    END AS antwort_nok,
    CASE
    WHEN amx_frg.antwort_wert IN (0)
    THEN 1
    ELSE 0
    END AS antwort_ok,
    CASE
    WHEN amx_frg.antwort_wert IN (0, 1, 4)
    THEN 1
    ELSE 0
    END AS antwort_ges
  FROM (SELECT amx_frage_id,
     pruef_kapitel_id,
     antwort_wert,
     amx_frage_katalog_id
    FROM kfl_production_dbp_view.v_amx_frage_1
    WHERE amx_system_id = 1
     AND antwort_wert IN (0, 1, 4)) AS amx_frg
   INNER JOIN (SELECT amx_frage_katalog_id,
     hauptbereich_id,
     teilbereich_id,
     amx_handlung_typ_id
    FROM kfl_production_dbp_view.v_amx_frage_katalog_1
    WHERE amx_system_id = 1
     AND hauptbereich_id = 597230
     AND teilbereich_id = 597253
     AND amx_handlung_typ_id IN (1, 50000)
     AND SUBSTR(frage_nr, 6, 25) NOT IN (SELECT platzhalter_string
       FROM kfl_production_dbp_view.v_amx_filter_benutzeroberflaeche_1
       WHERE amx_system_id = 1
        AND amx_filter_typ_id = 3)) AS amx_kat ON amx_frg.amx_frage_katalog_id = amx_kat.amx_frage_katalog_id
   INNER JOIN (SELECT pruef_kapitel_id,
     pruefung_id
    FROM kfl_production_dbp_view.v_amx_pruef_kapitel_1
    WHERE amx_system_id = 1) AS amx_kap ON amx_frg.pruef_kapitel_id = amx_kap.pruef_kapitel_id
   INNER JOIN (SELECT business_process_id,
     pruefung_id
    FROM kfl_production_dbp_view.v_amx_b_process_pruefung_zu_1
    WHERE amx_system_id = 1
     AND business_process_id = 544687) AS amx_bpp ON amx_kap.pruefung_id = amx_bpp.pruefung_id
   INNER JOIN (SELECT mandant_id,
     wup_id,
     pruefung_id,
     dat_ende
    FROM kfl_production_dbp_view.v_amx_pruefung_1
    WHERE amx_system_id = 1
     AND zustand_id IN (100003, 100004, 100005, 1001, 100025, 100041)) AS amx_prf ON amx_kap.pruefung_id = amx_prf.pruefung_id
    
   INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON amx_prf.wup_id = WUP.wup_id AND amx_prf.mandant_id = WUP.mandant_id
  WHERE WUP.mandant_id <> 1) AS amx
 INNER JOIN kfl_production_dbp_data.tag_1 AS ZEIT_1 ON amx.dat_ende = ZEIT.dat
GROUP BY amx.mandant_id,
 amx.nb_id,
 amx.wup_id,
 ZEIT.kjmo;