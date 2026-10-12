CREATE OR REPLACE VIEW s_conl_workbench.v_cost_all
AS
(SELECT
cost_center,
cy_month,
cost_component_desc,
sum(saldo_amount)*(-1) as saldo_amount -- Negatieve kosten

FROM s_conl_workbench.v_cost_loonjournal_post
GROUP by cost_center, cy_month, cost_component_desc

UNION ALL
SELECT
cost_center,
cy_month,
cost_component_desc,
sum(saldo_amount)*(-1) as saldo_amount -- Negatieve kosten

FROM s_conl_workbench.v_cost_sap
GROUP by cost_center, cy_month, cost_component_desc

UNION ALL
SELECT
lm.cost_center,
lm.cy_month,
lm.cost_component_desc,
(CASE
WHEN SUBSTR( lm.cy_month, LENGTH( lm.cy_month) - 1) = '03' THEN lm.saldo_amount
ELSE (COALESCE(lm.saldo_amount,0) - COALESCE(vm.saldo_amount,0)) END)*(-1) as saldo_amount -- Negatieve kosten

FROM s_conl_workbench.v_cost_reservering_hk_meer_toeslag as lm
LEFT JOIN s_conl_workbench.v_cost_reservering_hk_meer_toeslag as vm
ON lm.cost_center = vm.cost_center
AND lm.prev_month = vm.cy_month

UNION ALL
SELECT
cost_center,
cy_month,
cost_component_desc,
sum(saldo_amount)*(-1) as saldo_amount -- Negatieve kosten

FROM s_conl_workbench.v_cost_extern
GROUP by cost_center, cy_month, cost_component_desc

);


