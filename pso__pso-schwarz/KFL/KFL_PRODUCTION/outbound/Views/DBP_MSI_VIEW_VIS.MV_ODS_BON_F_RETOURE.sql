CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_retoure (bon_id, bon_dat, bon_booking, dat_booking,
wup_id, mandant_id, kasse_nr, kunde_fg, bon_beginn, bon_ende, turnover_fg, wrg_id, bon_zeile, kl_art_id, ean_kasse,
menge, einh_id, umsatz_brutto, mwst, reklamationsgrund_id, reklamationstyp_id, menge_fg, mhd, los_charge, kunden_text,
art_id_ref, kpos_erfassung_id) AS SELECT K.bon_id,
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
 R.bon_zeile,
 R.kl_art_id,
 R.ean_kasse,
 R.menge,
 R.einh_id,
  R.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto,
 M.mwst,
 R.reklamationsgrund_id,
 R.reklamationstyp_id,
 R.menge_fg,
 R.mhd,
 R.los_charge,
 R.kunden_text,
 R.art_id_ref,
 R.kpos_erfassung_id
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf AS K
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_retoure AS R ON K.bon_id = R.bon_id AND K.wup_id = R.wup_id AND K.mandant_id
     = R.mandant_id AND K.bon_dat = R.bon_dat
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS M ON R.mandant_id = M.mandant_id AND R.mwst_id = M.mwst_id AND R.bon_dat
   BETWEEN M.dat_von AND M.dat_bis
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
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON K.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON K.mandant_id = WUP.mandant_id AND K.wup_id = WUP.wup_id
WHERE K.turnover_fg = 1
 AND R.wg_id <> 961
 AND (K.bon_id, CAST(K.wup_id AS BIGNUMERIC), CAST(K.mandant_id AS BIGNUMERIC)) NOT IN (SELECT (bon_id, CAST(wup_id AS BIGNUMERIC)
     , CAST(mandant_id AS BIGNUMERIC))
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno);