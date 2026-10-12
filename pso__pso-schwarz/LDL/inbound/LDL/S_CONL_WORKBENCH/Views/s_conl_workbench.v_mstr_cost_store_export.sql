CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_MSTR_COST_STORE_EXPORT
AS
(SELECT
--store_map.store_nr AS  filial_nr,
store_map.store_id AS  filial_id
,(CASE
WHEN store_map.store_nr < 100 THEN 1
ELSE 2 END) AS  ges_type_id
/* Needed because wh dummies in MIS only exist on BGES (1) not VGES (2); for costs on WH level*/
,22 AS landes_id
,cal.cy_month AS monat_id
,lj.Kosten_Total AS Kosten_Total_LJ
,vj.Kosten_Total AS Kosten_Total_VJ
,lj.Kosten_Contractlonen AS Kosten_Contractlonen_LJ
,vj.Kosten_Contractlonen AS Kosten_Contractlonen_VJ
,lj.Kosten_Gewerkte_uren_oproep AS Kosten_Gewerkte_Uren_Oproep_LJ
,vj.Kosten_Gewerkte_uren_oproep AS Kosten_Gewerkte_Uren_Oproep_VJ
,lj.Kosten_Meeruren AS Kosten_Meeruren_LJ
,vj.Kosten_Meeruren AS Kosten_Meeruren_VJ
,lj.Kosten_Toeslaguren AS Kosten_Toeslaguren_LJ
,vj.Kosten_Toeslaguren AS Kosten_Toeslaguren_VJ
,lj.Kosten_Uitbet_Vakantierechten_ADV AS Kosten_Uitbet_Vakantie_ADV_LJ
,vj.Kosten_Uitbet_Vakantierechten_ADV AS Kosten_Uitbet_Vakantie_ADV_VJ
,lj.Kosten_Betaalde_Feestdaguren AS Kosten_Betaalde_Feestdaguren_LJ
,vj.Kosten_Betaalde_Feestdaguren AS Kosten_Betaalde_Feestdaguren_VJ
,lj.Reservering_HK_Meer_Toeslag AS Reservering_HK_Meer_Toeslag_LJ
,vj.Reservering_HK_Meer_Toeslag AS Reservering_HK_Meer_Toeslag_VJ
,lj.Kosten_Total_Overige AS Kosten_Total_Overige_LJ
,vj.Kosten_Total_Overige AS Kosten_Total_Overige_VJ
,lj.Kosten_Externe AS Kosten_Externe_LJ
,vj.Kosten_Externe AS Kosten_Externe_VJ
,lj.Kosten_Afkoopsom AS Kosten_Afkoopsom_LJ
,vj.Kosten_Afkoopsom AS Kosten_afkoopsom_VJ
,lj.Kosten_Ziekengeld AS Kosten_Ziekengeld_LJ
,vj.Kosten_Ziekengeld AS Kosten_Ziekengeld_VJ
,lj.Kosten_Premiebedragen AS Kosten_Premiebedragen_LJ
,vj.Kosten_Premiebedragen AS Kosten_Premiebedragen_VJ
,lj.Kosten_Vakantietoeslag AS Kosten_Vakantietoeslag_LJ
,vj.Kosten_Vakantietoeslag AS Kosten_Vakantietoeslag_VJ
,lj.Kosten_Kalkulatorische_PK AS Kosten_Kalkulatorische_PK_LJ
,vj.Kosten_Kalkulatorische_PK AS Kosten_Kalkulatorische_PK_VJ
,lj.Kosten_Sociale_lasten AS Kosten_Sociale_lasten_LJ
,vj.Kosten_Sociale_lasten AS Kosten_Sociale_lasten_VJ
,lj.Kosten_VUT_en_Pensioen AS Kosten_VUT_en_Pensioen_LJ
,vj.Kosten_VUT_en_Pensioen AS Kosten_VUT_en_Pensioen_VJ
,lj.Kosten_Overig AS Kosten_Overig_LJ
,vj.Kosten_Overig AS Kosten_Overig_VJ
,lj.plan_turnover_netto AS Umsatz_Plan
,lj.plan_cost_total_perc AS Kosten_Total_Plan_Perc
,lj.plan_cost_total_abs AS Kosten_Total_Plan
,lj.plan_perf_netto AS Nettoleistung_Plan
,lj.plan_perf_hours_netto AS Nettostunden_Plan
,turnover_sap_lj.turnover_net AS Umsatz_SAP_LJ
FROM s_conl_workbench.v_cost_store_basis AS lj
INNER JOIN s_conl_workbench.v_m_cost_center_store AS store_map -- Store master data 
ON lj.orig_store_nr = store_map.cost_center
INNER JOIN s_conl.v_cal_month AS cal -- vj mapping
ON lj.cy_month = cal.cy_month
LEFT JOIN s_conl_workbench.v_cost_store_basis AS vj
ON lj.orig_store_nr = vj.orig_store_nr
AND vj.cy_month = cal.prev_cy_month
LEFT JOIN s_conl.v_cal_calendarday AS cal_day
ON store_map.dat_opening_ovis = cal_day.dat_calendar
LEFT JOIN s_conl_workbench.v_turnover_net_sap AS turnover_sap_lj
ON turnover_sap_lj.store_nr = CAST(store_map.cost_center AS VARCHAR(25))
AND turnover_sap_lj.cy_month = cal.cy_month
AND turnover_sap_lj.store_nr  NOT LIKE 'ECD01'
WHERE lj.cy_month >= 201803
AND lj.classification_2 LIKE 'Filiaal'
);


