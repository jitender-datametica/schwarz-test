
CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cm.v_lil_qr_top_rtl
 AS
SELECT A13.client_id,
 A13.country_iso_cd,
 A14.rtl_id,
 A14.rtl_desc,
 A14.rtl_desc AS rtl_desc_en,
 param.top_rtl_id AS qr_rtl_id
FROM ldl_p_lew_mart_cm.v_lil_lift_data_act AS A11
 INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp AS A12 ON A11.rtl_lvl = A12.rtl_lvl
 INNER JOIN ldl_p_lew_mart_cm.v_lil_client AS A13 ON A11.client_id = A13.client_id
 INNER JOIN ldl_p_lew_mart_cm.v_lil_retailer AS A14 ON A11.rtl_id = A14.rtl_id
 INNER JOIN (SELECT ROUND(CAST(MIN(CASE
       WHEN key_field = 'TOP_RTL_ID'
       THEN val
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS top_rtl_id,
   ROUND(CAST(MIN(CASE
       WHEN key_field = 'RANKING_MEAS_ID'
       THEN val
       ELSE NULL
       END) AS BIGNUMERIC), 0) AS rnk_meas_id
  FROM ldl_p_lew_process_mstr_ac.v_lil_code
  WHERE main_code = 'QR_TOP_RTL'
   AND sub_code = 'PARAM') AS param ON TRUE
WHERE A11.per_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS per_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'PER_ID')
 AND A12.rtl_tp_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS rtl_tp_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'RTL_TP_ID')
 AND A11.lift_cat_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS lift_cat_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'LIFT_CAT_ID')
 AND A11.prom_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS prom_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'PROM_ID')
 AND A14.rtl_id NOT IN (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS a1026334723
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'EXCL_RNK_RTL_ID')
GROUP BY A13.client_id,
 A13.country_iso_cd,
 A14.rtl_id,
 A14.rtl_desc,
 A14.rtl_desc_en,
 qr_rtl_id
QUALIFY (RANK() OVER (PARTITION BY CAST(A13.client_id AS STRING) ORDER BY SUM(CASE
        WHEN A11.meas_id = param.rnk_meas_id
        THEN A11.val
        ELSE 0
        END) IS NULL DESC, SUM(CASE
        WHEN A11.meas_id = param.rnk_meas_id
        THEN A11.val
        ELSE 0
        END) DESC)) = 1
UNION ALL
SELECT A13.client_id,
 TRIM(A13.country_iso_cd) AS country_iso_cd,
 A14.rtl_id,
 A14.rtl_desc,
 A14.rtl_desc_en,
 A14.rtl_id AS qr_rtl_id
FROM ldl_p_lew_mart_cm.v_lil_lift_data_act AS A11
 INNER JOIN ldl_p_lew_mart_cm.v_lil_rtl_lvl_tp AS A12 ON A11.rtl_lvl = A12.rtl_lvl
 INNER JOIN ldl_p_lew_mart_cm.v_lil_client AS A13 ON A11.client_id = A13.client_id
 LEFT JOIN ldl_p_lew_mart_cm.v_lil_retailer AS A14 ON A11.rtl_id = A14.rtl_id
WHERE A14.rtl_id IN (SELECT ROUND(SAFE_CAST(val AS BIGNUMERIC), 0) AS a302912701
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'FLTR_RTL_ID')
 AND A11.per_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS per_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'PER_ID')
 AND A12.rtl_tp_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS rtl_tp_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'RTL_TP_ID')
 AND A11.lift_cat_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS lift_cat_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'LIFT_CAT_ID')
 AND A11.prom_id = (SELECT ROUND(CAST(val AS BIGNUMERIC), 0) AS prom_id
   FROM ldl_p_lew_process_mstr_ac.v_lil_code
   WHERE main_code = 'QR_TOP_RTL'
    AND sub_code = 'PARAM'
    AND key_field = 'PROM_ID')
GROUP BY A13.client_id,
 country_iso_cd,
 A14.rtl_id,
 A14.rtl_desc,
 A14.rtl_desc_en;


