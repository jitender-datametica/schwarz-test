/*
  AP       : AP0117801
  Workitem : 277196

  Source
    P_LEW_MART_MSI.v_bo_store_overview_day_1
    P_LEW_MART_MSI.v_bo_store_overview_week_1
    P_LEW_MART_MSI.v_bo_store_overview_mth_1
     
  History
    2022-02-03  Zied Nanaa      first creation       
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_SALES_MANAGER_1 COMMENT='Unique Store Manager Name'
(
  sales_manager_name      COMMENT 'AUS BIL:v_location_organization_1'
)
AS
(
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_day_1
  /*
  UNION
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_week_1
  UNION
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_mth_1
  */
)
;