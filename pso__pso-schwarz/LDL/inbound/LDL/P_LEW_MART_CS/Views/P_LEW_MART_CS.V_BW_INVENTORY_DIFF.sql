/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_BW_INVENTORY_DIFF
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_BW_INVENTORY_DIFF
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
 ,inventory_diff_sic_val     /* inventurdifferenzenlautsic */
 ,inventory_turnover_sic_val /* inventurumsatzlautsic */
 ,inventory_diff_percent     /* inventurdifferenz_procent */
  )
AS
   SELECT
     inv_to.client_id
   ,inv_to.iso_cd                                  AS iso_cd
   ,inv_to.cy_month                                AS cy_month
   ,inv_to.kpi_aspect                              AS kpi_aspect
   ,inv_to.wh_id                                   AS wh_id
   ,UPPER(SUBSTRING(inv_to.wh_descr, 1, 3)) AS wh_descr
   ,inv_to.v_id                                    AS v_id
   ,UPPER(SUBSTRING(inv_to.v_descr, 1, 3))  AS v_descr
   ,inv_to.currency_iso_cd                         AS currency_iso_cd
   ,inv_to.inventory_diff_sic_val                  AS inventory_diff_sic_val
   ,inv_to.inventory_turnover_sic_val              AS inventory_turnover_sic_val
   ,inv_to.inventory_diff_percent                  AS inventory_diff_percent
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
   ,inventory_diff_sic_val
   ,inventory_turnover_sic_val
   ,inventory_diff_percent
   FROM p_lew_mart_cs.v_bw_inventory_diff_base AS base_a
   )
   UNION ALL
   (
   SELECT
    client_id
   ,iso_cd
   ,cy_month
   ,'LAND'                    AS kpi_aspect
   ,CAST(NULL AS INTEGER)     AS wh_id
   ,CAST(NULL AS VARCHAR(50)) AS wh_descr
   ,CAST(NULL AS VARCHAR(10)) AS v_id
   ,CAST(NULL AS VARCHAR(50)) AS v_descr
   ,currency_iso_cd
   ,SUM(inventory_diff_sic_val) AS inventory_diff_sic_val
   ,SUM(inventory_turnover_sic_val) AS inventory_turnover_sic_val
   ,(SUM(inventory_diff_sic_val)/ CASE WHEN SUM(inventory_turnover_sic_val) = 0 THEN NULL ELSE SUM(inventory_turnover_sic_val) END) * 100 AS inventory_diff_percent
   FROM p_lew_mart_cs.v_bw_inventory_diff_base AS base_b
   WHERE v_id IS NULL /* part of view */
   GROUP BY
     client_id
    ,iso_cd
    ,cy_month
    ,kpi_aspect
    ,currency_iso_cd
   )
   )inv_to
;