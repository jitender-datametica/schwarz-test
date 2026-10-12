CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_m_cost_center_date_cross_1 AS SELECT cc.cost_center
FROM (SELECT DISTINCT cost_center
  FROM ldl_s_conl_workbench.v_m_cost_center_all_1) AS cc
 INNER JOIN (SELECT DISTINCT cy_month
  FROM ldl_s_conl_workbench.t_i_hr_po_lead_1) AS cy_month ON TRUE;