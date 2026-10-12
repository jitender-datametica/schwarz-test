CREATE OR REPLACE VIEW S_CONL_WORKBENCH.V_EXPORT_DB_HANS_1
AS
(SELECT
cj_base.cost_center AS "FilialNr"
--store_map.mis_store_active_fg,
--store_map.move_fg,
--store_map.transfer_fg,
,CASE
WHEN cal.month_id=1 THEN 11
WHEN cal.month_id=2 THEN 12
WHEN cal.month_id=3 THEN 1
WHEN cal.month_id=4 THEN 2
WHEN cal.month_id=5 THEN 3
WHEN cal.month_id=6 THEN 4
WHEN cal.month_id=7 THEN 5
WHEN cal.month_id=8 THEN 6
WHEN cal.month_id=9 THEN 7
WHEN cal.month_id=10 THEN 8
WHEN cal.month_id=11 THEN 9
WHEN cal.month_id=12 THEN 10 END AS "Periode"
,cc_map.classification_1 AS "Indeling 1"
,cc_map.classification_2 AS "Indeling 2"
,cc_map.classification_3 AS "Indeling 3"
,cc_map.classification_4 AS "Indeling 4"
,COALESCE(store_map.account_manager_name, '0') AS "Indeling 5"
,COALESCE(store_map.sales_manager_name, '0') AS "Indeling 6"
,0 AS "LJBruto Omzet"
,0 AS "VJBruto Omzet"
,COALESCE(lj_turnover_sap.turnover_net, 0) AS "LJNetto Omzet"
,COALESCE(vj_turnover_sap.turnover_net, 0) AS "VJNetto Omzet"
,0 AS "LJLager Omzet"
,0 AS "VJLager Omzet"
,COALESCE(lj_hr_data.Uren_Contract_LJ, 0) AS "LJContracturen"
-- Old calculation for contracturen COALESCE(lj_hr_data.Uren_Bruto_LJ=lj_hr_data.Uren_gewerkt_HK_LJ-lj_hr_data.Uren_Meer_LJ-lj_hr_data.Uren_Verlof_ADV_LJ-lj_hr_data.Uren_Betaalde_feestdag_LJ-lj_hr_data.Uren_Ziekte_LJ-lj_hr_data.Uren_Overige_LJ, 0) AS "LJContracturen",
/* Echte contracturen*/
,COALESCE(lj_hr_data.Uren_gewerkt_HK_LJ, 0)   AS "LJGewerkte uren (Hulpkracht)"
,COALESCE(lj_hr_data.Uren_Meer_LJ , 0) AS "LJMeeruren"
,COALESCE(lj_hr_data.Uren_Verlof_ADV_LJ, 0) AS "LJOpgenomen vakantierechten/ADV"
,COALESCE(lj_hr_data.Uren_Betaalde_feestdag_LJ , 0) AS "LJBetaalde Feestdaguren"
,COALESCE(lj_hr_data.Uren_Ziekte_LJ, 0) AS "LJZiekteuren"
,COALESCE(lj_hr_data.Uren_Overige_LJ , 0) AS "LJOverig"
,COALESCE(lj_hr_data.Uren_Bruto_LJ, 0) AS "LJBruto uren"
,COALESCE("LJContracturen"+lj_hr_data.Uren_gewerkt_HK_LJ+lj_hr_data.Uren_Meer_LJ, 0) AS "LJNetto uren"
,COALESCE(vj_hr_data.Uren_Contract_LJ, 0) AS "VJContracturen"
-- Old calculation for contracturenCOALESCE(vj_hr_data.Uren_Bruto_LJ-vj_hr_data.Uren_gewerkt_HK_LJ-vj_hr_data.Uren_Meer_LJ-vj_hr_data.Uren_Verlof_ADV_LJ-vj_hr_data.Uren_Betaalde_feestdag_LJ-vj_hr_data.Uren_Ziekte_LJ-vj_hr_data.Uren_Overige_LJ , 0) AS "VJContracturen",
,COALESCE(vj_hr_data.Uren_gewerkt_HK_LJ, 0)   AS "VJGewerkte uren (Hulpkracht)"
,COALESCE(vj_hr_data.Uren_Meer_LJ , 0) AS "VJMeeruren"
,COALESCE(vj_hr_data.Uren_Verlof_ADV_LJ, 0) AS "VJOpgenomen vakantierechten/ADV"
,COALESCE(vj_hr_data.Uren_Betaalde_feestdag_LJ , 0) AS "VJBetaalde Feestdaguren"
,COALESCE(vj_hr_data.Uren_Ziekte_LJ, 0) AS "VJZiekteuren"
,COALESCE(vj_hr_data.Uren_Overige_LJ , 0) AS "VJOverig"
,COALESCE(vj_hr_data.Uren_Bruto_LJ, 0) AS "VJBruto uren"
,COALESCE("VJContracturen"+vj_hr_data.Uren_gewerkt_HK_LJ+vj_hr_data.Uren_Meer_LJ, 0) AS "VJNetto uren"
,COALESCE(lj_cost.Kosten_Contractlonen, 0)*(-1) AS "LJKosten Contractlonen"
,COALESCE(lj_cost.Kosten_Gewerkte_uren_oproep, 0)*(-1) AS "LJKosten Gewerkte uren (oproep)"
,COALESCE(lj_cost.Kosten_Meeruren, 0)*(-1) AS "LJKosten Meeruren"
,COALESCE(lj_cost.Kosten_Toeslaguren, 0)*(-1) AS "LJKosten Toeslaguren"
,COALESCE(lj_cost.Kosten_Uitbet_Vakantierechten_ADV, 0)*(-1) AS "LJKosten Uitbet. Vakantierechten/ADV"
,COALESCE(lj_cost.Kosten_Betaalde_Feestdaguren, 0)*(-1) AS "LJKosten Betaalde feestdaguren"
,COALESCE(lj_cost.Kosten_Total_Overige_TEMP, 0)*(-1) AS "LJTotaal overig"
,COALESCE(lj_cost.Kosten_Afkoopsom, 0)*(-1) AS "LJKosten Afkoopsom"
,COALESCE(lj_cost.Kosten_Ziekengeld, 0)*(-1) AS "LJKosten Ziekengeld"
,COALESCE(lj_cost.Kosten_Premiebedragen, 0)*(-1) AS "LJKosten Premiebedragen"
,COALESCE(lj_cost.Kosten_Vakantietoeslag, 0)*(-1) AS "LJKosten Vakantietoeslag"
,COALESCE(lj_cost.Kosten_Kalkulatorische_PK, 0)*(-1) AS "LJKosten Kalkulatorische PK"
,COALESCE(lj_cost.Kosten_Sociale_lasten, 0)*(-1) AS "LJKosten Sociale lasten"
,COALESCE(lj_cost.Kosten_VUT_en_Pensioen, 0)*(-1) AS "LJKosten VUT en Pensioen"
,COALESCE(lj_cost.Kosten_Overig, 0)*(-1) AS "LJKosten Overig"
,((COALESCE(lj_cost.Kosten_Total, 0)*(-1))-(COALESCE(lj_cost.Kosten_Externe, 0)*(-1))) AS "LJPersoneelskosten"
,COALESCE(vj_cost.Kosten_Contractlonen, 0)*(-1) AS "VJKosten Contractlonen"
,COALESCE(vj_cost.Kosten_Gewerkte_uren_oproep, 0)*(-1) AS "VJKosten Gewerkte uren (oproep)"
,COALESCE(vj_cost.Kosten_Meeruren, 0)*(-1) AS "VJKosten Meeruren"
,COALESCE(vj_cost.Kosten_Toeslaguren, 0)*(-1) AS "VJKosten Toeslaguren"
,COALESCE(vj_cost.Kosten_Uitbet_Vakantierechten_ADV, 0)*(-1) AS "VJKosten Uitbet. Vakantierechten/ADV"
,COALESCE(vj_cost.Kosten_Betaalde_Feestdaguren, 0)*(-1) AS "VJKosten Betaalde feestdaguren"
,COALESCE(vj_cost.Kosten_Total_Overige_TEMP, 0)*(-1) AS "VJTotaal overig"
,COALESCE(vj_cost.Kosten_Afkoopsom, 0)*(-1) AS "VJKosten Afkoopsom"
,COALESCE(vj_cost.Kosten_Ziekengeld, 0)*(-1) AS "VJKosten Ziekengeld"
,COALESCE(vj_cost.Kosten_Premiebedragen, 0)*(-1) AS "VJKosten Premiebedragen"
,COALESCE(vj_cost.Kosten_Vakantietoeslag, 0)*(-1) AS "VJKosten Vakantietoeslag"
,COALESCE(vj_cost.Kosten_Kalkulatorische_PK, 0)*(-1) AS "VJKosten Kalkulatorische PK"
,COALESCE(vj_cost.Kosten_Sociale_lasten, 0)*(-1) AS "VJKosten Sociale lasten"
,COALESCE(vj_cost.Kosten_VUT_en_Pensioen, 0)*(-1) AS "VJKosten VUT en Pensioen"
,COALESCE(vj_cost.Kosten_Overig, 0)*(-1) AS "VJKosten Overig"
,((COALESCE(vj_cost.Kosten_Total, 0)*(-1))-(COALESCE(vj_cost.Kosten_Externe, 0)*(-1))) AS "VJPersoneelskosten"
,COALESCE(lj_cost.Kosten_Externe, 0)*(-1) AS "LJKosten Externe"
,COALESCE(vj_cost.Kosten_Externe, 0)*(-1) AS "VJKosten Externe"
,COALESCE(lj_hours_external.hours_external, 0) AS "LJUren Externe"
,COALESCE(vj_hours_external.hours_external, 0)  AS "VJUren Externe"
,COALESCE(lj_mis_data.Omzet_LJ, 0) AS "LJOmzet MIS"
,COALESCE(vj_mis_data.Omzet_LJ, 0) AS "VJOmzet MIS"
,COALESCE(lj_mis_data.Klanten_LJ, 0) AS "LJKlanten MIS"
,COALESCE(vj_mis_data.Klanten_LJ, 0) AS "VJKlanten MIS"
,COALESCE(lj_mis_data.Omzet_LJ/lj_mis_data.Nettouren_LJ , 0) AS "LJLeistung"
,COALESCE(vj_mis_data.Omzet_LJ/vj_mis_data.Nettouren_LJ  , 0) AS "VJLeistung"
,COALESCE(lj_mis_data.Nettouren_LJ, 0) AS "LJLeistung stunden_1"
,COALESCE(vj_mis_data.Nettouren_LJ, 0) AS "VJLeistung stunden_1"
,COALESCE(lj_cost.Kosten_Geen_Personeelskosten, 0)*(-1) AS "LJGeen Personeelskosten"
,COALESCE(vj_cost.Kosten_Geen_Personeelskosten, 0)*(-1) AS "VJGeen Personeelskosten"
FROM
(SELECT
cte_s.cost_center AS cost_center
,cte_d.cy_month AS cy_month
,cte_d.byr AS byr
FROM
(SELECT DISTINCT cost_center
FROM s_conl_workbench.v_m_cost_center_all_1 WHERE cost_center IS NOT NULL) AS cte_s
CROSS JOIN
	(SELECT DISTINCT cy_month
,byr
FROM s_conl.v_cal_month_1 WHERE cy_month IS NOT NULL) AS cte_d
		) AS cj_base
	LEFT JOIN s_conl_workbench.v_m_cost_center_store_1 AS store_map -- Store master data 
ON cj_base.cost_center = CAST(store_map.cost_center AS VARCHAR(25))
AND store_map.cost_center NOT IN (101000
            ,201000
            ,311000
            ,401000
            ,411000
            ,501000
            ,601000
            ,101001
            ,201001
            ,311001
            ,401001
            ,411001
            ,501001
            ,601001)
LEFT JOIN s_conl.v_cal_month_1 AS cal
ON cj_base.cy_month = cal.cy_month
LEFT JOIN s_conl_workbench.v_m_cost_center_all_1 AS cc_map
ON cj_base.cost_center = cc_map.cost_center
LEFT JOIN s_conl_workbench.v_cost_store_basis_1 AS lj_cost
ON cj_base.cost_center = lj_cost.orig_store_nr
AND cj_base.cy_month = lj_cost.cy_month
LEFT JOIN s_conl_workbench.v_cost_store_basis_1 AS vj_cost
ON cj_base.cost_center = vj_cost.orig_store_nr
AND  cal.prev_cy_month = vj_cost.cy_month
LEFT JOIN s_conl_workbench.v_mstr_mis_store_1 AS lj_mis_data
ON cj_base.cost_center = CAST(lj_mis_data.Filialnummer AS VARCHAR(25))
AND cj_base.cy_month = lj_mis_data.Monat_GJ
LEFT JOIN s_conl_workbench.v_mstr_mis_store_1 AS vj_mis_data
ON cj_base.cost_center = CAST(vj_mis_data.Filialnummer AS VARCHAR(25))
AND cal.prev_cy_month = vj_mis_data.Monat_GJ
LEFT JOIN s_conl_workbench.v_mstr_hr_store_db_hans_1 AS lj_hr_data
ON cj_base.cost_center = lj_hr_data.cost_center
AND cj_base.cy_month = lj_hr_data.Monat_GJ
LEFT JOIN s_conl_workbench.v_mstr_hr_store_db_hans_1 AS vj_hr_data
ON cj_base.cost_center = vj_hr_data.cost_center
AND cal.prev_cy_month = vj_hr_data.Monat_GJ
LEFT JOIN s_conl_workbench.v_turnover_net_sap_1 AS lj_turnover_sap
ON cj_base.cost_center = lj_turnover_sap.store_nr
AND cj_base.cy_month = lj_turnover_sap.cy_month
LEFT JOIN s_conl_workbench.v_turnover_net_sap_1 AS vj_turnover_sap
ON cj_base.cost_center = vj_turnover_sap.store_nr
AND cal.prev_cy_month = vj_turnover_sap.cy_month
LEFT JOIN s_conl_workbench.t_i_wh_hours_external_1 AS lj_hours_external
ON cj_base.cost_center = lj_hours_external.cost_center
AND cj_base.cy_month = lj_hours_external.cy_month
LEFT JOIN s_conl_workbench.t_i_wh_hours_external_1 AS vj_hours_external
ON cj_base.cost_center = vj_hours_external.cost_center
AND cal.prev_cy_month= vj_hours_external.cy_month
WHERE cj_base.byr = 2021
--AND (current_date < store_map.dat_closing_ovis OR store_map.dat_closing_ovis IS NULL) Not needed because closed stores without replacement 
AND (store_map.cost_center >= 100 OR store_map.cost_center IS NULL)
AND (store_map.mis_store_active_fg = 1 OR store_map.mis_store_active_fg IS NULL)
AND (store_map.transfer_fg IS NULL
	OR store_map.transfer_fg = 0
	OR (store_map.transfer_fg = 1 AND store_map.move_fg =0))
);