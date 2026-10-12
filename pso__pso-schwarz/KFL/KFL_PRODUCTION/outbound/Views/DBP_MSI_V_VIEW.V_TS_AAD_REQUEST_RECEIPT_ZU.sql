CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_aad_request_receipt_zu AS SELECT bon_id,
 bon_dat,
 wup_id,
 mandant_id,
 aad_request_id
FROM kfl_production_dbp_msi_data.ts_aad_request_receipt_zu;