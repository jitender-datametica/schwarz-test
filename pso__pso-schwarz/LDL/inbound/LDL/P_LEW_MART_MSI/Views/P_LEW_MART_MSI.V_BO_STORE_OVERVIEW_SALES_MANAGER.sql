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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_SALES_MANAGER COMMENT='Unique Store Manager Name'
(
  sales_manager_name      COMMENT 'AUS BIL:v_location_organization'
)
AS
(
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_day
  /*
  UNION
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_week
  UNION
  SELECT DISTINCT sales_manager_name FROM P_LEW_MART_MSI.v_bo_store_overview_mth
  */
)
;