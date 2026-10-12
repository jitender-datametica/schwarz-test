CREATE OR REPLACE VIEW biaid_tools_projects_production_fe_mstr_costmonitor.v_iam_azure_inventory_file_log_last_1 AS SELECT
 inventory_file_date,
 load_timestamp,
 storage_account_name,
 storage_account_tenant,
 storage_account_zone
FROM ( (SELECT inventory_file_date,
    load_timestamp,
    status_1,
    storage_account_name,
    storage_account_tenant,
    storage_account_zone
   FROM (SELECT *
     FROM biaid_tools_projects_production_etl_process.t_iam_azure_inventory_file_log_1
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY inventory_file_date, storage_account_name, storage_account_tenant,
           storage_account_zone ORDER BY load_timestamp IS NULL DESC, load_timestamp DESC)) = 1) AS t
   WHERE status_1 = 'SUCCESS'
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY storage_account_name, storage_account_tenant, storage_account_zone ORDER BY
         inventory_file_date IS NULL DESC, inventory_file_date DESC)) = 1)as LOG );