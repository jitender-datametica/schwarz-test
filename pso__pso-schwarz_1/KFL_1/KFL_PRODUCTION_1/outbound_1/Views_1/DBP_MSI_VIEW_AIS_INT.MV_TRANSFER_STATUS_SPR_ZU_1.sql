CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_transfer_status_spr_zu_1 (mandant_id, transfer_status_id,
transfer_status_bez) AS SELECT mandant_id,
 transfer_status_id,
 transfer_status_bez
FROM kfl_production_dbp_data.transfer_status_spr_zu_1
WHERE spr_id = 22;