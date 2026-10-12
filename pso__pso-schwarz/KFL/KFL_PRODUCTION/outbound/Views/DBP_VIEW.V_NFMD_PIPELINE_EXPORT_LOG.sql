CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nfmd_pipeline_export_log AS SELECT mandant_id,
 execution_year,
 execution_week,
 sent_rows_cnt,
 environment_name,
 erp_guid,
 execution_tmsp
FROM kfl_production_dbp_data.nfmd_pipeline_export_log;