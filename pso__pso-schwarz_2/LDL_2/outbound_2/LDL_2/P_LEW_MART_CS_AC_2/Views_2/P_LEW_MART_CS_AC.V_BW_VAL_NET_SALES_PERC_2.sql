/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_VAL_NET_SALES_PERC_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_val_net_sales_perc_2 (client_id, iso_cd, cy_month, kpi_aspect, wh_id,
wh_descr, v_id, v_descr, currency_iso_cd, brand_descr, wgi, turnover, turnover_percent) AS SELECT client_id,
 iso_cd,
 cy_month,
 kpi_aspect,
 wh_id,
 wh_descr,
 v_id,
 v_descr,
 currency_iso_cd,
 brand_descr,
 wgi,
 turnover,
 turnover_percent
FROM ldl_p_lew_mart_cs.v_bw_val_net_sales_perc_2;