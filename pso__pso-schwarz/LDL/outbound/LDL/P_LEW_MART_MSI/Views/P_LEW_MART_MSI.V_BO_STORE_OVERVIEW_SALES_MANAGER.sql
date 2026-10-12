/*
  AP       : AP0117801
  Workitem : 277196

  Source
    P_LEW_MART_MSI.v_bo_store_overview_day
    P_LEW_MART_MSI.v_bo_store_overview_week
    P_LEW_MART_MSI.v_bo_store_overview_mth
     
  History
    2022-02-03  Zied Nanaa      first creation       
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_bo_store_overview_sales_manager (sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization')) OPTIONS(DESCRIPTION = `UNIQUE STORE MANAGER NAME`) AS
/* UNION
  SELECT DISTINCT sales_manager_name FROM LDL.P_LEW_MART_MSI.v_bo_store_overview_week
  UNION
  SELECT DISTINCT sales_manager_name FROM LDL.P_LEW_MART_MSI.v_bo_store_overview_mth */
SELECT DISTINCT sales_manager_name
FROM ldl_p_lew_mart_msi.v_bo_store_overview_day;