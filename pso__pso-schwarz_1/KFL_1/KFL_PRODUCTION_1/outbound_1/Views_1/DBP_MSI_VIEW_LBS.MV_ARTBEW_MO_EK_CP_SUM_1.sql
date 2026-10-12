CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_lbs.mv_artbew_mo_ek_cp_sum_1 (mandant_id, art_id, bewart_id,
bewart_det_id, posten_id_per, posten_kz_per, wup_id, nb_id, kjmo, wrg_id, umsatz_netto, wa_kalk_ek_mep_km,
wa_kalk_ek_mep_o_fwu_km, logkostenzuschlag, preis_abschrift_netto) AS SELECT V01.mandant_id,
 V01.art_id,
 V01.bewart_id,
 V01.bewart_det_id,
 CAST(CASE
   WHEN V01.bewart_id = 1001 AND V01.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_id_per,
 SUBSTR(CASE
   WHEN V01.posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
 V01.wup_id,
 V01.nb_id,
 V01.kjmo,
 V01.wrg_id,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.umsatz_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.umsatz_netto * V01.umrechnungskurs_hist
  ELSE V01.umsatz_netto
  END AS umsatz_netto,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_kmep + V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN (V01.betrag_kmep + V01.preis_abschrift_netto) * V01.umrechnungskurs_hist
  ELSE V01.betrag_kmep + V01.preis_abschrift_netto
  END AS wa_kalk_ek_mep_km,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_kmep_o_fwu + V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN (V01.betrag_kmep_o_fwu + V01.preis_abschrift_netto) * V01.umrechnungskurs_hist
  ELSE V01.betrag_kmep_o_fwu + V01.preis_abschrift_netto
  END AS wa_kalk_ek_mep_o_fwu_km,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.logkostenzuschlag
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.logkostenzuschlag * V01.umrechnungskurs_hist
  ELSE V01.logkostenzuschlag
  END AS logkostenzuschlag,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN V01.preis_abschrift_netto * V01.umrechnungskurs_hist
  ELSE V01.preis_abschrift_netto
  END AS preis_abschrift_netto
FROM kfl_production_dbp_view.v_artbew_mo_ek_cp_sum_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V03 ON V01.mandant_id = V03.mandant_id AND (V01.mandant_id <> 5 OR V01
          .art_id <> 206731500) AND (V01.mandant_id <> 2 OR V01.art_id <> 20812450) AND (V01.mandant_id <> 3 OR V01.art_id
         <> 20811369) AND (V01.mandant_id <> 6 OR V01.art_id <> 20813157) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id
       <> 20811474) AND (V01.mandant_id <> 8 OR V01.art_id <> 20813164)
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON CASE
   WHEN V01.wrg_id = 'EUR'
   THEN 0
   ELSE 1
   END = CASE
   WHEN V03.default_wrg = 'EUR'
   THEN 0
   ELSE V02.wrg_typ_id
   END
WHERE V01.wup_bereinigt_fg = 0
 AND V01.mandant_id > 1
UNION ALL
SELECT mandant_id,
 art_id,
 bewart_id,
 bewart_det_id,
 CAST(CASE
   WHEN bewart_id = 1001 AND posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END AS STRING) AS posten_id_per,
 SUBSTR(CASE
   WHEN posten_id NOT IN ('PN', 'PF', 'SP', '1')
   THEN 'SO'
   ELSE 'PN'
   END, 1, 2) AS posten_kz_per,
 wup_id,
 nb_id,
 kjmo,
 'EUR' AS wrg_id,
 umsatz_netto,
  ek_mep - logkostenzuschlag AS wa_kalk_ek_mep_km,
  ek_mep - logkostenzuschlag AS wa_kalk_ek_mep_o_fwu_km,
 logkostenzuschlag,
 0
FROM kfl_production_dbp_view.v_artbew_mo_sum_1
WHERE mandant_id = 1;