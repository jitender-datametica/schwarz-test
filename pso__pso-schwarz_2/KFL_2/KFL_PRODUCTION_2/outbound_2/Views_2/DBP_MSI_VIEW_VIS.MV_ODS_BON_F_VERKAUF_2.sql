CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_verkauf_2 (bon_id, bon_dat, bon_booking, dat_booking,
wup_id, mandant_id, kasse_nr, kunde_fg, bon_beginn, bon_ende, turnover_fg, wrg_id, bon_zeile, kl_art_id, ean_kasse,
wg_id, menge, einh_id, umsatz_brutto, kpos_erfassung_id, mwst, mwst_id, start_bon_zeile
OPTIONS(description='Zeitstempel der Erfassung dieser Bonzeile'), barcode_string
OPTIONS(description='Barcode String des Artikels'), barcode_leergut
OPTIONS(description='Barcode des eingelösten Pfandbons'), zeilenstorno_fg
OPTIONS(description='1 = diese Zeile ist eine_2 Stornozeile. Beträge und Mengen sind negativ. Sie saldiert eine_2 Vorgängerzeile damit auf 0. Die stornierte Zeile selbst hat kein Stornoflag.'))
AS SELECT K.bon_id,
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
 V.bon_zeile,
 V.kl_art_id,
 V.ean_kasse,
 V.wg_id,
 V.menge,
 V.einh_id,
  V.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto,
 V.kpos_erfassung_id,
 M.mwst,
 V.mwst_id,
 V.start_bon_zeile,
 V.barcode_string,
 V.barcode_leergut,
 V.zeilenstorno_fg
FROM kfl_production_dbp_v_ods.v_ods_bon_kopf_2 AS K
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_verkauf_2 AS V ON K.bon_id = V.bon_id AND K.wup_id = V.wup_id AND K.mandant_id
     = V.mandant_id AND K.bon_dat = V.bon_dat
 INNER JOIN kfl_production_dbp_view.v_mwst_per_2 AS M ON V.mandant_id = M.mandant_id AND V.mwst_id = M.mwst_id AND K.bon_dat
   BETWEEN M.dat_von AND M.dat_bis
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
WHERE K.turnover_fg = 1
 AND V.wg_id <> 961
 AND (K.bon_id, CAST(K.wup_id AS BIGNUMERIC), CAST(K.mandant_id AS BIGNUMERIC)) NOT IN (SELECT (bon_id, wup_id,
     mandant_id)
   FROM kfl_production_dbp_v_ods.v_ods_bon_storno_2);