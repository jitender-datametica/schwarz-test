CREATE OR REPLACE VIEW s_conl_workbench.v_CLA_hourly_wage_1
AS
(SELECT
cc.orig_store_nr as orig_store_nr,
mp.cy_month as cy_month,
max(TO_NUMBER(hw.CLA_hourly_wage, 38, 10)) as CLA_hourly_wage -- imported as varchar to avoid error so it needs to be cast as float at this point

FROM s_conl_workbench.t_i_hr_CLA_hourly_wage_1 as hw

LEFT JOIN s_conl_workbench.t_m_month_periode_1 as mp
ON hw.month_id = mp.month_id
AND hw.current_year = mp.current_year

LEFT JOIN s_conl_workbench.v_m_cost_center_all_1 cc
ON CASE
WHEN hw.cost_center like any ('%ECD01%','%ECG02%','%EC001%','%EC002%','%EC003%') THEN 'ECD01'
WHEN length(trim(hw.cost_center)) = 5 THEN right(trim(hw.cost_center), 3)
WHEN length(trim(hw.cost_center)) = 6 THEN trim(hw.cost_center) END =  cc.cost_center

WHERE 1=1
AND cy_month > 201702 --mapping table contains data from 201703

GROUP BY cc.orig_store_nr, mp.cy_month
);


