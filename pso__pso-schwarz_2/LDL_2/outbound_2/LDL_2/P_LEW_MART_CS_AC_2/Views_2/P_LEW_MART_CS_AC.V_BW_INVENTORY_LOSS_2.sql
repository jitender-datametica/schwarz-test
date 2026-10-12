/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_INVENTORY_LOSS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_inventory_loss_2 (client_id, iso_cd, cy_month, kpi_aspect, wh_id, v_id,
currency_iso_cd, warenverlust_anlieferung_val, warenverlust_betrieb_val, warenverlust_filiale_val, warenverlust_wg_val,
anlieferung_qual_filiale_val) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_inventory_loss_2;