CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_artbew_wo_sum (mandant_id, nb_id, wup_id, art_id, kjwo_kl,
bewart_id, gp_id, aktion_id, bezugsweg_id, menge, umsatz_netto, umsatz_mwst_betrag, umsatz_brutto, ek_nettonetto, ek_mep
, einstandspreis, wrg_id) AS SELECT V01.mandant_id,
 V01.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 V01.art_id,
 V01.kjwo_kl,
 V01.bewart_id,
 V01.gp_id,
 V01.aktion_id,
 V01.bezugsweg_id,
 V01.menge,
  V01.umsatz_netto * krs.umrechnungskurs AS umsatz_netto,
  V01.umsatz_mwst_betrag * krs.umrechnungskurs AS umsatz_mwst_betrag,
   (V01.umsatz_netto + V01.umsatz_mwst_betrag) * krs.umrechnungskurs AS umsatz_brutto,
  V01.ek_nettonetto * krs.umrechnungskurs AS ek_nettonetto,
  V01.ek_mep * krs.umrechnungskurs AS ek_mep,
  V01.einstandspreis * krs.umrechnungskurs AS einstandspreis,
 krs.nach_wrg_id AS wrg_id
FROM kfl_production_dbp_view.v_artbew_wo_sum AS V01
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON V01.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON V01.mandant_id = WUP.mandant_id AND V01.wup_id = WUP.wup_id;