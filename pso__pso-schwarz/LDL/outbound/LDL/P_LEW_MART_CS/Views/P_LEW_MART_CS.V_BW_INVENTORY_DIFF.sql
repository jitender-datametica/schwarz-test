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


/* inventurumsatzlautsic */ /* inventurdifferenz_procent */ /* inventurdifferenzenlautsic */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_bw_inventory_diff (client_id, iso_cd, cy_month, kpi_aspect, wh_id, wh_descr,
v_id, v_descr, currency_iso_cd, inventory_diff_sic_val, inventory_turnover_sic_val, inventory_diff_percent) AS
/* part of view */ SELECT client_id,
 iso_cd,
 cy_month,
 kpi_aspect,
 wh_id,
 UPPER(SUBSTR(wh_descr, 1, 3)) AS wh_descr,
 v_id,
 UPPER(SUBSTR(v_descr, 1, 3)) AS v_descr,
 currency_iso_cd,
 inventory_diff_sic_val,
 inventory_turnover_sic_val,
 inventory_diff_percent
FROM (SELECT *
   FROM ldl_p_lew_mart_cs.v_bw_inventory_diff_base AS BASE_A
   UNION ALL
   SELECT client_id,
    iso_cd,
    cy_month,
    'LAND' AS kpi_aspect,
    CAST(NULL AS BIGNUMERIC) AS wh_id,
    CAST(NULL AS STRING) AS wh_descr,
    CAST(NULL AS INTEGER) AS v_id,
    CAST(NULL AS STRING) AS v_descr,
    currency_iso_cd,
    SUM(inventory_diff_sic_val) AS inventory_diff_sic_val,
    SUM(inventory_turnover_sic_val) AS inventory_turnover_sic_val,
      SUM(inventory_diff_sic_val) / CASE
       WHEN SUM(inventory_turnover_sic_val) = 0
       THEN NULL
       ELSE SUM(inventory_turnover_sic_val)
       END * 100 AS inventory_diff_percent
   FROM ldl_p_lew_mart_cs.v_bw_inventory_diff_base AS BASE_B
   WHERE v_id IS NULL
   GROUP BY client_id,
    iso_cd,
    cy_month,
    BASE_B.kpi_aspect,
    currency_iso_cd) AS inv_to;