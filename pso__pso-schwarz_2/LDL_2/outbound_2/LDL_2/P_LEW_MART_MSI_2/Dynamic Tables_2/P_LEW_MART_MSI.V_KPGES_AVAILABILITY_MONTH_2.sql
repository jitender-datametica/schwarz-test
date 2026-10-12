/* 
 #DescStart# 
 #$Revision: 16641 $, $LastChangedBy: rcione $ 
 #SubjectAreas#: KPGES Views 
 # 2024-04-12 Stephane Djiomou Tonga Master Version was remigrated from Dev to Prod
 #DescEnd# 
 */


CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_kpges_availability_month_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT CLIENT.client_id,
 CAL.cy_month,
 IND.indicator_id,
  CASE
  WHEN SUM(IMONTH.val_indicator) IS NULL
  THEN 0
  ELSE 1
  END AS availability_fg
FROM ldl_p_lew_core_ac.v_cal_month_2 AS CAL
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_2 AS CLIENT ON TRUE
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_indicator_2 AS IND ON TRUE
 LEFT JOIN ldl_p_lew_bil_ac.v_kpi_month_2 AS IMONTH ON CAL.cy_month = IMONTH.cy * 100 + IMONTH.month_id AND IND.indicator_id
    = IMONTH.indicator_id
WHERE IMONTH.indicator_type_id = 1
 AND CAL.cy_month_seq BETWEEN - 26 AND 0
 AND IND.indicator_id IN (120, 125, 126, 130, 131, 133, 135, 155, 156, 163, 164, 165, 168, 169, 170, 172, 175, 177, 179
   , 180, 181, 191, 194, 195, 198, 201, 204, 205, 206, 207, 208, 209, 210, 211, 212, 216, 217, 218, 219, 220, 221, 222,
   223, 224, 227, 228, 229, 232, 233, 234, 235, 236, 238, 239, 245, 255, 256, 257, 258, 259, 260, 261, 264, 265, 266,
   267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283)
GROUP BY CLIENT.client_id,
 CAL.cy_month,
 IND.indicator_id;
