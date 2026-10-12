/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_PLANUMSAETZE
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_kzp_planumsaetze (client_id, country_iso_cd, valid_from, valid_to,
currency_iso_cd, cry_valid_from, cry_valid_until, tovr_gross_plan, tovr_net_plan) AS SELECT kycu.client_id,
 T.src_country_lidl_cd AS country_iso_cd,
 PARSE_DATE('%Y%m%d', CAST(kycu.min_cy_month AS STRING) || '01') AS valid_from,
 DATE_SUB(IF(PARSE_DATE('%Y%m%d', SAFE_CAST(kycu.max_cy_month as STRING) || '01') = LAST_DAY(PARSE_DATE('%Y%m%d',
       SAFE_CAST(kycu.max_cy_month as STRING) || '01')), LAST_DAY(DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(kycu.max_cy_month
        as STRING) || '01'), INTERVAL 1 MONTH)), DATE_ADD(PARSE_DATE('%Y%m%d', SAFE_CAST(kycu.max_cy_month as STRING) ||
      '01'), INTERVAL 1 MONTH)), INTERVAL 1 DAY) AS valid_to,
 kycu.currency_iso_cd,
 kycu.cry_valid_from,
 kycu.cry_valid_until,
 CAST(kycu.tovr_gross_plan AS NUMERIC) AS tovr_gross_plan,
 CAST(kycu.tovr_net_plan AS NUMERIC) AS tovr_net_plan
FROM (SELECT KPMCC.client_id,
   VCM.byr,
   KPMCC.currency_iso_cd,
   KPMCC.cry_valid_from,
   KPMCC.cry_valid_until,
   MIN(VCM.cy_month) AS min_cy_month,
   MAX(VCM.cy_month) AS max_cy_month,
   SUM(CASE
      WHEN KPMCC.indicator_id = 158
      THEN 1
      ELSE 0
      END * KPMCC.val_indicator) AS tovr_gross_plan,
   SUM(CASE
      WHEN KPMCC.indicator_id = 157
      THEN 1
      ELSE 0
      END * KPMCC.val_indicator) AS tovr_net_plan
  FROM ldl_p_lew_mart_cs.v_gen_kzp_kpges_plan_mth_country_cry AS KPMCC
   INNER JOIN ldl_p_lew_mart_cs.v_gen_cal_month AS VCM ON KPMCC.cy_month = VCM.cy_month
  WHERE KPMCC.indicator_id IN (157, 158) /* Planumsaetze netto, brutto */
  GROUP BY KPMCC.client_id,
   VCM.byr,
   KPMCC.currency_iso_cd,
   KPMCC.cry_valid_from,
   KPMCC.cry_valid_until) AS kycu
 INNER JOIN ldl_p_lew_core_ac.v_client AS C ON kycu.client_id = C.client_id
 INNER JOIN ldl_p_lew_core_ac.v_country AS T ON C.country_sid = T.country_sid;