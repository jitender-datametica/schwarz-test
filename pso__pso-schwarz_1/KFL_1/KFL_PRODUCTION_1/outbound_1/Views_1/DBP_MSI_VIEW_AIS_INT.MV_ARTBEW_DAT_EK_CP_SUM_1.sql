CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_artbew_dat_ek_cp_sum_1 (mandant_id, art_id, gp_id, bewart_id
, bewart_det_id, wup_id, nb_id, dat, wrg_id, umsatz_netto, wa_kalk_ek_mep_kw, wa_kalk_ek_mep_ww, wa_kalk_ek_mep_o_fwu_kw
, wa_kalk_ek_mep_o_fwu_ww, logkostenzuschlag, preis_abschrift_netto, posten_id_per, posten_kz_per) AS SELECT V01.mandant_id
 ,
 V01.art_id,
 V01.gp_id,
 V01.bewart_id,
 V01.bewart_det_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat,
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
  THEN V01.betrag_kmep_kw + V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN (V01.betrag_kmep_kw + V01.preis_abschrift_netto) * V01.umrechnungskurs_hist
  ELSE V01.betrag_kmep_kw + V01.preis_abschrift_netto
  END AS wa_kalk_ek_mep_kw,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_kmep_ww + V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN (V01.betrag_kmep_ww + V01.preis_abschrift_netto) * V01.umrechnungskurs_hist
  ELSE V01.betrag_kmep_ww + V01.preis_abschrift_netto
  END AS wa_kalk_ek_mep_ww,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_kmep_o_fwu_kw + V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN (V01.betrag_kmep_o_fwu_kw + V01.preis_abschrift_netto) * V01.umrechnungskurs_hist
  ELSE V01.betrag_kmep_o_fwu_kw + V01.preis_abschrift_netto
  END AS wa_kalk_ek_mep_o_fwu_kw,
  CASE
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 0
  THEN V01.betrag_kmep_o_fwu_ww + V01.preis_abschrift_netto
  WHEN V01.wrg_id = 'EUR' AND V02.wrg_typ_id = 0 AND V02.berichtskurs_typ_id = 1
  THEN (V01.betrag_kmep_o_fwu_ww + V01.preis_abschrift_netto) * V01.umrechnungskurs_hist
  ELSE V01.betrag_kmep_o_fwu_ww + V01.preis_abschrift_netto
  END AS wa_kalk_ek_mep_o_fwu_ww,
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
  END AS preis_abschrift_netto,
  CASE
  WHEN V01.bewart_id = 1001 AND V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN ''
  ELSE 'PN'
  END AS posten_id_per,
  CASE
  WHEN V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'SO'
  ELSE 'PN'
  END AS posten_kz_per
FROM kfl_production_dbp_data.artbew_dat_ek_cp_sum_1 AS V01
 INNER JOIN kfl_production_dbp_data.mandant_1 AS V03 ON V01.mandant_id = V03.mandant_id AND (V01.mandant_id <> 5 OR V01.art_id
           <> 206731500) AND (V01.mandant_id <> 2 OR V01.art_id <> 208124500) AND (V01.mandant_id <> 3 OR V01.art_id <>
        208113690) AND (V01.mandant_id <> 6 OR V01.art_id <> 208131570) AND (V01.mandant_id NOT IN (4, 7) OR V01.art_id
      <> 208114740) AND (V01.mandant_id <> 8 OR V01.art_id <> 208131640)
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_1 AS V02 ON CASE
   WHEN V01.wrg_id = 'EUR'
   THEN 0
   ELSE 1
   END = CASE
   WHEN V03.default_wrg = 'EUR'
   THEN 0
   ELSE V02.wrg_typ_id
   END
 LEFT JOIN kfl_production_dbp_data.art_per_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
   .dat BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
WHERE V01.wup_bereinigt_fg = 0
 AND V01.mandant_id > 1
UNION ALL
SELECT V01.mandant_id,
 V01.art_id,
 V01.gp_id,
 V01.bewart_id,
 V01.bewart_det_id,
 V01.wup_id,
 V01.nb_id,
 V01.dat,
 V01.wrg_1,
 V01.umsatz_netto,
  V01.ek_mep - V01.logkostenzuschlag AS wa_kalk_ek_mep_kw,
  V01.ek_mep - V01.logkostenzuschlag AS wa_kalk_ek_mep_ww,
  V01.ek_mep - V01.logkostenzuschlag AS wa_kalk_ek_mep_o_fwu_kw,
  V01.ek_mep - V01.logkostenzuschlag AS wa_kalk_ek_mep_o_fwu_ww,
 V01.logkostenzuschlag,
 0,
  CASE
  WHEN V01.bewart_id = 1001 AND V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN ''
  ELSE 'PN'
  END AS posten_id_per,
  CASE
  WHEN V04.posten_id NOT IN ('PN', 'PF', 'SP', '1')
  THEN 'SO'
  ELSE 'PN'
  END AS posten_kz_per
FROM kfl_production_dbp_data.artbew_1 AS V01
 LEFT JOIN kfl_production_dbp_data.art_per_1 AS V04 ON V01.art_id = V04.art_id AND V01.mandant_id = V04.mandant_id AND V01
   .dat BETWEEN DATE_SUB(V04.dat_von, INTERVAL 1 DAY) AND (DATE_SUB(V04.dat_bis, INTERVAL 1 DAY))
WHERE V01.mandant_id = 1;