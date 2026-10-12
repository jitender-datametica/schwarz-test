CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_aad.mv_ts_aad_request_receipt_zu_1 (bon_id, bon_dat, wup_id, mandant_id
, aad_request_id) AS SELECT V01.bon_id,
 V01.bon_dat,
 V02.aktuell_wup_id AS wup_id,
 V01.mandant_id,
 V01.aad_request_id
FROM kfl_production_dbp_msi_data.ts_aad_request_receipt_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.wup_id = V02.wup_id AND V01.mandant_id = V02.mandant_id;