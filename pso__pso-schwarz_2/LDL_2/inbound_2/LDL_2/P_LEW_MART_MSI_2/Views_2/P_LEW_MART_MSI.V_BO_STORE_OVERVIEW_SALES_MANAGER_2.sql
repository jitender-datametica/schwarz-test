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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_SALES_MANAGER_2 COMMENT='Unique Store Manager Name'
(
  sales_manager_name      COMMENT 'AUS BIL:v_location_organization_2'
)
AS
(
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_day_2
  /*
  UNION
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_week_2
  UNION
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_mth_2
  */
)
;