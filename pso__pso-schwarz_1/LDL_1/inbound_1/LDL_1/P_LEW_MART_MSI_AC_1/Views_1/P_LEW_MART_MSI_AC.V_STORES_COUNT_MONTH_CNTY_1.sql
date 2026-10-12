/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_STORES_COUNT_MONTH_CNTY_1
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #----------------------------------------------------------------------------
 */

CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_STORES_COUNT_MONTH_CNTY_1 AS
SELECT
  cy_month
  ,client_id
  ,num_stores
FROM
  P_LEW_MART_MSI.V_STORES_COUNT_MONTH_CNTY_1;