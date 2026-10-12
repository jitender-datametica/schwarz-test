CREATE OR REPLACE VIEW s_conl_workbench.v_cost_sap_1
AS
(SELECT
sap_c.cost_typ,
sap_c.cost_typ_desc,
sap_c.cost_center as cost_center_short,
sap_c.object_desc,
--sap_c.booking_year,
--sap_c.booking_periode,
mp.cy_month,
sap_c.saldo_amount,
sap_c.contra_account_desc,
sap_c.transcation_desc,
CASE
WHEN (
(CONTAINS(sap_c.cost_center, 'ECD01')) OR
(CONTAINS(sap_c.cost_center, 'ECG02')) OR
(CONTAINS(sap_c.cost_center, 'EC001')) OR
(CONTAINS(sap_c.cost_center, 'EC002')) OR
(CONTAINS(sap_c.cost_center, 'EC003'))
) THEN 'ECD01'
WHEN CONTAINS( sap_c.cost_center, '308106') THEN '318106' -- Moved WH Tiel to Oosterhout

WHEN CONTAINS( sap_c.cost_center, '309058') THEN '319058'
WHEN CONTAINS( sap_c.cost_center, '309068') THEN '319068'
WHEN CONTAINS( sap_c.cost_center, '309308') THEN '319308'
WHEN CONTAINS( sap_c.cost_center, '309378') THEN '319378'
WHEN CONTAINS( sap_c.cost_center, '309408') THEN '319408'
WHEN CONTAINS( sap_c.cost_center, '309628') THEN '319628'
WHEN CONTAINS( sap_c.cost_center, '309648') THEN '319648'
WHEN CONTAINS( sap_c.cost_center, '309668') THEN '319668'
WHEN length(trim(sap_c.cost_center)) = 5 THEN right(trim(sap_c.cost_center), 3)
WHEN length(trim(sap_c.cost_center)) = 6 THEN right(trim(sap_c.cost_center), 6) END as cost_center,
cost_t.cost_component_desc as cost_component_desc
FROM s_conl_workbench.t_i_cost_sap_1 as sap_c
LEFT JOIN s_conl_workbench.t_m_cost_typ_1 as cost_t
ON sap_c.cost_typ = cost_t.cost_typ
INNER JOIN s_conl_workbench.t_m_month_periode_1 as mp
ON (CASE
WHEN sap_c.booking_periode<=9 THEN sap_c.booking_year||'0'||sap_c.booking_periode
ELSE sap_c.booking_year||sap_c.booking_periode END) = mp.by_period
	where cost_t.cost_typ is not null

);




