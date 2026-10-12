CREATE OR REPLACE VIEW s_conl_workbench.v_g_logistics_rates_1
AS
(SELECT
TO_NUMBER(cc.cost_center) as cost_center,
TO_NUMBER(('20'||lr.year_month)) as cy_month,
cc.classification_1 as classification_1,
cc.classification_2 as classification_2,
cc.classification_3 as classification_3,
CASE
WHEN cc.classification_4 = 'De Graaf Non Food' THEN 'De Graaf'
ELSE cc.classification_4 END as classification_4,
lr.hourly_rate as hourly_rate,
lr.kilometer_rate as kilometer_rate
FROM s_conl_workbench.t_i_g_logistics_rates_1 lr

LEFT JOIN s_conl_workbench.v_m_cost_center_all_1 cc
ON 'Gesellschaft' = cc.classification_1
AND 'Lager' = cc.classification_2
AND lr.dc = cc.classification_3
AND 'Warenbereitstellung' = cc.classification_4

);


