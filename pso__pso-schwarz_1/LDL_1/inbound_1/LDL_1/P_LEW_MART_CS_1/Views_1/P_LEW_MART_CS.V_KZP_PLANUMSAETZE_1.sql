/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_KZP_PLANUMSAETZE_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_KZP_PLANUMSAETZE_1
(
client_id
, country_iso_cd
, valid_from
, valid_to
, currency_iso_cd
, cry_valid_from
, cry_valid_until
, tovr_gross_plan
, tovr_net_plan
)
AS
   SELECT
   kycu.client_id,
   t.src_country_lidl_cd                          AS country_iso_cd,
   TO_DATE(CAST(kycu.min_cy_month AS VARCHAR(6)) || '01', 'YYYYMMDD') AS valid_from,
   ADD_MONTHS(TO_DATE(CAST(kycu.max_cy_month AS VARCHAR(6)) || '01', 'YYYYMMDD'), 1) - 1  AS valid_to,
   kycu.currency_iso_cd                           AS currency_iso_cd,
   kycu.cry_valid_from,
   kycu.cry_valid_until,
   CAST(kycu.tovr_gross_plan AS DECIMAL(18,4))    AS tovr_gross_plan,
   CAST(kycu.tovr_net_plan AS DECIMAL(18,4))    AS tovr_net_plan
   FROM (SELECT
   kpmcc.client_id,
   vcm.byr,
   kpmcc.currency_iso_cd,
   kpmcc.cry_valid_from,
   kpmcc.cry_valid_until,
   MIN(vcm.cy_month) AS min_cy_month,
   MAX(vcm.cy_month) AS max_cy_month,
   SUM(CASE WHEN kpmcc.indicator_id=158 THEN 1 ELSE 0 END * kpmcc.val_indicator) AS tovr_gross_plan,
   SUM(CASE WHEN kpmcc.indicator_id=157 THEN 1 ELSE 0 END * kpmcc.val_indicator) AS tovr_net_plan
   FROM p_lew_mart_cs.v_gen_kzp_kpges_plan_mth_country_cry_1 kpmcc
   INNER JOIN p_lew_mart_cs.v_gen_cal_month_1 vcm
   ON vcm.cy_month = kpmcc.cy_month

   WHERE kpmcc.indicator_id IN (157, 158) /* Planumsaetze netto, brutto */

   GROUP BY 1,2,3,4,5
) AS kycu
   INNER JOIN p_lew_core_ac.v_client_1 c
   ON kycu.client_id = c.client_id
   INNER JOIN p_lew_core_ac.v_country_1 t
   ON c.country_sid = t.country_sid
;