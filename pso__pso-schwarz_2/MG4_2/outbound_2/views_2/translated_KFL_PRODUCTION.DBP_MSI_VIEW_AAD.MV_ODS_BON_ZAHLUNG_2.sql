CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ods_bon_zahlung_2 (bon_id, bon_zeile, mandant_id, wup_id,
bon_dat, zahlung_typ_id, start_bon_zeile, betrag_zahlung, wrg_id, kpos_zahlung_typ_id, bon_zeile_cashback_referenz,
kartennummer_maskiert, barcode_leergut, gutschein_id) AS SELECT v01.bon_id,
 v01.bon_zeile,
 v01.mandant_id,
 v02.aktuell_wup_id AS wup_id,
 v01.bon_dat,
 v01.zahlung_typ_id,
 v01.start_bon_zeile,
 v01.betrag_zahlung,
 v01.wrg_id,
 v01.kpos_zahlung_typ_id,
 v01.bon_zeile_cashback_referenz,
 v01.kartennummer_maskiert,
 v01.barcode_leergut,
 v01.gutschein_id
FROM kfl_production_dbp_v_ods.v_ods_bon_zahlung_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS v02 ON v01.wup_id = v02.wup_id AND v01.mandant_id = v02.mandant_id;