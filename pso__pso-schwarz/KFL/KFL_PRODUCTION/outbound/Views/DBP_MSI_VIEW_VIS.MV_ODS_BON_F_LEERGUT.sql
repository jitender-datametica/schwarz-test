CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_f_leergut (bon_id, bon_zeile, mandant_id, wup_id,
bon_dat, ean_kasse, umsatz_brutto, start_bon_zeile, bon_nr_extern, kpos_erfassung_id, menge, kl_art_id, einh_id, mwst_id
, barcode_leergut, wrg_id) AS SELECT L01.bon_id,
 L01.bon_zeile,
 L01.mandant_id,
 WUP.aktuell_wup_id AS wup_id,
 L01.bon_dat,
 L01.ean_kasse,
  L01.umsatz_brutto * krs.umrechnungskurs AS umsatz_brutto,
 L01.start_bon_zeile,
 L01.bon_nr_extern,
 L01.kpos_erfassung_id,
 L01.menge,
 L01.kl_art_id,
 L01.einh_id,
 L01.mwst_id,
 L01.barcode_leergut,
 krs.nach_wrg_id AS wrg_id
FROM kfl_production_dbp_v_ods.v_ods_bon_leergut AS L01
 INNER JOIN kfl_production_dbp_v_ods.v_ods_bon_kopf AS K01 ON L01.mandant_id = K01.mandant_id AND L01.wup_id = K01.wup_id
      AND L01.bon_dat = K01.bon_dat AND L01.bon_id = K01.bon_id
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
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON K01.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON L01.mandant_id = WUP.mandant_id AND L01.wup_id = WUP.wup_id;