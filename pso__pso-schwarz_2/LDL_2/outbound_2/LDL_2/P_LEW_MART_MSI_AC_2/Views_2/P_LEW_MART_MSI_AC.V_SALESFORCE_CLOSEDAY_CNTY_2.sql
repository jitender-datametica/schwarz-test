/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_SALESFORCE_CLOSEDAY_CNTY_2
 #----------------------------------------------------------------------------
 # History:
 #  1.0  19.12.2022    Wandtke,Andrzej           AP0140749 CC-Dossier - Initial Version, View based on close date
 #  1.1  11.01.2023    Wandtke,Andrzej           AP0140749_corr_views_2 - Add column srv_center_grp
 #----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_salesforce_closeday_cnty_2 AS SELECT *
FROM ldl_p_lew_mart_msi.v_salesforce_closeday_cnty_2;