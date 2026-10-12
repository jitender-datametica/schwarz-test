CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_msi_ds_log_1 AS SELECT mandant_id,
 msi_report_id,
 ds_report_start,
 msi_projekt_name,
 msi_report_name,
 msi_user_id,
 ds_report_ende,
 ds_status_fg,
 ds_info
FROM kfl_production_dbp_msi_data.msi_ds_log_1;