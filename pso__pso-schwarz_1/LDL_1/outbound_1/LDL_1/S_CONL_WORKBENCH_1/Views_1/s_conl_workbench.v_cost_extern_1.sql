CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_cost_extern_1 AS SELECT C_CENTER.orig_store_nr AS cost_center,
 CAL_MP.cy_month,
 'Kosten Externe' AS cost_component_desc,
 CAST(COST_EXT.saldo AS FLOAT64) AS saldo_amount
FROM ldl_s_conl_workbench.t_i_cost_extern_1 AS COST_EXT
 INNER JOIN ldl_s_conl_workbench.t_m_month_periode_1 AS CAL_MP ON CASE
   WHEN CAST(COST_EXT.booking_periode AS FLOAT64) < 10
   THEN COST_EXT.booking_year || '0' || COST_EXT.booking_periode
   ELSE COST_EXT.booking_year || COST_EXT.booking_periode
   END = CAL_MP.by_period
 INNER JOIN ldl_s_conl.v_cal_month_1 AS CAL_M ON CAST(CAL_MP.cy_month AS FLOAT64) = CAL_M.cy_month
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_all_1 AS C_CENTER ON CASE
    WHEN STRPOS(COST_EXT.cost_center, 'ECD01') <> 0 OR STRPOS(COST_EXT.cost_center, 'ECG02') <> 0 OR STRPOS(COST_EXT.cost_center
         , 'EC001') <> 0 OR STRPOS(COST_EXT.cost_center, 'EC002') <> 0 OR STRPOS(COST_EXT.cost_center, 'EC003') <> 0
    THEN 'ECD01' -- E-Commerce

    WHEN LENGTH(TRIM(COST_EXT.cost_center)) = 5
    THEN RIGHT(TRIM(COST_EXT.cost_center), 3)
    WHEN LENGTH(TRIM(COST_EXT.cost_center)) = 6
    THEN RIGHT(TRIM(COST_EXT.cost_center), 6)
    ELSE NULL
    END = C_CENTER.cost_center -- AND c_center.classification_2 like 'Filiaal'
 AND C_CENTER.orig_store_nr IS NOT NULL;