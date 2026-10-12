CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ts_aad_request_receipt_zu_1 (bon_id, bon_dat, wup_id, mandant_id
, aad_request_id) AS SELECT v01.bon_id,
 v01.bon_dat,
 v02.aktuell_wup_id AS wup_id,
 v01.mandant_id,
 v01.aad_request_id
FROM kfl_production_dbp_msi_data.ts_aad_request_receipt_zu_1 AS v01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS v02 ON v01.wup_id = v02.wup_id AND v01.mandant_id = v02.mandant_id;