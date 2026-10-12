/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_VAL_NET_SALES_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* Total turnover Country_1 per month */ /* Total turnover Warehouse Business Year */
/* Ratio% per level country_1/month, BGES/month, VGES/month */ /* Total turnover Warehouse per month EJR net */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_bw_val_net_sales_1 (client_id, iso_cd, cy_month, kpi_aspect, wh_id, wh_descr
, v_id, v_descr, currency_iso_cd, turnover_wh_month_val, turnover_wh_country_by_val, turnover_country_month_val,
wh_country_month_percent) AS SELECT *
FROM ldl_p_lew_mart_cs.v_bw_val_net_sales_1;