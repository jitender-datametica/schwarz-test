
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_CM.V_LIL_QR_TOP_RTL_1 (
   client_id
  ,country_iso_cd
  ,rtl_id
  ,rtl_desc
  ,rtl_desc_EN
  ,qr_rtl_id
) 
TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_CM
AS
SELECT
   ra.client_id AS client_id
  ,ra.country_iso_cd
  ,ra.rtl_id AS rtl_id
  ,ra.rtl_desc AS rtl_desc
  ,ra.rtl_desc_EN AS rtl_desc_EN
  ,ra.qr_rtl_id AS qr_rtl_id
FROM (
  SELECT
     a13.client_id AS client_id
    ,a13.country_iso_cd
    ,a14.rtl_id AS rtl_id
    ,a14.rtl_desc AS rtl_desc
    ,a14.rtl_desc AS rtl_desc_EN
    ,param.top_rtl_id AS qr_rtl_id
    ,RANK () OVER(
       PARTITION BY a13.client_id
       ORDER BY SUM(
        CASE WHEN a11.meas_id = param.rnk_meas_id THEN a11.val
              ELSE 0
         END
       ) DESC
     ) AS ranking
  FROM P_LEW_MART_CM.v_lil_lift_data_act_1 AS a11
  INNER JOIN P_LEW_MART_CM.v_lil_rtl_lvl_tp_1 AS a12
  ON (a11.rtl_lvl = a12.rtl_lvl) 
  INNER JOIN P_LEW_MART_CM.v_lil_client_1 AS a13
  ON (a11.client_id = a13.client_id)
  INNER JOIN P_LEW_MART_CM.v_lil_retailer_1 AS a14
  ON (a11.rtl_id = a14.rtl_id)
  CROSS JOIN (
    SELECT CAST(MIN(DECODE(key_field, 'TOP_RTL_ID', val)) AS INTEGER) AS top_rtl_id
           ,CAST(MIN(DECODE(key_field, 'RANKING_MEAS_ID', val)) AS INTEGER) AS rnk_meas_id
    FROM P_LEW_PROCESS_MSTR_AC.v_lil_code_1
    WHERE main_code = 'QR_TOP_RTL'
      AND sub_code = 'PARAM'
  ) AS param
  WHERE a14.rtl_id NOT IN (SELECT
TO_NUMBER(val)
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'EXCL_RNK_RTL_ID')
   AND a11.per_id = (SELECT
TO_NUMBER(val) AS per_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'PER_ID' )
   AND a12.rtl_tp_id = (SELECT
TO_NUMBER(val) AS rtl_tp_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'RTL_TP_ID' )
   AND a11.lift_cat_id = (SELECT
TO_NUMBER(val) AS lift_cat_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'LIFT_CAT_ID' )
   AND a11.prom_id = (SELECT
TO_NUMBER(val) AS prom_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'PROM_ID' )
  GROUP BY
     a13.client_id
    ,a13.country_iso_cd
    ,a14.rtl_id
    ,a14.rtl_desc
    ,a14.rtl_desc_EN
    ,param.top_rtl_id
) AS ra_1
WHERE ra.ranking = 1
UNION ALL
SELECT
    a13.client_id AS client_id
  ,TRIM(a13.country_iso_cd) AS country_iso_cd
  ,a14.rtl_id AS rtl_id
  ,a14.rtl_desc AS rtl_desc
  ,a14.rtl_desc_EN AS rtl_desc_EN
  ,a14.rtl_id AS qr_rtl_id
FROM P_LEW_MART_CM.v_lil_lift_data_act_1 AS a11
INNER JOIN P_LEW_MART_CM.v_lil_rtl_lvl_tp_1 AS a12
ON (a11.rtl_lvl = a12.rtl_lvl)
INNER JOIN P_LEW_MART_CM.v_lil_client_1 AS a13
ON (a11.client_id = a13.client_id)
LEFT OUTER JOIN P_LEW_MART_CM.v_lil_retailer_1 AS a14
ON (a11.rtl_id = a14.rtl_id)
WHERE a14.rtl_id IN 
-- Anpassung für Snowflake mit try_to_numeric()
(SELECT
try_to_numeric(val)
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'FLTR_RTL_ID')
 AND a11.per_id = (SELECT
TO_NUMBER(val) AS per_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'PER_ID' )
 AND a12.rtl_tp_id = (SELECT
TO_NUMBER(val) AS rtl_tp_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'RTL_TP_ID' )
 AND a11.lift_cat_id = (SELECT
TO_NUMBER(val) AS lift_cat_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'LIFT_CAT_ID' )
 AND a11.prom_id = (SELECT
TO_NUMBER(val) AS prom_id
FROM p_lew_process_mstr_ac.v_lil_code_1
WHERE main_code = 'QR_TOP_RTL' AND sub_code = 'PARAM' AND key_field = 'PROM_ID' )
GROUP BY
   a13.client_id
  ,TRIM(a13.country_iso_cd)
  ,a14.rtl_id
  ,a14.rtl_desc
  ,a14.rtl_desc_EN;
