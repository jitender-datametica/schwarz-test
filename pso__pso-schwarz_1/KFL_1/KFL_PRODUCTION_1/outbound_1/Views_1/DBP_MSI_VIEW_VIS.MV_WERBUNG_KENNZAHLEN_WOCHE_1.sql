CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_werbung_kennzahlen_woche_1 (mandant_id, nb_id, wup_id, kjwo,
werbe_typ_id, wtag_id_start, wtag_id_ende, posten_id, art_mutter_posten_fg, posten_fg, art_mutter_wb_id,
art_mutter_display_id, mwb_basismenge_einh_id, mwb_verpart_id, art_mutter_wb_nr, art_mutter_wb_bez, art_mutter_wb_fg,
anz_art_kind, faktor_flaki, art_mutter_bezugsweg_id, art_mutter_saison_id, art_id, art_display_id,
art_basismenge_einh_id, art_verpart_id, art_saison_id, menge_tag1, menge_tag2, menge_tag3, menge_tag4, menge_tag5,
menge_tag6, menge_tag7, menge, umsatz_netto_tag1, umsatz_netto_tag2, umsatz_netto_tag3, umsatz_netto_tag4,
umsatz_netto_tag5, umsatz_netto_tag6, umsatz_netto_tag7, umsatz_netto, menge_0_tag1, menge_0_tag2, menge_0_tag3,
menge_0_tag4, menge_0_tag5, menge_0_tag6, menge_0_tag7, tage_menge_0, menge_we_zentrale, menge_we, menge_aktionsstart,
menge_endbestand, min_sicherh_bestand, menge_historie_af, anzahl_nullbestand, anzahl_tage_aktion, tage_menge_0_org,
menge_wup, avk_quote, umsatz_netto_wup, art_wup_fg, menge_wareneinsatz, anteil_sams, menge_af_mo_mittel,
menge_af_di_mittel, menge_mo, menge_di, menge_mi, menge_do, menge_fr, menge_sams, umsatz_netto_mo, umsatz_netto_di,
umsatz_netto_mi, umsatz_netto_do, umsatz_netto_fr, umsatz_netto_sams, lager_prozent, mhd_zeitraum, sollbestand,
menge_bestand_soll_max, we_menge_vor_aktion, anzahl_nullbestand_tag1, anzahl_nullbestand_tag1bis3, anzahl_minusbestand,
anzahl_minusbestand_tag1, anzahl_minusbestand_tag1bis3, vk_vor_aktion_brutto, vk_aktion_brutto, vk_kcard_brutto) AS
SELECT WKW.mandant_id,
 WKW.nb_id,
 V05.aktuell_wup_id AS wup_id,
 WKW.kjwo,
 WKW.werbe_typ_id,
 WKW.wtag_id_start,
 WKW.wtag_id_ende,
 WKW.posten_id,
  CASE
  WHEN MWB.posten_kz_sap <> ''
  THEN 1
  ELSE 0
  END AS art_mutter_posten_fg,
  CASE
  WHEN ART.posten_kz_sap <> ''
  THEN 1
  ELSE 0
  END AS posten_fg,
 COALESCE(ART.mutter_wb_id, ART.art_id) AS art_mutter_wb_id,
  CASE
  WHEN MWB.artikeltyp_id = 12
  THEN MWB.artikeltyp_id
  ELSE MWB.display_id
  END AS art_mutter_display_id,
 MWB.basismenge_einh_id AS mwb_basismenge_einh_id,
 COALESCE(MWB.verpart_id, ' ') AS mwb_verpart_id,
 TRIM(CAST(CASE
    WHEN WKW.mandant_id = 1
    THEN WKW.mutter_wb_id / 100
    ELSE WKW.mutter_wb_id / 10
    END AS STRING FORMAT '00000000')) AS art_mutter_wb_nr,
 MSZ.art_bez AS art_mutter_wb_bez,
 CAST(CASE
   WHEN WKW.mutter_wb_id = WKW.art_id
   THEN 0
   ELSE 1
   END AS BIGNUMERIC) AS art_mutter_wb_fg,
   (RANK() OVER (PARTITION BY CAST(WKW.mandant_id AS STRING), CAST(WKW.wup_id AS STRING), CAST(WKW.kjwo AS STRING), CAST(WKW.werbe_typ_id AS STRING)
      , COALESCE(ART.mutter_wb_id, ART.art_id) ORDER BY WKW.mandant_id IS NULL, WKW.mandant_id, WKW.wup_id IS NULL, WKW
      .wup_id, WKW.kjwo IS NULL, WKW.kjwo, WKW.werbe_typ_id IS NULL, WKW.werbe_typ_id, COALESCE(ART.mutter_wb_id, ART.art_id
       ) IS NULL, COALESCE(ART.mutter_wb_id, ART.art_id), WKW.art_id IS NULL, WKW.art_id)) - 1 AS anz_art_kind,
 WKW.faktor_flaki,
 WKW.art_mutter_bezugsweg_id,
 MWB.saison_id AS art_mutter_saison_id,
 WKW.art_id,
  CASE
  WHEN ART.artikeltyp_id = 12
  THEN ART.artikeltyp_id
  ELSE ART.display_id
  END AS art_display_id,
 ART.basismenge_einh_id AS art_basismenge_einh_id,
 COALESCE(ART.verpart_id, ' ') AS art_verpart_id,
 ART.saison_id AS art_saison_id,
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
 CAST(CASE
   WHEN WKW.menge_tag1 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag1,
 CAST(CASE
   WHEN WKW.menge_tag2 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag2,
 CAST(CASE
   WHEN WKW.menge_tag3 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag3,
 CAST(CASE
   WHEN WKW.menge_tag4 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag4,
 CAST(CASE
   WHEN WKW.menge_tag5 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag5,
 CAST(CASE
   WHEN WKW.menge_tag6 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag6,
 CAST(CASE
   WHEN WKW.menge_tag7 = 0
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS menge_0_tag7,
 WKW.tage_menge_0,
 WKW.we_menge_zentral AS menge_we_zentrale,
 WKW.we_menge AS menge_we,
 WKW.menge_aktionsstart,
 WKW.menge_endbestand,
 WKW.min_sicherh_bestand,
 WKW.menge_historie_af,
 WKW.anzahl_nullbestand,
 WKW.anzahl_tage_aktion,
 WKW.tage_menge_0 AS tage_menge_0_org,
 AVG(WKW.menge_tag1 + WKW.menge_tag2 + WKW.menge_tag3 + WKW.menge_tag4 + WKW.menge_tag5 + WKW.menge_tag6 + WKW.menge_tag7
   ) OVER (PARTITION BY CAST(WKW.mandant_id AS STRING), CAST(WKW.kjwo AS STRING), CAST(WKW.art_id AS STRING) ORDER BY
    WKW.mandant_id IS NULL, WKW.mandant_id, WKW.kjwo IS NULL, WKW.kjwo, WKW.art_id IS NULL, WKW.art_id, WKW.nb_id
    IS NULL, WKW.nb_id, WKW.wup_id IS NULL, WKW.wup_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS menge_wup,
   (WKW.menge_tag1 + WKW.menge_tag2 + WKW.menge_tag3 + WKW.menge_tag4 + WKW.menge_tag5 + WKW.menge_tag6 + WKW.menge_tag7
    ) / CASE
   WHEN WKW.menge_aktionsstart + WKW.we_menge - WKW.min_sicherh_bestand = 0
   THEN NULL
   ELSE WKW.menge_aktionsstart + WKW.we_menge - WKW.min_sicherh_bestand
   END AS avk_quote,
 AVG(WKW.umsatz_netto_tag1 + WKW.umsatz_netto_tag2 + WKW.umsatz_netto_tag3 + WKW.umsatz_netto_tag4 + WKW.umsatz_netto_tag5
      + WKW.umsatz_netto_tag6 + WKW.umsatz_netto_tag7) OVER (PARTITION BY CAST(WKW.mandant_id AS STRING), CAST(WKW.kjwo AS STRING)
    , CAST(WKW.art_id AS STRING) ORDER BY WKW.mandant_id IS NULL, WKW.mandant_id, WKW.kjwo IS NULL, WKW.kjwo, WKW.art_id
    IS NULL, WKW.art_id, WKW.nb_id IS NULL, WKW.nb_id, WKW.wup_id IS NULL, WKW.wup_id RANGE BETWEEN UNBOUNDED PRECEDING
  AND CURRENT ROW) AS umsatz_netto_wup,
 1 AS art_wup_fg,
   WKW.menge_aktionsstart + WKW.we_menge - WKW.min_sicherh_bestand AS menge_wareneinsatz,
 0.00 AS anteil_sams,
 0.00 AS menge_af_mo_mittel,
 0.00 AS menge_af_di_mittel,
 0.00 AS menge_mo,
 0.00 AS menge_di,
 0.00 AS menge_mi,
 0.00 AS menge_do,
 0.00 AS menge_fr,
 0.00 AS menge_sams,
 0.00 AS umsatz_netto_mo,
 0.00 AS umsatz_netto_di,
 0.00 AS umsatz_netto_mi,
 0.00 AS umsatz_netto_do,
 0.00 AS umsatz_netto_fr,
 0.00 AS umsatz_netto_sams,
  WKW.lager_prozent * 0.01 AS lager_prozent,
 WKW.mhd_zeitraum,
 WKW.sollbestand,
 WKW.menge_bestand_soll_max,
 WKW.we_menge_vor_aktion,
 WKW.anzahl_nullbestand_tag1,
 WKW.anzahl_nullbestand_tag1bis3,
 WKW.anzahl_minusbestand,
 WKW.anzahl_minusbestand_tag1,
 WKW.anzahl_minusbestand_tag1bis3,
 WKW.vk_vor_aktion_brutto,
 WKW.vk_aktion_brutto,
 WKW.vk_kcard_brutto
FROM kfl_production_dbp_view.v_werbung_kennzahlen_woche_1 AS WKW
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V05 ON WKW.mandant_id = V05.mandant_id AND WKW.wup_id = V05.wup_id AND (V05
      .nb_id IN (2, 0, - 111) AND V05.wup_id > 0 OR V05.nb_id = - 1 AND V05.wup_id = 0)
 INNER JOIN kfl_production_dbp_view.v_art_1 AS ART_1 ON WKW.mandant_id = ART.mandant_id AND WKW.art_id = ART.art_id AND ART_1
   .dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS MSZ ON WKW.mandant_id = MSZ.mandant_id AND MSZ.art_id = COALESCE(ART_1
     .mutter_wb_id, ART.art_id) AND MSZ.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_art_1 AS MWB ON WKW.mandant_id = MWB.mandant_id AND MWB.art_id = COALESCE(ART.mutter_wb_id
     , ART.art_id) AND MWB.dat_bis = DATE '9999-12-31'
WHERE COALESCE(WKW.avq_relevant_fg, 1) = 1;