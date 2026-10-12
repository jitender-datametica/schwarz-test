CREATE OR REPLACE VIEW s_conl_workbench.v_cost_reservering_hk_meer_toeslag
AS
(SELECT
res.orig_store_nr as cost_center,
res.cy_month as cy_month,
res.prev_month,
res.cost_component_desc as cost_component_desc,
SUM(res.saldo_amount) as saldo_amount
FROM (SELECT
c_center.orig_store_nr,
cal_mp.cy_month,
cal_m.prev_month,
'Reservering HK-Meer-Toeslag' as cost_component_desc,
export_amount*(-1) as saldo_amount
FROM s_conl_workbench.t_i_cost_reservering_hk_meer_toeslag as cost_res
INNER JOIN s_conl_workbench.t_m_month_periode as cal_mp
ON (CASE
WHEN (cost_res.booking_periode)<10 THEN cost_res.booking_year||'0'||(cost_res.booking_periode)
ELSE cost_res.booking_year||(cost_res.booking_periode) END) = cal_mp.by_period
INNER JOIN s_conl.v_cal_month as cal_m
ON cal_mp.cy_month = cal_m.cy_month
INNER JOIN s_conl_workbench.v_m_cost_center_all as c_center
ON CASE
WHEN (
(CONTAINS(cost_res.cost_center, 'ECD01')) OR
(CONTAINS(cost_res.cost_center, 'ECG02')) OR
(CONTAINS(cost_res.cost_center, 'EC001')) OR
(CONTAINS(cost_res.cost_center, 'EC002')) OR
(CONTAINS(cost_res.cost_center, 'EC003'))
) THEN 'ECD01' -- E-Commerce

WHEN length(trim(cost_res.cost_center)) = 5 THEN right(trim(cost_res.cost_center), 3)
WHEN length(trim(cost_res.cost_center)) = 6 THEN right(trim(cost_res.cost_center), 6) END = c_center.cost_center
AND c_center.classification_2 like 'Filiaal'
AND c_center.orig_store_nr is not null
) as res

GROUP BY res.orig_store_nr, res.cy_month, res.prev_month, res.cost_component_desc

);


