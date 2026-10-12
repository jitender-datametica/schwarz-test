CREATE OR REPLACE VIEW s_conl_workbench.v_m_cost_center_date_cross_2
AS
(SELECT
cost_center
FROM
(SELECT
DISTINCT(cost_center)
FROM s_conl_workbench.v_m_cost_center_all_2
) as cc

CROSS JOIN

(SELECT
DISTINCT(cy_month)
FROM s_conl_workbench.t_i_hr_po_lead_2
) as cy_month


);


