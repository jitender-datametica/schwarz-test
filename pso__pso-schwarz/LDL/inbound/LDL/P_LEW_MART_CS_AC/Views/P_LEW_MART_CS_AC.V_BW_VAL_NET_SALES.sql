/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_VAL_NET_SALES
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_VAL_NET_SALES
(
  client_id
 ,iso_cd
 ,cy_month
 ,kpi_aspect
 ,wh_id
 ,wh_descr
 ,v_id
 ,v_descr
 ,currency_iso_cd
 ,turnover_wh_month_val               /* Total turnover Warehouse per month EJR net */
 ,turnover_wh_country_by_val          /* Total turnover Warehouse Business Year */
 ,turnover_country_month_val          /* Total turnover Country per month */
 ,wh_country_month_percent            /* Ratio% per level country/month, BGES/month, VGES/month */
 )
AS
   SELECT
      client_id,
   iso_cd,
   cy_month,
   kpi_aspect,
   wh_id,
   wh_descr,
   v_id,
   v_descr,
   currency_iso_cd,
   turnover_wh_month_val,
   turnover_wh_country_by_val,
   turnover_country_month_val,
   wh_country_month_percent
   FROM p_lew_mart_cs.v_bw_val_net_sales
;