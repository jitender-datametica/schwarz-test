CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_artbew_1 (dat, art_id, mandant_id, gp_id, nb_id, wup_id,
bewart_id, aktion_id, posten_id, wrg_id, herst_id, mwst_id, umsatz_mwst_betrag, umsatz_netto, umsatz_brutto, vk_menge,
umsatz_mwst_betrag_af, umsatz_netto_af, umsatz_brutto_af, umsatz_mwst_betrag_sa, umsatz_netto_sa, umsatz_brutto_sa,
umsatz_netto_loyalty) AS SELECT V01.dat,
 V01.art_id,
 V01.mandant_id,
 V01.gp_id,
 V01.nb_id,
 V01.wup_id,
 V01.bewart_id,
 V01.aktion_id,
 SUBSTR(CAST(CASE
    WHEN V01.bewart_id = 1001 AND V01.posten_id NOT IN ('PN', 'PF')
    THEN '  '
    ELSE 'PN'
    END AS STRING), 1, 8) AS posten_id,
 V01.wrg_1 AS wrg_id,
 V01.herst_id,
 V01.mwst_id,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  END AS umsatz_mwst_betrag,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  ELSE CAST(V01.umsatz_netto AS BIGNUMERIC)
  END AS umsatz_netto,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC) + CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC) + CAST(V01.umsatz_netto AS BIGNUMERIC) * V01.umrechnungskurs_hist
  ELSE CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC) + CAST(V01.umsatz_netto AS BIGNUMERIC)
  END AS umsatz_brutto,
 CAST(V01.menge AS BIGNUMERIC) AS vk_menge,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
      IN (1001, 1010)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_af,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
   THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
   THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
       IN (1001, 1010)
   THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
   ELSE NULL
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id IN (1001, 1010)
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id IN (1001, 1010) OR V02.wrg_typ_id = 1 AND V01.bewart_id
       IN (1001, 1010)
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE NULL
   END AS umsatz_brutto_af,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id = 1002
     
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_sa,
   CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
   THEN CAST(V01.diff_umsatz_mwst_betrag_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
   THEN ROUND(CAST(V01.umsatz_mwst_betrag * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id =
      1002
   THEN CAST(V01.umsatz_mwst_betrag AS BIGNUMERIC)
   ELSE NULL
   END + CASE
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
   THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
   WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_id = 1002
   THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
   WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_id = 1002 OR V02.wrg_typ_id = 1 AND V01.bewart_id =
      1002
   THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
   ELSE NULL
   END AS umsatz_brutto_sa,
  CASE
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0 AND V01.mandant_id > 1 AND V01.bewart_det_id IN (100111,
     100121, 100131, 100211, 100221, 100231, 100241)
  THEN CAST(V01.diff_umsatz_netto_konz AS BIGNUMERIC)
  WHEN V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1 AND V01.mandant_id > 1 AND V01.bewart_det_id IN (100111,
     100121, 100131, 100211, 100221, 100231, 100241)
  THEN ROUND(CAST(V01.umsatz_netto * V01.umrechnungskurs_hist AS BIGNUMERIC), 5)
  WHEN V02.wrg_typ_id = 0 AND V01.mandant_id = 1 AND V01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221,
      100231, 100241) OR V02.wrg_typ_id = 1 AND V01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231,
      100241)
  THEN CAST(V01.umsatz_netto AS BIGNUMERIC)
  ELSE NULL
  END AS umsatz_netto_loyalty
FROM kfl_production_dbp_data.artbew_1 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON (V01.mandant_id <> 5 OR V01.art_id <> 206731500)
      AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01.mandant_id <> 3 OR V01.art_id <> 208113690) AND (V01
       .mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id <> 208114740) AND (V01
     .mandant_id <> 8 OR V01.art_id <> 208131640);