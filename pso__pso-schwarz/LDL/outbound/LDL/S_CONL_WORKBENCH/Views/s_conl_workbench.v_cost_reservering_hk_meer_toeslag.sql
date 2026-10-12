CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_reservering_hk_meer_toeslag AS SELECT C_CENTER.orig_store_nr AS
 cost_center,
 CAL_MP.cy_month,
 CAL_M.prev_month,
 'Reservering HK-Meer-Toeslag' AS cost_component_desc,
 SUM(CAST(COST_RES.export_amount AS FLOAT64) * - 1) AS saldo_amount
FROM ldl_s_conl_workbench.t_i_cost_reservering_hk_meer_toeslag AS COST_RES
 INNER JOIN ldl_s_conl_workbench.t_m_month_periode AS CAL_MP ON CASE
   WHEN CAST(COST_RES.booking_periode AS FLOAT64) < 10
   THEN COST_RES.booking_year || '0' || COST_RES.booking_periode
   ELSE COST_RES.booking_year || COST_RES.booking_periode
   END = CAL_MP.by_period
 INNER JOIN ldl_s_conl.v_cal_month AS CAL_M ON CAST(CAL_MP.cy_month AS FLOAT64) = CAL_M.cy_month
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_all AS C_CENTER ON CASE
     WHEN STRPOS(COST_RES.cost_center, 'ECD01') <> 0 OR STRPOS(COST_RES.cost_center, 'ECG02') <> 0 OR STRPOS(COST_RES.cost_center
          , 'EC001') <> 0 OR STRPOS(COST_RES.cost_center, 'EC002') <> 0 OR STRPOS(COST_RES.cost_center, 'EC003') <> 0
     THEN 'ECD01' -- E-Commerce

     WHEN LENGTH(TRIM(COST_RES.cost_center)) = 5
     THEN RIGHT(TRIM(COST_RES.cost_center), 3)
     WHEN LENGTH(TRIM(COST_RES.cost_center)) = 6
     THEN RIGHT(TRIM(COST_RES.cost_center), 6)
     ELSE NULL
     END = C_CENTER.cost_center AND C_CENTER.classification_2 LIKE 'Filiaal' AND C_CENTER.orig_store_nr IS NOT NULL
GROUP BY cost_center,
 CAL_MP.cy_month,
 CAL_M.prev_month,
 cost_component_desc;