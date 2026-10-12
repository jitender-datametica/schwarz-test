CREATE OR REPLACE VIEW s_conl_workbench.v_cost_store_basis_1
AS
(SELECT
store_cost.orig_store_nr as orig_store_nr,
store_cost.cy_month as cy_month,
store_cost.classification_2,
store_cost.Kosten_Total,
store_cost.Kosten_Contractlonen,
store_cost.Kosten_Gewerkte_uren_oproep,
store_cost.Kosten_Meeruren,
store_cost.Kosten_Toeslaguren,
store_cost.Kosten_Uitbet_Vakantierechten_ADV,
store_cost.Kosten_Betaalde_feestdaguren,
store_cost.Reservering_HK_Meer_Toeslag,
store_cost.Kosten_Total_Overige_TEMP as Kosten_Total_Overige_TEMP,
store_cost.Kosten_Total_Overige as Kosten_Total_Overige,
store_cost.Kosten_Externe,
store_cost.Kosten_Afkoopsom,
store_cost.Kosten_Ziekengeld,
store_cost.Kosten_Premiebedragen,
store_cost.Kosten_Vakantietoeslag,
store_cost.Kosten_Kalkulatorische_PK,
store_cost.Kosten_Sociale_lasten,
store_cost.Kosten_VUT_en_Pensioen,
store_cost.Kosten_Overig,
store_cost.Kosten_Geen_Personeelskosten,
plan.plan_turnover_netto,
plan.plan_cost_total_perc,
plan.plan_cost_total_abs,
plan.plan_perf_netto,
plan.plan_perf_hours_netto
FROM
(SELECT
c_center.orig_store_nr as orig_store_nr,
all_cost.cy_month as cy_month,
c_center.classification_2 as classification_2,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Contractlonen') THEN all_cost.saldo_amount
else 0 END) as Kosten_Contractlonen,
/* Todo: Add SAP LJ cost*/
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Gewerkte uren (oproep)') THEN all_cost.saldo_amount
else 0 END) as Kosten_Gewerkte_uren_oproep,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Meeruren') THEN all_cost.saldo_amount
else 0 END) as Kosten_Meeruren,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Toeslaguren') THEN all_cost.saldo_amount
else 0 END) as Kosten_Toeslaguren,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Uitbet. Vakantierechten/ADV') THEN all_cost.saldo_amount
else 0 END) as Kosten_Uitbet_Vakantierechten_ADV,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Betaalde feestdaguren') THEN all_cost.saldo_amount
else 0 END) as Kosten_Betaalde_feestdaguren,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Reservering HK-Meer-Toeslag') THEN all_cost.saldo_amount
else 0 END) as Reservering_HK_Meer_Toeslag,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Externe') THEN all_cost.saldo_amount
else 0 END) as Kosten_Externe,

--Uitsplitsing overige kosten
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Afkoopsom') THEN all_cost.saldo_amount
else 0 END) as Kosten_Afkoopsom,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Ziekengeld') THEN all_cost.saldo_amount
else 0 END) as Kosten_Ziekengeld,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Premiebedragen') THEN all_cost.saldo_amount
else 0 END) as Kosten_Premiebedragen,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Vakantietoeslag') THEN all_cost.saldo_amount
else 0 END) as Kosten_Vakantietoeslag,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Kalkulatorische PK') THEN all_cost.saldo_amount
else 0 END) as Kosten_Kalkulatorische_PK,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Sociale lasten') THEN all_cost.saldo_amount
else 0 END) as Kosten_Sociale_lasten,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten VUT en Pensioen') THEN all_cost.saldo_amount
else 0 END) as Kosten_VUT_en_Pensioen,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Kosten Overig') THEN all_cost.saldo_amount
else 0 END) as Kosten_Overig,
sum(CASE
WHEN all_cost.cost_component_desc  like '%Kosten Afkoopsom%' or
     all_cost.cost_component_desc  like '%Kosten Ziekengeld%' or
     all_cost.cost_component_desc  like '%Kosten Premiebedragen%' or
     all_cost.cost_component_desc  like '%Kosten Vakantietoeslag%'or
     all_cost.cost_component_desc  like '%Kosten Kalkulatorische PK%'or 
     all_cost.cost_component_desc  like '%Kosten Sociale lasten%'or 
     all_cost.cost_component_desc  like '%Kosten VUT en Pensioen%' or
     all_cost.cost_component_desc   like '%Kosten Overig%' 

THEN all_cost.saldo_amount
else 0 END) as Kosten_Total_Overige_TEMP,
 
Kosten_Total_Overige_TEMP - Reservering_HK_Meer_Toeslag as Kosten_Total_Overige,
(Kosten_Contractlonen
	+Kosten_Gewerkte_uren_oproep
	+Kosten_Meeruren
	+Kosten_Toeslaguren
	+Kosten_Uitbet_Vakantierechten_ADV
	+Kosten_Betaalde_feestdaguren
	+Kosten_Total_Overige
	+Reservering_HK_Meer_Toeslag
	+Kosten_Externe)
as Kosten_Total,
sum(CASE
WHEN CONTAINS( all_cost.cost_component_desc, 'Geen Personeelskosten') THEN all_cost.saldo_amount
else 0 END) as Kosten_Geen_Personeelskosten
FROM s_conl_workbench.v_cost_all_1 as all_cost
INNER JOIN s_conl_workbench.v_m_cost_center_all_1 as c_center
ON all_cost.cost_center = c_center.cost_center
AND c_center.orig_store_nr is not null
GROUP BY
c_center.orig_store_nr,
all_cost.cy_month,
c_center.classification_2
) as  store_cost
LEFT JOIN s_conl_workbench.v_cost_perf_plan_fm101_1 as plan
ON  store_cost.orig_store_nr = plan.orig_store_nr
AND store_cost.cy_month = plan.cy_month

);








