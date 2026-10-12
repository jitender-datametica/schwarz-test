CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_kun.mv_artbew_1 (dat, art_id, mandant_id, gp_id, nb_id, wup_id,
bewart_id, aktion_id, posten_id, wrg_id, herst_id, mwst_id, umsatz_mwst_betrag, umsatz_netto, umsatz_brutto, vk_menge,
umsatz_mwst_betrag_af, umsatz_netto_af, umsatz_brutto_af, umsatz_mwst_betrag_sa, umsatz_netto_sa, umsatz_brutto_sa,
umsatz_netto_loyalty) AS SELECT v01.dat,
 v01.art_id,
 v01.mandant_id,
 v01.gp_id,
 v01.nb_id,
 v01.wup_id,
 v01.bewart_id,
 v01.aktion_id,
 SUBSTR(CAST(CASE
    WHEN v01.bewart_id = 1001 AND v01.posten_id NOT IN ('PN', 'PF')
    THEN '  '
    ELSE 'PN'
    END AS STRING), 1, 8) AS posten_id,
 v01.wrg_1 AS wrg_id,
 v01.herst_id,
 v01.mwst_id,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1
  THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1
  THEN ROUND(CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMERIC), 5)
  ELSE CAST(v01.umsatz_mwst_betrag AS NUMERIC)
  END AS umsatz_mwst_betrag,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1
  THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1
  THEN ROUND(CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC), 5)
  ELSE CAST(v01.umsatz_netto AS NUMERIC)
  END AS umsatz_netto,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1
  THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMERIC) + CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1
  THEN CAST(v01.umsatz_mwst_betrag AS NUMERIC) + CAST(v01.umsatz_netto AS NUMERIC) * v01.umrechnungskurs_hist
  ELSE CAST(v01.umsatz_mwst_betrag AS NUMERIC) + CAST(v01.umsatz_netto AS NUMERIC)
  END AS umsatz_brutto,
 CAST(v01.menge AS NUMERIC) AS vk_menge,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
  THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMERIC), 5)
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN (1001, 1010) OR v02.wrg_typ_id = 1 AND v01.bewart_id
      IN (1001, 1010)
  THEN CAST(v01.umsatz_mwst_betrag AS NUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_af,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
  THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
  THEN ROUND(CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC), 5)
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN (1001, 1010) OR v02.wrg_typ_id = 1 AND v01.bewart_id
      IN (1001, 1010)
  THEN CAST(v01.umsatz_netto AS NUMERIC)
  ELSE NULL
  END AS umsatz_netto_af,
   CASE
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
   THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMERIC)
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
   THEN ROUND(CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMERIC), 5)
   WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN (1001, 1010) OR v02.wrg_typ_id = 1 AND v01.bewart_id
       IN (1001, 1010)
   THEN CAST(v01.umsatz_mwst_betrag AS NUMERIC)
   ELSE NULL
   END + CASE
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
   THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id IN (1001, 1010)
   THEN ROUND(CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC), 5)
   WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id IN (1001, 1010) OR v02.wrg_typ_id = 1 AND v01.bewart_id
       IN (1001, 1010)
   THEN CAST(v01.umsatz_netto AS NUMERIC)
   ELSE NULL
   END AS umsatz_brutto_af,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
  THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
  THEN ROUND(CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMERIC), 5)
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 OR v02.wrg_typ_id = 1 AND v01.bewart_id = 1002
     
  THEN CAST(v01.umsatz_mwst_betrag AS NUMERIC)
  ELSE NULL
  END AS umsatz_mwst_betrag_sa,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
  THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
  THEN ROUND(CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC), 5)
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 OR v02.wrg_typ_id = 1 AND v01.bewart_id = 1002
     
  THEN CAST(v01.umsatz_netto AS NUMERIC)
  ELSE NULL
  END AS umsatz_netto_sa,
   CASE
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
   THEN CAST(v01.diff_umsatz_mwst_betrag_konz AS NUMERIC)
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
   THEN ROUND(CAST(v01.umsatz_mwst_betrag * v01.umrechnungskurs_hist AS NUMERIC), 5)
   WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 OR v02.wrg_typ_id = 1 AND v01.bewart_id =
      1002
   THEN CAST(v01.umsatz_mwst_betrag AS NUMERIC)
   ELSE NULL
   END + CASE
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
   THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
   WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_id = 1002
   THEN ROUND(CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC), 5)
   WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_id = 1002 OR v02.wrg_typ_id = 1 AND v01.bewart_id =
      1002
   THEN CAST(v01.umsatz_netto AS NUMERIC)
   ELSE NULL
   END AS umsatz_brutto_sa,
  CASE
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111,
     100121, 100131, 100211, 100221, 100231, 100241)
  THEN CAST(v01.diff_umsatz_netto_konz AS NUMERIC)
  WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 AND v01.mandant_id > 1 AND v01.bewart_det_id IN (100111,
     100121, 100131, 100211, 100221, 100231, 100241)
  THEN ROUND(CAST(v01.umsatz_netto * v01.umrechnungskurs_hist AS NUMERIC), 5)
  WHEN v02.wrg_typ_id = 0 AND v01.mandant_id = 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221,
      100231, 100241) OR v02.wrg_typ_id = 1 AND v01.bewart_det_id IN (100111, 100121, 100131, 100211, 100221, 100231,
      100241)
  THEN CAST(v01.umsatz_netto AS NUMERIC)
  ELSE NULL
  END AS umsatz_netto_loyalty
FROM kfl_production_dbp_view.v_artbew_1 AS v01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS v02 ON (v01.mandant_id <> 5 OR v01.art_id <> 206731500)
      AND (v01.mandant_id <> 2 OR v01.art_id <> 20812450) AND (v01.mandant_id <> 3 OR v01.art_id <> 20811369) AND (v01.mandant_id
        <> 6 OR v01.art_id <> 20813157) AND (v01.mandant_id NOT IN (4, 7) OR v01.art_id <> 20811474) AND (v01.mandant_id
      <> 8 OR v01.art_id <> 20813164);