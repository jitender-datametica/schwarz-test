CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_artbew_mo_sum_1 (mandant_id, nb_id, wup_id, art_id, kjmo,
bewart_id, gp_id, herst_id, posten_id, menge, umsatz_netto, umsatz_mwst_betrag, umsatz_brutto, ek_brutto, ek_netto,
ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis, logkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, wrg_id,
umsatz_netto_af, umsatz_netto_sa, menge_af, menge_sa) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.art_id,
 V01.kjmo,
 V01.bewart_id,
 V01.gp_id,
 V01.herst_id,
 V01.posten_id,
 V01.menge,
  V01.umsatz_netto * krs.umrechnungskurs AS umsatz_netto,
  V01.umsatz_mwst_betrag * krs.umrechnungskurs AS umsatz_mwst_betrag,
   (V01.umsatz_netto + V01.umsatz_mwst_betrag) * krs.umrechnungskurs AS umsatz_brutto,
  V01.ek_brutto * krs.umrechnungskurs AS ek_brutto,
  V01.ek_netto * krs.umrechnungskurs AS ek_netto,
  V01.ek_nettonetto * krs.umrechnungskurs AS ek_nettonetto,
  V01.ek_kal_basis * krs.umrechnungskurs AS ek_kal_basis,
  V01.ek_mep * krs.umrechnungskurs AS ek_mep,
  V01.einstandspreis * krs.umrechnungskurs AS einstandspreis,
  V01.logkostenzuschlag * krs.umrechnungskurs AS logkostenzuschlag,
  V01.ek_netto_bnk * krs.umrechnungskurs AS ek_netto_bnk,
  V01.ek_netto_bnk_sachk * krs.umrechnungskurs AS ek_netto_bnk_sachk,
 krs.nach_wrg_id AS wrg_id,
  CASE
  WHEN V01.bewart_id = 1001
  THEN V01.umsatz_netto * krs.umrechnungskurs
  ELSE 0
  END AS umsatz_netto_af,
  CASE
  WHEN V01.bewart_id = 1002
  THEN V01.umsatz_netto * krs.umrechnungskurs
  ELSE 0
  END AS umsatz_netto_sa,
  CASE
  WHEN V01.bewart_id = 1001
  THEN V01.menge
  ELSE 0
  END AS menge_af,
  CASE
  WHEN V01.bewart_id = 1002
  THEN V01.menge
  ELSE 0
  END AS menge_af0
FROM kfl_production_dbp_view.v_artbew_mo_sum_1 AS V01
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V01.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;