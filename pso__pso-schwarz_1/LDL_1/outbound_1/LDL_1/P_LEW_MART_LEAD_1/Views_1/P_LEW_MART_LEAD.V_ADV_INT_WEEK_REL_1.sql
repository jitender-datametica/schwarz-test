CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_adv_int_week_rel_1 AS SELECT CASE
  WHEN dt.adv_wt_nr_int = 0
  THEN CW.cy_week * 10
  ELSE CW.cy_week
  END AS cy_week,
   (CW.cy_week - MOD(CAST(CW.cy_week AS BIGNUMERIC), 100)) / 100 AS cy,
 MOD(CAST(CW.cy_week AS BIGNUMERIC), 100) AS adv_week_int,
 dt.adv_wt_nr_int
FROM ldl_p_lew_core_ac.v_cal_week_1 AS CW
 INNER JOIN (SELECT 0 AS adv_wt_nr_int
   UNION ALL
   SELECT 1
   UNION ALL
   SELECT 2
   UNION ALL
   SELECT 3) AS dt ON TRUE;