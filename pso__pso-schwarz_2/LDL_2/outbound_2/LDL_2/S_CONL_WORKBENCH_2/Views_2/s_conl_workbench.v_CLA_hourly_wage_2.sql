CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cla_hourly_wage_2 AS
-- imported as STRING to avoid error so it needs to be cast as float at this point
 SELECT CC.orig_store_nr,
 MP.cy_month,
 MAX(CAST(HW.cla_hourly_wage AS BIGNUMERIC)) AS cla_hourly_wage
FROM ldl_s_conl_workbench.t_i_hr_cla_hourly_wage_2 AS HW
 LEFT JOIN ldl_s_conl_workbench.t_m_month_periode_2 AS MP ON HW.month_id = CAST(MP.month_id AS FLOAT64) AND HW.current_year
    = CAST(MP.current_year AS FLOAT64)
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all_2 AS CC ON CASE
   WHEN HW.cost_center LIKE '%ECD01%' OR HW.cost_center LIKE '%ECG02%' OR HW.cost_center LIKE '%EC001%' OR HW.cost_center
      LIKE '%EC002%' OR HW.cost_center LIKE '%EC003%'
   THEN 'ECD01'
   WHEN LENGTH(TRIM(HW.cost_center)) = 5
   THEN RIGHT(TRIM(HW.cost_center), 3)
   WHEN LENGTH(TRIM(HW.cost_center)) = 6
   THEN TRIM(HW.cost_center)
   ELSE NULL
   END = CC.cost_center
WHERE CAST(MP.cy_month AS FLOAT64) > 201702 -- mapping table contains data from 201703

GROUP BY CC.orig_store_nr,
 MP.cy_month;