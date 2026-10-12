CREATE OR REPLACE VIEW s_conl_workbench.v_cost_loonjournal_post_1
AS
(SELECT
cal.cy_month as cy_month,
ljp.account_number,
ljp.cost_center_desc,
CASE
WHEN (
(CONTAINS(cost_center_desc, 'KstPl ECD01')) OR
(CONTAINS(cost_center_desc, 'KstPl ECG02')) OR
(CONTAINS(cost_center_desc, 'KstPl EC001')) OR
(CONTAINS(cost_center_desc, 'KstPl EC002')) OR
(CONTAINS(cost_center_desc, 'KstPl EC003'))
) THEN 'ECD01'	--EC001 was used in two month is the same as ECD01

WHEN CONTAINS( cost_center_desc, 'KstPl 308106') THEN '318106' -- Moved WH Tiel to Oosterhout

WHEN CONTAINS( cost_center_desc, 'KstPl 309058') THEN '319058'
WHEN CONTAINS( cost_center_desc, 'KstPl 309068') THEN '319068'
WHEN CONTAINS( cost_center_desc, 'KstPl 309308') THEN '319308'
WHEN CONTAINS( cost_center_desc, 'KstPl 309378') THEN '319378'
WHEN CONTAINS( cost_center_desc, 'KstPl 309408') THEN '319408'
WHEN CONTAINS( cost_center_desc, 'KstPl 309628') THEN '319628'
WHEN CONTAINS( cost_center_desc, 'KstPl 309648') THEN '319648'
WHEN CONTAINS( cost_center_desc, 'KstPl 309668') THEN '319668'
WHEN length(trim(cost_center_desc)) = 11 THEN right(trim(cost_center_desc), 3)
WHEN length(trim(cost_center_desc)) = 12 THEN right(trim(cost_center_desc), 6) END AS cost_center,
ljp.pay_component,
pcc.cost_component_desc,
(coalesce(ljp.debit_amount, 0) - coalesce(ljp.credit_amount,0)) as saldo_amount
FROM s_conl_workbench.t_i_cost_loonjournal_post_1  as ljp
LEFT JOIN s_conl_workbench.t_m_pay_cost_component_1 as pcc
ON left(ljp.pay_component,4) = left(pcc.pay_component_code,4) -- Changed on 20210222 from 'left(pcc.pay_component ,4)'  to left(pcc.pay_component_code,4)' 
LEFT JOIN s_conl_workbench.t_m_month_periode_1 cal
ON ljp.booking_year = cal.booking_year
AND ljp.booking_period = cal.booking_periode

);