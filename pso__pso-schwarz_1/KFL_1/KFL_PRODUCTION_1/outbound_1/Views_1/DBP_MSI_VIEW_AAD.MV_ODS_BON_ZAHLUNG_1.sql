CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ods_bon_zahlung_1 (bon_id, bon_zeile, mandant_id, wup_id,
bon_dat, zahlung_typ_id, start_bon_zeile, betrag_zahlung, wrg_id, kpos_zahlung_typ_id, bon_zeile_cashback_referenz,
kartennummer_maskiert, barcode_leergut, gutschein_id) AS SELECT V01.bon_id,
 V01.bon_zeile,
 V01.mandant_id,
 V02.aktuell_wup_id AS wup_id,
 V01.bon_dat,
 V01.zahlung_typ_id,
 V01.start_bon_zeile,
 V01.betrag_zahlung,
 V01.wrg_id,
 V01.kpos_zahlung_typ_id,
 V01.bon_zeile_cashback_referenz,
 V01.kartennummer_maskiert,
 V01.barcode_leergut,
 V01.gutschein_id
FROM kfl_production_dbp_v_ods.v_ods_bon_zahlung_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;