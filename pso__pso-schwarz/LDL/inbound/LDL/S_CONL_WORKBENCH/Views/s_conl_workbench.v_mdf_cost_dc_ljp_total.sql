CREATE OR REPLACE VIEW s_conl_workbench.v_mdf_cost_dc_ljp_total
AS
(
-- Loonjournaalposten intern
SELECT
'Ljp' as cost_group,
business_year,
booking_month,
warehouse_nr,
cast(cost_center as varchar(15)) as cost_center,
cast(cost_component_desc as varchar(35)) as cost_component_desc,
cast(sum(saldo_amount_lj)*-1 as Number(38,5)) as saldo_amount_lj,
cast(sum(saldo_amount_vj)*-1 as Number(38,5)) as saldo_amount_vj
FROM s_conl_workbench.v_mdf_cost_dc_loonjournaalpost
group by
 business_year
,booking_month
,warehouse_nr
,cast(cost_center as varchar(15))
,cast(cost_component_desc as varchar(35))

Union all
-- Loonjournaalposten SAP
SELECT
'Sap' as cost_group,
business_year,
booking_month,
warehouse_nr,
cast(cost_center as varchar(15)) as cost_center,
cast(cost_component_desc as varchar(35)) as cost_component_desc,
cast(sum(saldo_amount_lj)*-1 as Number(38,5)) as saldo_amount_lj,
cast(sum(saldo_amount_vj)*-1 as Number(38,5)) as saldo_amount_vj
FROM s_conl_workbench.v_mdf_cost_dc_sap
group by
 business_year
,booking_month
,warehouse_nr
,cast(cost_center as varchar(15))
,cast(cost_component_desc as varchar(35))

Union all
-- Loonjournaalposten extern
SELECT
'Extern' as cost_group,
business_year,
booking_month,
warehouse_nr,
cast(cost_center as varchar(15)) as cost_center,
cast(cost_component_desc as varchar(35)) as cost_component_desc,
cast(sum(saldo_amount_lj)*-1 as Number(38,5)) as saldo_amount_lj,
cast(sum(saldo_amount_vj)*-1 as Number(38,5)) as saldo_amount_vj
FROM s_conl_workbench.v_mdf_cost_dc_extern
group by
 business_year
,booking_month
,warehouse_nr
,cast(cost_center as varchar(15))
,cast(cost_component_desc as varchar(35))

);


