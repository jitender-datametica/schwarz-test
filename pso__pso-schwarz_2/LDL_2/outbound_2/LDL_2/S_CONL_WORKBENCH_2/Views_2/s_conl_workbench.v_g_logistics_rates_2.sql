CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_g_logistics_rates_2 AS SELECT ROUND(CAST(CC.cost_center AS BIGNUMERIC), 0)
 AS cost_center,
 ROUND(CAST('20' || LR.year_month AS BIGNUMERIC), 0) AS cy_month,
 CC.classification_1,
 CC.classification_2,
 CC.classification_3,
  CASE
  WHEN CC.classification_4 = 'De Graaf Non Food'
  THEN 'De Graaf'
  ELSE CC.classification_4
  END AS classification_4,
 LR.hourly_rate,
 LR.kilometer_rate
FROM ldl_s_conl_workbench.t_i_g_logistics_rates_2 AS LR
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all_2 AS CC ON 'Gesellschaft' = CC.classification_1 AND 'Lager' = CC.classification_2
      AND LR.dc = CC.classification_3 AND 'Warenbereitstellung' = CC.classification_4;