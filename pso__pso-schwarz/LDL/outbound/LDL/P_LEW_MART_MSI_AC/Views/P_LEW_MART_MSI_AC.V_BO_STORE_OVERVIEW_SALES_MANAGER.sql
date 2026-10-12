/*
  AP       : AP0117801
  Workitem : 277196

  Source
    P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_SALES_MANAGER
     
  History
    2022-02-03  Zied Nanaa      first creation       
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_bo_store_overview_sales_manager (sales_manager_name
OPTIONS(description='AUS BIL:v_location_organization')) OPTIONS(DESCRIPTION = `UNIQUE STORE MANAGER NAME`) AS SELECT *
FROM ldl_p_lew_mart_msi.v_bo_store_overview_sales_manager;