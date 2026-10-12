/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_VAL_NET_SALES
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* Total turnover Warehouse Business Year */ /* Total turnover Country per month */
/* Ratio% per level country/month, BGES/month, VGES/month */ /* Total turnover Warehouse per month EJR net */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_val_net_sales (client_id, iso_cd, cy_month, kpi_aspect, wh_id, wh_descr,
v_id, v_descr, currency_iso_cd, turnover_wh_month_val, turnover_wh_country_by_val, turnover_country_month_val,
wh_country_month_percent) AS /* part of view */ SELECT client_id,
 iso_cd,
 cy_month,
 kpi_aspect,
 wh_id,
 wh_descr,
 v_id,
 v_descr,
 currency_iso_cd,
 ROUND(turnover_wh_month_val, 2) AS turnover_wh_month_val,
 ROUND(turnover_wh_country_by_val, 2) AS turnover_wh_country_by_val,
 ROUND(turnover_country_month_val, 2) AS turnover_country_month_val,
 ROUND(wh_country_month_percent, 2) AS wh_country_month_percent
FROM (SELECT client_id,
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
   FROM ldl_p_lew_mart_cs.v_bw_val_net_sales_base AS BASE_A
   UNION ALL
   SELECT client_id,
    iso_cd,
    cy_month,
    'LAND' AS kpi_aspect,
    CAST(NULL AS BIGNUMERIC) AS wh_id,
    CAST(NULL AS STRING) AS wh_descr,
    CAST(NULL AS BIGNUMERIC) AS v_id,
    CAST(NULL AS STRING) AS v_descr,
    currency_iso_cd,
    ROUND(SUM(turnover_wh_month_val), 2) AS turnover_wh_month_val,
    MAX(turnover_wh_country_by_val) AS turnover_wh_country_by_val,
    MAX(turnover_country_month_val) AS turnover_country_month_val,
    ROUND(MAX(100), 2) AS wh_country_month_percent
   FROM ldl_p_lew_mart_cs.v_bw_val_net_sales_base AS BASE_B
   WHERE v_id IS NULL
   GROUP BY client_id,
    iso_cd,
    cy_month,
    BASE_B.kpi_aspect,
    currency_iso_cd,
    busyear) AS sase_to;