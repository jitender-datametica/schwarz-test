CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ods_bon_zahlung_2 (bon_id, bon_zeile, wup_id, mandant_id,
zahlung_typ_id, start_bon_zeile, betrag_zahlung, wrg_id, kpos_zahlung_typ_id, bon_dat, bon_zeile_cashback_referenz,
kartennummer_maskiert, barcode_leergut) AS SELECT BZ.bon_id,
 BZ.bon_zeile,
 WUP.aktuell_wup_id AS wup_id,
 BZ.mandant_id,
 BZ.zahlung_typ_id,
 BZ.start_bon_zeile,
 BZ.betrag_zahlung,
 BZ.wrg_id,
 BZ.kpos_zahlung_typ_id,
 BZ.bon_dat,
 BZ.bon_zeile_cashback_referenz,
 BZ.kartennummer_maskiert,
 BZ.barcode_leergut
FROM kfl_production_dbp_v_ods.v_ods_bon_zahlung_2 AS BZ
 INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON BZ.mandant_id = WUP.mandant_id AND BZ.wup_id = WUP.wup_id;