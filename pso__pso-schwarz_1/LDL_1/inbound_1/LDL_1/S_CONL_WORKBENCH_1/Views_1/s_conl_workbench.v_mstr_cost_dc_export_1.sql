CREATE OR REPLACE VIEW s_conl_workbench.v_mstr_cost_dc_export_1
AS
(SELECT
--store_map.store_nr as  filial_nr,
store_map.store_id as  filial_id,
(CASE
WHEN store_map.store_nr < 100 THEN 1
else 2 END) as  ges_type_id,
/* Needed because wh dummies in MIS only exist on BGES (1) not VGES (2); for costs on WH level*/
22 as landes_id,
cal.cy_month as monat_id,
lj.Kosten_Total as Kosten_Total_LJ,
vj.Kosten_Total as Kosten_Total_VJ,
lj.Kosten_Contractlonen as Kosten_Contractlonen_LJ,
vj.Kosten_Contractlonen as Kosten_Contractlonen_VJ,
lj.Kosten_Gewerkte_uren_oproep as Kosten_Gewerkte_Uren_Oproep_LJ,
vj.Kosten_Gewerkte_uren_oproep as Kosten_Gewerkte_Uren_Oproep_VJ,
lj.Kosten_Meeruren as Kosten_Meeruren_LJ,
vj.Kosten_Meeruren as Kosten_Meeruren_VJ,
lj.Kosten_Toeslaguren as Kosten_Toeslaguren_LJ,
vj.Kosten_Toeslaguren as Kosten_Toeslaguren_VJ,
lj.Kosten_Uitbet_Vakantierechten_ADV as Kosten_Uitbet_Vakantie_ADV_LJ,
vj.Kosten_Uitbet_Vakantierechten_ADV as Kosten_Uitbet_Vakantie_ADV_VJ,
lj.Kosten_Betaalde_Feestdaguren as Kosten_Betaalde_Feestdaguren_LJ,
vj.Kosten_Betaalde_Feestdaguren as Kosten_Betaalde_Feestdaguren_VJ,
lj.Reservering_HK_Meer_Toeslag as Reservering_HK_Meer_Toeslag_LJ,
vj.Reservering_HK_Meer_Toeslag as Reservering_HK_Meer_Toeslag_VJ,
lj.Kosten_Total_Overige as Kosten_Total_Overige_LJ,
vj.Kosten_Total_Overige as Kosten_Total_Overige_VJ,
lj.Kosten_Externe as Kosten_Externe_LJ,
vj.Kosten_Externe as Kosten_Externe_VJ,
lj.Kosten_Afkoopsom as Kosten_Afkoopsom_LJ,
vj.Kosten_Afkoopsom as Kosten_afkoopsom_VJ,
lj.Kosten_Ziekengeld as Kosten_Ziekengeld_LJ,
vj.Kosten_Ziekengeld as Kosten_Ziekengeld_VJ,
lj.Kosten_Premiebedragen as Kosten_Premiebedragen_LJ,
vj.Kosten_Premiebedragen as Kosten_Premiebedragen_VJ,
lj.Kosten_Vakantietoeslag as Kosten_Vakantietoeslag_LJ,
vj.Kosten_Vakantietoeslag as Kosten_Vakantietoeslag_VJ,
lj.Kosten_Kalkulatorische_PK as Kosten_Kalkulatorische_PK_LJ,
vj.Kosten_Kalkulatorische_PK as Kosten_Kalkulatorische_PK_VJ,
lj.Kosten_Sociale_lasten as Kosten_Sociale_lasten_LJ,
vj.Kosten_Sociale_lasten as Kosten_Sociale_lasten_VJ,
lj.Kosten_VUT_en_Pensioen as Kosten_VUT_en_Pensioen_LJ,
vj.Kosten_VUT_en_Pensioen as Kosten_VUT_en_Pensioen_VJ,
lj.Kosten_Overig as Kosten_Overig_LJ,
vj.Kosten_Overig as Kosten_Overig_VJ,
lj.plan_turnover_netto as Umsatz_Plan,
lj.plan_cost_total_perc as Kosten_Total_Plan_Perc,
lj.plan_cost_total_abs as Kosten_Total_Plan,
lj.plan_perf_netto as Nettoleistung_Plan,
lj.plan_perf_hours_netto as Nettostunden_Plan
FROM s_conl_workbench.v_cost_store_basis_1 as lj
INNER JOIN s_conl_workbench.v_m_cost_center_store_1 as store_map -- Store master data 
ON lj.orig_store_nr = store_map.cost_center
and SUBSTR(  store_map.Store_name, 1, 2) = 'DC'
INNER JOIN s_conl.v_cal_month_1 as cal -- vj mapping
ON lj.cy_month = cal.cy_month
LEFT JOIN s_conl_workbench.v_cost_store_basis_1 as vj
ON lj.orig_store_nr = vj.orig_store_nr
AND vj.cy_month = cal.prev_cy_month
LEFT JOIN s_conl.v_cal_calendarday_1 as cal_day
ON store_map.dat_opening_ovis = cal_day.dat_calendar
WHERE lj.cy_month >= 201803
AND lj.classification_2 not like 'Filiaal'
AND NOT  (store_map.store_nr=699 and cal.cy_month=201904) -- Kosten voor opening ----------------- To discuss 
  and SUBSTR(  store_map.Store_name, 1, 2) = 'DC'
);


