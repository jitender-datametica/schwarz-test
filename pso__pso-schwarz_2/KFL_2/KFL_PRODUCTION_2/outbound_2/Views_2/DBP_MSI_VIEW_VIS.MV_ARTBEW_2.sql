CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_artbew_2 (mandant_id, nb_id, wup_id, art_id, dat, bewart_id,
gp_id, einkaufsorganisation_id, posten_id, bq_findung_id, aktion_id, promo_fg, herst_id, mwst_id, bezugsweg_id, menge,
wrg_id, umsatz_netto, umsatz_mwst_betrag, ek_brutto, ek_netto, ek_nettonetto, ek_kal_basis, ek_mep, einstandspreis,
logkostenzuschlag, ek_netto_bnk, ek_netto_bnk_sachk, ek_gld) AS SELECT ABW.mandant_id,
 ABW.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 ABW.art_id,
 ABW.dat,
 ABW.bewart_id,
 ABW.gp_id,
 ABW.einkaufsorganisation_id,
 ABW.posten_id,
 ABW.bq_findung_id,
 ABW.aktion_id,
 ABW.promo_fg,
 ABW.herst_id,
 ABW.mwst_id,
 ABW.bezugsweg_id,
 ABW.menge,
 krs.nach_wrg_id AS wrg_id,
  ABW.umsatz_netto * krs.umrechnungskurs AS umsatz_netto,
  ABW.umsatz_mwst_betrag * krs.umrechnungskurs AS umsatz_mwst_betrag,
  ABW.ek_brutto * krs.umrechnungskurs AS ek_brutto,
  ABW.ek_netto * krs.umrechnungskurs AS ek_netto,
  ABW.ek_nettonetto * krs.umrechnungskurs AS ek_nettonetto,
  ABW.ek_kal_basis * krs.umrechnungskurs AS ek_kal_basis,
  ABW.ek_mep * krs.umrechnungskurs AS ek_mep,
  ABW.einstandspreis * krs.umrechnungskurs AS einstandspreis,
  ABW.logkostenzuschlag * krs.umrechnungskurs AS logkostenzuschlag,
  ABW.ek_netto_bnk * krs.umrechnungskurs AS ek_netto_bnk,
  ABW.ek_netto_bnk_sachk * krs.umrechnungskurs AS ek_netto_bnk_sachk,
  ABW.ek_gld * krs.umrechnungskurs AS ek_gld
FROM kfl_production_dbp_data.artbew_2 AS ABW
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_2 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_2 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON ABW.wrg_2 = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON ABW.mandant_id = WUP.mandant_id AND ABW.wup_id = WUP.wup_id;