CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_financial_2 (bon_id, bon_dat, bon_booking, dat_booking
, wup_id, mandant_id, kasse_nr, kunde_fg, bon_beginn, bon_ende, turnover_fg, wrg_id, kasse_typ_id, bon_zeile, kl_art_id
, ean_kasse, menge, einh_id, umsatz_brutto, reklamationsgrund_id, reklamationstyp_id, auszahlung_fg) AS SELECT K.bon_id
 ,
 K.bon_dat,
 K.bon_booking,
 K.dat_booking,
 WUP.aktuell_wup_id AS wup_id,
 K.mandant_id,
 K.kasse_nr,
 K.kunde_fg,
 K.bon_beginn,
 K.bon_ende,
 K.turnover_fg,
 krs.nach_wrg_id AS wrg_id,
 K.kasse_typ_id,
 F.bon_zeile,
 - 1 AS kl_art_id,
 CAST(- 1 AS NUMERIC) AS ean_kasse,
 ROUND(CAST(SIGN(F.umsatz_brutto) AS NUMERIC), 3) AS menge,
 SUBSTR('ST ', 1, 3) AS einh_id,
  F.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto,
 F.financial_grund_id AS reklamationsgrund_id,
 SUBSTR('-1', 1, 2) AS reklamationstyp_id,
 F.auszahlung_fg
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS K
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_financial_2 AS F ON K.bon_id = F.bon_id AND K.wup_id = F.wup_id AND K.mandant_id
    = F.mandant_id
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
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON K.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON K.mandant_id = WUP.mandant_id AND K.wup_id = WUP.wup_id
WHERE (K.bon_id, CAST(K.wup_id AS BIGNUMERIC), CAST(K.mandant_id AS BIGNUMERIC)) NOT IN (SELECT (bon_id, wup_id,
     mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2);