/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_SALES_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_VAL_NET_SALES_1
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
  ,turnover_country_month_val          /* Total turnover Country_1 per month */
  ,wh_country_month_percent            /* Ratio% per level country_1/month, BGES/month, VGES/month */
  )
AS
   SELECT
    sase_to.client_id
   ,sase_to.iso_cd                                  AS iso_cd
   ,sase_to.cy_month                                AS cy_month
   ,sase_to.kpi_aspect                              AS kpi_aspect
   ,sase_to.wh_id                                   AS wh_id
   ,sase_to.wh_descr                                AS wh_descr
   ,sase_to.v_id                                    AS v_id
   ,sase_to.v_descr                                 AS v_descr
   ,sase_to.currency_iso_cd                         AS currency_iso_cd
   ,ROUND(sase_to.turnover_wh_month_val, 2)         AS turnover_wh_month_val
   ,ROUND(sase_to.turnover_wh_country_by_val,2)     AS turnover_wh_country_by_val
   ,ROUND(sase_to.turnover_country_month_val,2)     AS turnover_country_month_val
   ,ROUND(sase_to.wh_country_month_percent,2)       AS wh_country_month_percent
   FROM
   (
   (
   SELECT
    client_id
   ,iso_cd
   ,cy_month
   ,kpi_aspect
   ,wh_id
   ,wh_descr
   ,v_id
   ,v_descr
   ,currency_iso_cd
   ,turnover_wh_month_val
   ,turnover_wh_country_by_val
   ,turnover_country_month_val
   ,wh_country_month_percent
   FROM p_lew_mart_cs.v_bw_val_net_sales_base_1 AS base_a
   )
   UNION  ALL
   (
   SELECT
   client_id
   ,iso_cd
   ,cy_month
   ,'LAND_1'                               AS kpi_aspect
   ,CAST(NULL AS INTEGER)                AS wh_id
   ,CAST(NULL AS VARCHAR(50))            AS wh_descr
   ,CAST(NULL AS VARCHAR(10))            AS v_id
   ,CAST(NULL AS VARCHAR(50))            AS v_descr
   ,currency_iso_cd
   ,ROUND(SUM(turnover_wh_month_val),2)  AS turnover_wh_month_val
   ,MAX(turnover_wh_country_by_val)      AS turnover_wh_country_by_val
   ,MAX(turnover_country_month_val)      AS turnover_country_month_val
   ,ROUND(MAX(100),2)                    AS wh_country_month_percent
   FROM p_lew_mart_cs.v_bw_val_net_sales_base_1 AS base_b
   WHERE v_id IS NULL /* part of view */
   GROUP BY
      client_id
     ,iso_cd
     ,cy_month
     ,kpi_aspect
     ,currency_iso_cd
     ,busyear
   )
   ) sase_to
;