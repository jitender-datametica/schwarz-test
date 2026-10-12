/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_BW_VAL_NET_SALES_PERC_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_VAL_NET_SALES_PERC_1
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
 ,brand_descr
 ,wgi
 ,turnover
 ,turnover_percent
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
   brand_descr,
   wgi,
   turnover,
   turnover_percent
   FROM p_lew_mart_cs.v_bw_val_net_sales_perc_1
;