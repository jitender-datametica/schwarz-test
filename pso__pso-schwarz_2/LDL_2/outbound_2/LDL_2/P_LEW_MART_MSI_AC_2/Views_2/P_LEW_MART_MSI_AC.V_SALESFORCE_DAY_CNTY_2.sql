/*
 #----------------------------------------------------------------------------
 # @ LIDL Stiftung & Co. KG - DWH / MIS
 #----------------------------------------------------------------------------
 # Interface: DDL for P_LEW_MART_MSI_AC.V_SALESFORCE_DAY_CNTY_2
 #----------------------------------------------------------------------------
 # History:
 #  1.0  02.11.2022    Kitschke,Felix           Initial Version; AP0140749 CC-Dossier Views
 #  1.1  20.12.2022    Wandtke,Andrzej          AP0140749_corr_views_2 - Add cust_complaint_origin_group_name
 #  1.2  11.01.2023    Wandtke,Andrzej          AP0140749_corr_views_2 - Add srv_center_grp
 #----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_salesforce_day_cnty_2 AS SELECT *
FROM ldl_p_lew_mart_msi.v_salesforce_day_cnty_2;