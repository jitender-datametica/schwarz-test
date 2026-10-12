CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ods_bon_leergut_1 (bon_id, bon_zeile, mandant_id, wup_id,
bon_dat, ean_kasse, umsatz_brutto, start_bon_zeile, bon_nr_extern, kpos_erfassung_id, menge, kl_art_id, wg_id, einh_id,
mwst_id, barcode_leergut) AS SELECT V01.bon_id,
 V01.bon_zeile,
 V01.mandant_id,
 V02.aktuell_wup_id AS wup_id,
 V01.bon_dat,
 V01.ean_kasse,
 V01.umsatz_brutto,
 V01.start_bon_zeile,
 V01.bon_nr_extern,
 V01.kpos_erfassung_id,
 V01.menge,
 V01.kl_art_id,
 V04.wg_id,
 V01.einh_id,
 V01.mwst_id,
 V01.barcode_leergut
FROM kfl_production_dbp_v_ods.v_ods_bon_leergut_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_1 AS V03 ON V01.kl_art_id = V03.kl_art_id AND V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS V04 ON V03.art_id = V04.art_id AND V03.mandant_id = V04.mandant_id;