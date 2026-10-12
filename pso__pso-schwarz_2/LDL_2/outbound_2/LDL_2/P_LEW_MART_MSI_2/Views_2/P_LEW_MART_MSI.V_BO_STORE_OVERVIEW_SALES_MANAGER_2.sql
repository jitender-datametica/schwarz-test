/*
  AP       : AP0117801
  Workitem : 277196

  Source
    P_LEW_MART_MSI.v_bo_store_overview_day_2
    P_LEW_MART_MSI.v_bo_store_overview_week_2
    P_LEW_MART_MSI.v_bo_store_overview_mth_2
     
  History
    2022-02-03  Zied Nanaa      first creation       
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_store_overview_sales_manager_2 (sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization_2')) OPTIONS(DESCRIPTION = `UNIQUE STORE MANAGER NAME`) AS
/* UNION
  SELECT DISTINCT sales_manager_name FROM LDL.P_LEW_MART_MSI.v_bo_store_overview_week_2
  UNION
  SELECT DISTINCT sales_manager_name FROM LDL.P_LEW_MART_MSI.v_bo_store_overview_mth_2 */
SELECT DISTINCT sales_manager_name
FROM ldl_p_lew_mart_msi.v_bo_store_overview_day_2;