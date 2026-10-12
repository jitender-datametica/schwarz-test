CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_werbung_kennzahlen_woche_1 (mandant_id, nb_id,
wup_id, kjwo, werbe_typ_id, wtag_id_start, wtag_id_ende, posten_id, posten_fg, art_mutter_wb_id, art_mutter_display_id,
mwb_basismenge_einh_id, mwb_verpart_id, art_mutter_wb_nr, art_mutter_wb_bez, art_mutter_wb_fg, anz_art_kind,
faktor_flaki, art_id, art_display_id, art_basismenge_einh_id, art_verpart_id, menge_tag1, menge_tag2, menge_tag3,
menge_tag4, menge_tag5, menge_tag6, menge_tag7, menge, umsatz_netto_tag1, umsatz_netto_tag2, umsatz_netto_tag3,
umsatz_netto_tag4, umsatz_netto_tag5, umsatz_netto_tag6, umsatz_netto_tag7, umsatz_netto, menge_0_tag1, menge_0_tag2,
menge_0_tag3, menge_0_tag4, menge_0_tag5, menge_0_tag6, menge_0_tag7, tage_menge_0, menge_we_zentrale, menge_we,
menge_aktionsstart, menge_endbestand, min_sicherh_bestand, menge_historie_af, anzahl_nullbestand, anzahl_tage_aktion,
menge_tag1_7bis13h, we_menge_vor_aktion, sollbestand, lager_prozent, mhd_zeitraum, menge_lgbest_erp_frei_bme,
avq_relevant_fg, anzahl_nullbestand_tag1, anzahl_nullbestand_tag1bis3, anzahl_nullbestand_tag2, anzahl_nullbestand_tag3
, anzahl_nullbestand_tag4, anzahl_nullbestand_tag5, anzahl_nullbestand_tag6, anzahl_nullbestand_tag7, menge_sa,
vk_vor_aktion_brutto, vk_aktion_brutto, vk_kcard_brutto, menge_nur_tag1, aktionsklassifizierung_id) AS SELECT WKW.mandant_id
 ,
 WKW.nb_id,
 COALESCE(V05.aktuell_wup_id, WKW.wup_id) AS wup_id,
 WKW.kjwo,
 WKW.werbe_typ_id,
 WKW.wtag_id_start,
 WKW.wtag_id_ende,
 WKW.posten_id,
  CASE
  WHEN ART.posten_kz_sap <> ''
  THEN 1
  ELSE 0
  END AS posten_fg,
 WKW.mutter_wb_id AS art_mutter_wb_id,
  CASE
  WHEN MWB.artikeltyp_id = 12
  THEN MWB.artikeltyp_id
  ELSE MWB.display_id
  END AS art_mutter_display_id,
 MWB.basismenge_einh_id AS mwb_basismenge_einh_id,
 COALESCE(MWB.verpart_id, ' ') AS mwb_verpart_id,
 TRIM(CAST(CASE
    WHEN WKW.mandant_id = 1
    THEN TRUNC(CAST(WKW.mutter_wb_id / 100 AS BIGNUMERIC))
    ELSE TRUNC(CAST(WKW.mutter_wb_id / 10 AS BIGNUMERIC))
    END AS STRING FORMAT '00000000')) AS art_mutter_wb_nr,
 MSZ.art_bez AS art_mutter_wb_bez,
  CASE
  WHEN WKW.mutter_wb_id = WKW.art_id
  THEN 0
  ELSE 1
  END AS art_mutter_wb_fg,
   (RANK() OVER (PARTITION BY WKW.mandant_id, WKW.wup_id, WKW.kjwo, WKW.werbe_typ_id, WKW.mutter_wb_id ORDER BY WKW.mandant_id
      IS NULL, WKW.mandant_id, WKW.wup_id IS NULL, WKW.wup_id, WKW.kjwo IS NULL, WKW.kjwo, WKW.werbe_typ_id IS NULL, WKW
      .werbe_typ_id, WKW.mutter_wb_id IS NULL, WKW.mutter_wb_id, WKW.art_id IS NULL, WKW.art_id)) - 1 AS anz_art_kind,
 WKW.faktor_flaki,
 WKW.art_id,
  CASE
  WHEN ART.artikeltyp_id = 12
  THEN ART.artikeltyp_id
  ELSE ART.display_id
  END AS art_display_id,
 ART.basismenge_einh_id AS art_basismenge_einh_id,
 COALESCE(ART.verpart_id, ' ') AS art_verpart_id,
 WKW.menge_tag1,
 WKW.menge_tag2,
 WKW.menge_tag3,
 WKW.menge_tag4,
 WKW.menge_tag5,
 WKW.menge_tag6,
 WKW.menge_tag7,
       WKW.menge_tag1 + WKW.menge_tag2 + WKW.menge_tag3 + WKW.menge_tag4 + WKW.menge_tag5 + WKW.menge_tag6 + WKW.menge_tag7
   AS menge,
 WKW.umsatz_netto_tag1,
 WKW.umsatz_netto_tag2,
 WKW.umsatz_netto_tag3,
 WKW.umsatz_netto_tag4,
 WKW.umsatz_netto_tag5,
 WKW.umsatz_netto_tag6,
 WKW.umsatz_netto_tag7,
       WKW.umsatz_netto_tag1 + WKW.umsatz_netto_tag2 + WKW.umsatz_netto_tag3 + WKW.umsatz_netto_tag4 + WKW.umsatz_netto_tag5
     + WKW.umsatz_netto_tag6 + WKW.umsatz_netto_tag7 AS umsatz_netto,
  CASE
  WHEN WKW.menge_tag1 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag1,
  CASE
  WHEN WKW.menge_tag2 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag2,
  CASE
  WHEN WKW.menge_tag3 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag3,
  CASE
  WHEN WKW.menge_tag4 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag4,
  CASE
  WHEN WKW.menge_tag5 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag5,
  CASE
  WHEN WKW.menge_tag6 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag6,
  CASE
  WHEN WKW.menge_tag7 = 0
  THEN 1
  ELSE 0
  END AS menge_0_tag7,
 WKW.tage_menge_0,
 WKW.we_menge_zentral AS menge_we_zentrale,
 WKW.we_menge AS menge_we,
 WKW.menge_aktionsstart,
 WKW.menge_endbestand,
 WKW.min_sicherh_bestand,
 WKW.menge_historie_af,
 WKW.anzahl_nullbestand,
 WKW.anzahl_tage_aktion,
 WKW.menge_tag1_7bis13h,
 WKW.we_menge_vor_aktion,
 WKW.sollbestand,
 WKW.lager_prozent,
 WKW.mhd_zeitraum,
 MB.menge_lgbest_erp_frei_bme,
  CASE
  WHEN COALESCE(WKW.avq_relevant_fg, 1) = 1
  THEN 1
  ELSE 0
  END AS avq_relevant_fg,
 WKW.anzahl_nullbestand_tag1,
 WKW.anzahl_nullbestand_tag1bis3,
 WKW.anzahl_nullbestand_tag2,
 WKW.anzahl_nullbestand_tag3,
 WKW.anzahl_nullbestand_tag4,
 WKW.anzahl_nullbestand_tag5,
 WKW.anzahl_nullbestand_tag6,
 WKW.anzahl_nullbestand_tag7,
 WKW.menge_sa,
 WKW.vk_vor_aktion_brutto,
 WKW.vk_aktion_brutto,
 WKW.vk_kcard_brutto,
 WKW.menge_nur_tag1,
  CASE
  WHEN WKW.avq_relevant_fg = 9
  THEN 4
  WHEN WKW.avq_relevant_fg = 0
  THEN 3
  WHEN WKW.avq_relevant_fg = 1 AND COALESCE(bby.bby_fg, 0) = 1
  THEN 2
  ELSE 1
  END AS aktionsklassifizierung_id
FROM kfl_production_dbp_view.v_werbung_kennzahlen_woche_1 AS WKW
 INNER JOIN kfl_production_dbp_view.v_art_1 AS ART_1 ON WKW.mandant_id = ART.mandant_id AND WKW.art_id = ART.art_id AND ART_1
   .dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS MSZ ON WKW.mandant_id = MSZ.mandant_id AND WKW.mutter_wb_id = MSZ.art_id
     AND MSZ.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_art_1 AS MWB ON WKW.mandant_id = MWB.mandant_id AND WKW.mutter_wb_id = MWB.art_id
  AND MWB.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON WKW.mandant_id = V05.mandant_id AND WKW.wup_id = V05.wup_id AND V05
   .nb_id = 0
 LEFT JOIN kfl_production_dbp_view.v_marktbestand_erp_delta_1 AS MB ON WKW.mandant_id = MB.mandant_id AND WKW.art_id = MB
    .art_id AND WKW.wup_id = MB.wup_id
 LEFT JOIN (SELECT A.mandant_id,
   AAW.wup_id,
   AAW.art_id,
   A.kjwo_von,
   WT.werbe_typ_id,
   1 AS bby_fg
  FROM kfl_production_dbp_view.v_aktion_art_wup_zu_1 AS AAW
   INNER JOIN kfl_production_dbp_view.v_aktion_1 AS A ON AAW.mandant_id = A.mandant_id AND AAW.aktion_id = A.aktion_id
   INNER JOIN kfl_production_dbp_view.v_l_bonuskauf_1 AS BBY ON A.mandant_id = BBY.mandant_id AND A.aktion_id = BBY.aktion_id
     
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_werbe_woche_1 AS WT ON A.mandant_id = WT.mandant_id AND A.dat_von = WT.dat_von
       AND A.dat_bis = WT.dat_bis
  WHERE A.mandant_id = 1
   OR A.aktion_typ_id IN ('KDN', 'KDP', 'KPB', 'KDI') AND EXISTS (SELECT 1
     FROM kfl_production_dbp_view.v_tag_1 AS T
     WHERE akt_kj BETWEEN -2 AND 0
      AND kjwo = A.kjwo_von)
  GROUP BY AAW.art_id,
   AAW.wup_id,
   A.mandant_id,
   A.kjwo_von,
   WT.werbe_typ_id) AS bby ON WKW.mandant_id = bby.mandant_id AND WKW.wup_id = bby.wup_id AND WKW.art_id = bby.art_id
   AND WKW.kjwo = bby.kjwo_von AND WKW.werbe_typ_id = bby.werbe_typ_id
WHERE EXISTS (SELECT 1
  FROM kfl_production_dbp_view.v_tag_1 AS T
  WHERE akt_kj BETWEEN -2 AND 0
   AND kjwo = WKW.kjwo);