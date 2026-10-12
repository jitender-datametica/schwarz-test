CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_kurzcheck_ergebnis_2 AS WITH KMR AS (SELECT WUP.mandant_id,
   WUP.nb_id,
   WUP.aktuell_wup_id AS wup_id,
   WUP.gf_id,
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
   KMR_FRG.frage_id,
   KMR_KAP.kapitel_id,
   KMR_KAP.sort_nr AS kapitel_sort_nr,
   KMR_KAP.gepr_prozess_id,
   KMR_KAP.pruefung_id,
   KMR_PRF.pruefung_nr,
   KMR_PRF.pruefung_bez,
   KMR_PRF.pruefung_status_id,
   KMR_PRF.tageszeit_id,
   KMR_PRF.pruefung_klasse_id,
   KMR_PRF.gepr_oe_id AS orga_einheit_id
  FROM kfl_production_dbp_view.v_kmr_frage_2 AS KMR_FRG
   INNER JOIN kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel_2 AS KMR_KAP ON KMR_FRG.kapitel_id = KMR_KAP.kapitel_id
    AND KMR_FRG.amx_system_id = KMR_KAP.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_pruefung_2 AS KMR_PRF ON KMR_KAP.pruefung_id = KMR_PRF.pruefung_id AND KMR_KAP
     .amx_system_id = KMR_PRF.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefung_klasse_2 AS KMR_LPK ON KMR_PRF.pruefung_klasse_id = KMR_LPK.pruefung_klasse_id
      AND KMR_PRF.amx_system_id = KMR_LPK.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefung_status_2 AS KMR_LPS ON KMR_PRF.pruefung_status_id = KMR_LPS.pruefung_status_id
      AND KMR_PRF.amx_system_id = KMR_LPS.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_organisationseinheit_2 AS KMR_LOE ON KMR_PRF.gepr_oe_id = KMR_LOE.orga_einheit_id
      AND KMR_PRF.amx_system_id = KMR_LOE.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON KMR_LOE.wup_id = WUP.wup_id AND KMR_LOE.mandant_id = WUP.mandant_id
     
   INNER JOIN kfl_production_dbp_view.v_kmr_l_pruefprozess_2 AS KMR_LPP ON KMR_KAP.gepr_prozess_id = KMR_LPP.gepr_prozess_id
      AND KMR_KAP.amx_system_id = KMR_LPP.amx_system_id
   INNER JOIN kfl_production_dbp_view.v_kmr_l_tageszeit_2 AS KMR_LTZ ON KMR_PRF.tageszeit_id = KMR_LTZ.tageszeit_id AND
     KMR_PRF.amx_system_id = KMR_LTZ.amx_system_id
  WHERE KMR_FRG.amx_system_id = 1
   AND KMR_PRF.pruefung_klasse_id IN (100003)
   AND KMR_PRF.pruefung_status_id IN (100005, 100041)) (SELECT *
  FROM (SELECT mandant_id,
      nb_id,
      wup_id,
      dat,
      pruefung_nr AS kmr_pruefung_nr,
      sort_nr AS kmr_sort_nr,
      frage_nr AS kmr_frage_nr,
      bereich_nr AS kmr_bereich_nr,
      kategorie_nr AS kmr_kategorie_nr,
      SUM(ergebnis_ok) AS kmr_ergebnis_ok,
      SUM(ergebnis_nok) AS kmr_ergebnis_nok,
      SUM(ergebnis_anz) AS kmr_ergebnis_anz,
      SUM(ergebnis_na) AS kmr_ergebnis_na
     FROM KMR
     WHERE mandant_id > 1
     GROUP BY mandant_id,
      nb_id,
      wup_id,
      dat,
      kmr_pruefung_nr,
      kmr_sort_nr,
      kmr_frage_nr,
      kmr_bereich_nr,
      kmr_kategorie_nr
     UNION ALL
     SELECT mandant_id,
      nb_id,
      wup_id,
      dat,
      pruefung_nr AS kmr_pruefung_nr,
        LEFT(sort_nr, 11) || '00' || RIGHT(sort_nr, 5) AS kmr_sort_nr,
      bereich_nr AS kmr_frage_nr,
      bereich_nr AS kmr_bereich_nr,
      0 AS kmr_kategorie_nr,
      SUM(ergebnis_ok) AS kmr_ergebnis_ok,
      SUM(ergebnis_nok) AS kmr_ergebnis_nok,
      SUM(ergebnis_anz) AS kmr_ergebnis_anz,
      SUM(ergebnis_na) AS kmr_ergebnis_na
     FROM KMR
     WHERE mandant_id > 1
      AND ROUND(SAFE_CAST(SUBSTR(sort_nr, 12, 4) AS BIGNUMERIC), 0) > 0
     GROUP BY mandant_id,
      nb_id,
      wup_id,
      dat,
      kmr_pruefung_nr,
      kmr_sort_nr,
      kmr_frage_nr,
      kmr_bereich_nr,
      kmr_kategorie_nr
     UNION ALL
     SELECT mandant_id,
      nb_id,
      wup_id,
      dat,
      pruefung_nr AS kmr_pruefung_nr,
        LEFT(sort_nr, 13) || '00' || RIGHT(sort_nr, 3) AS kmr_sort_nr,
       kategorie_nr * 100 AS kmr_frage_nr,
      0 AS kmr_bereich_nr,
      kategorie_nr AS kmr_kategorie_nr,
      SUM(ergebnis_ok) AS kmr_ergebnis_ok,
      SUM(ergebnis_nok) AS kmr_ergebnis_nok,
      SUM(ergebnis_anz) AS kmr_ergebnis_anz,
      SUM(ergebnis_na) AS kmr_ergebnis_na
     FROM KMR
     WHERE mandant_id > 1
      AND ROUND(SAFE_CAST(SUBSTR(sort_nr, 12, 4) AS BIGNUMERIC), 0) > 0
     GROUP BY mandant_id,
      nb_id,
      wup_id,
      dat,
      kmr_pruefung_nr,
      kmr_sort_nr,
      kmr_frage_nr,
      kmr_bereich_nr,
      kmr_kategorie_nr
     UNION ALL
     SELECT mandant_id,
      - 1 AS nb_id,
      gf_id AS wup_id,
      dat,
      pruefung_nr AS kmr_pruefung_nr,
      sort_nr AS kmr_sort_nr,
      frage_nr AS kmr_frage_nr,
      bereich_nr AS kmr_bereich_nr,
      kategorie_nr AS kmr_kategorie_nr,
      SUM(ergebnis_ok) AS kmr_ergebnis_ok,
      SUM(ergebnis_nok) AS kmr_ergebnis_nok,
      SUM(ergebnis_anz) AS kmr_ergebnis_anz,
      SUM(ergebnis_na) AS kmr_ergebnis_na
     FROM KMR
     WHERE mandant_id = 1
     GROUP BY mandant_id,
      nb_id,
      wup_id,
      dat,
      kmr_pruefung_nr,
      kmr_sort_nr,
      kmr_frage_nr,
      kmr_bereich_nr,
      kmr_kategorie_nr
     UNION ALL
     SELECT mandant_id,
      - 1 AS nb_id,
      gf_id AS wup_id,
      dat,
      pruefung_nr AS kmr_pruefung_nr,
        LEFT(sort_nr, 11) || '00' || RIGHT(sort_nr, 5) AS kmr_sort_nr,
      bereich_nr AS kmr_frage_nr,
      bereich_nr AS kmr_bereich_nr,
      0 AS kmr_kategorie_nr,
      SUM(ergebnis_ok) AS kmr_ergebnis_ok,
      SUM(ergebnis_nok) AS kmr_ergebnis_nok,
      SUM(ergebnis_anz) AS kmr_ergebnis_anz,
      SUM(ergebnis_na) AS kmr_ergebnis_na
     FROM KMR
     WHERE mandant_id = 1
      AND ROUND(SAFE_CAST(SUBSTR(sort_nr, 12, 4) AS BIGNUMERIC), 0) > 0
     GROUP BY mandant_id,
      nb_id,
      wup_id,
      dat,
      kmr_pruefung_nr,
      kmr_sort_nr,
      kmr_frage_nr,
      kmr_bereich_nr,
      kmr_kategorie_nr
     UNION ALL
     SELECT mandant_id,
      - 1 AS nb_id,
      gf_id AS wup_id,
      dat,
      pruefung_nr AS kmr_pruefung_nr,
        LEFT(sort_nr, 13) || '00' || RIGHT(sort_nr, 3) AS kmr_sort_nr,
       kategorie_nr * 100 AS kmr_frage_nr,
      0 AS kmr_bereich_nr,
      kategorie_nr AS kmr_kategorie_nr,
      SUM(ergebnis_ok) AS kmr_ergebnis_ok,
      SUM(ergebnis_nok) AS kmr_ergebnis_nok,
      SUM(ergebnis_anz) AS kmr_ergebnis_anz,
      SUM(ergebnis_na) AS kmr_ergebnis_na
     FROM KMR
     WHERE mandant_id = 1
      AND ROUND(SAFE_CAST(SUBSTR(sort_nr, 12, 4) AS BIGNUMERIC), 0) > 0
     GROUP BY mandant_id,
      nb_id,
      wup_id,
      dat,
      kmr_pruefung_nr,
      kmr_sort_nr,
      kmr_frage_nr,
      kmr_bereich_nr,
      kmr_kategorie_nr));