/*
  AP       : AP0117801
  Workitem : 277196

  Source
    P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_SALES_MANAGER_1
     
  History
    2022-02-03  Zied Nanaa      first creation       
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_BO_STORE_OVERVIEW_SALES_MANAGER_1 COMMENT='Unique Store Manager Name'
(
  sales_manager_name      COMMENT 'AUS BIL:v_location_organization_1'
)
AS
(
  SELECT sales_manager_name FROM P_LEW_MART_MSI.V_BO_STORE_OVERVIEW_SALES_MANAGER_1
)
;