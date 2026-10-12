CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_int.mv_werbung_kennzahlen_woche_1 (mandant_id, nb_id, wup_id, kjwo,
werbe_typ_id, wtag_id_start, wtag_id_ende, posten_id, posten_fg, art_mutter_wb_id, art_mutter_display_id,
mwb_basismenge_einh_id, mwb_verpart_id, art_mutter_wb_nr, art_mutter_wb_bez, art_mutter_wb_fg, anz_art_kind,
faktor_flaki, art_id, art_display_id, art_basismenge_einh_id, art_verpart_id, menge_tag1, menge_tag2, menge_tag3,
menge_tag4, menge_tag5, menge_tag6, menge_tag7, menge, umsatz_netto_tag1, umsatz_netto_tag2, umsatz_netto_tag3,
umsatz_netto_tag4, umsatz_netto_tag5, umsatz_netto_tag6, umsatz_netto_tag7, umsatz_netto, menge_0_tag1, menge_0_tag2,
menge_0_tag3, menge_0_tag4, menge_0_tag5, menge_0_tag6, menge_0_tag7, tage_menge_0, menge_we_zentrale, menge_we,
menge_aktionsstart, menge_endbestand, min_sicherh_bestand, menge_historie_af, anzahl_nullbestand, anzahl_tage_aktion) AS
SELECT WKW.mandant_id,
 WKW.nb_id,
 WKW.wup_id,
 WKW.kjwo,
 WKW.werbe_typ_id,
 WKW.wtag_id_start,
 WKW.wtag_id_ende,
 WKW.posten_id,
 CAST(CASE
   WHEN SUBSTR(MSZ.art_bez, 1, 2) = 'W.'
   THEN 1
   WHEN SUBSTR(MSZ.art_bez, 1, 3) = 'IW.'
   THEN 1
   WHEN SUBSTR(MSZ.art_bez, LENGTH(MSZ.art_bez) - 1) = '/P' OR WKW.posten_id = '1'
   THEN 1
   ELSE 0
   END AS BIGNUMERIC) AS posten_fg,
 WKW.mutter_wb_id AS art_mutter_wb_id,
 MWB.display_id AS art_mutter_display_id,
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
      , CAST(WKW.mutter_wb_id AS STRING) ORDER BY WKW.mandant_id IS NULL, WKW.mandant_id, WKW.wup_id IS NULL, WKW.wup_id
      , WKW.kjwo IS NULL, WKW.kjwo, WKW.werbe_typ_id IS NULL, WKW.werbe_typ_id, WKW.mutter_wb_id IS NULL, WKW.mutter_wb_id
      , WKW.art_id IS NULL, WKW.art_id)) - 1 AS anz_art_kind,
 WKW.faktor_flaki,
 WKW.art_id,
 ART.display_id AS art_display_id,
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
 WKW.anzahl_tage_aktion
FROM kfl_production_dbp_view.v_werbung_kennzahlen_woche_1 AS WKW
 INNER JOIN kfl_production_dbp_view.v_art_1 AS ART_1 ON WKW.mandant_id = ART.mandant_id AND WKW.art_id = ART.art_id AND CAST(ART.dat_bis AS DATE)
   = snowconvert_public.int_to_date_udf(80991231)
 INNER JOIN kfl_production_dbp_view.v_art_spr_zu_1 AS MSZ ON WKW.mandant_id = MSZ.mandant_id AND WKW.mutter_wb_id = MSZ.art_id
     AND MSZ.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_art_1 AS MWB ON WKW.mandant_id = MWB.mandant_id AND WKW.mutter_wb_id = MWB.art_id
  AND CAST(MWB.dat_bis AS DATE) = snowconvert_public.int_to_date_udf(80991231)
WHERE (WKW.menge_tag1 + WKW.menge_tag2 + WKW.menge_tag3 + WKW.menge_tag4 + WKW.menge_tag5 + WKW.menge_tag6 + WKW.menge_tag7
     ) / CASE
    WHEN WKW.faktor_flaki = 0
    THEN NULL
    ELSE WKW.faktor_flaki
    END <> 0.0
 OR WKW.we_menge_zentral / CASE
     WHEN WKW.faktor_flaki = 0
     THEN NULL
     ELSE WKW.faktor_flaki
     END <> 0.0 AND COALESCE(WKW.avq_relevant_fg, 1) = 1;