CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_export_db_hans AS -- store_map.mis_store_active_fg,

-- store_map.move_fg,
 -- store_map.transfer_fg,

-- Old calculation for contracturen COALESCE(lj_hr_data.Uren_Bruto_LJ=lj_hr_data.Uren_gewerkt_HK_LJ-lj_hr_data.Uren_Meer_LJ-lj_hr_data.Uren_Verlof_ADV_LJ-lj_hr_data.Uren_Betaalde_feestdag_LJ-lj_hr_data.Uren_Ziekte_LJ-lj_hr_data.Uren_Overige_LJ, 0) AS "LJContracturen",

/* Echte contracturen */
-- Old calculation for contracturenCOALESCE(vj_hr_data.Uren_Bruto_LJ-vj_hr_data.Uren_gewerkt_HK_LJ-vj_hr_data.Uren_Meer_LJ-vj_hr_data.Uren_Verlof_ADV_LJ-vj_hr_data.Uren_Betaalde_feestdag_LJ-vj_hr_data.Uren_Ziekte_LJ-vj_hr_data.Uren_Overige_LJ , 0) AS "VJContracturen",

-- Store master data

-- AND (current_date < store_map.dat_closing_ovis OR store_map.dat_closing_ovis IS NULL) Not needed because closed stores without replacement

SELECT cte_s.cost_center AS filialnr,
  CASE
  WHEN CAL.month_id = 1
  THEN 11
  WHEN CAL.month_id = 2
  THEN 12
  WHEN CAL.month_id = 3
  THEN 1
  WHEN CAL.month_id = 4
  THEN 2
  WHEN CAL.month_id = 5
  THEN 3
  WHEN CAL.month_id = 6
  THEN 4
  WHEN CAL.month_id = 7
  THEN 5
  WHEN CAL.month_id = 8
  THEN 6
  WHEN CAL.month_id = 9
  THEN 7
  WHEN CAL.month_id = 10
  THEN 8
  WHEN CAL.month_id = 11
  THEN 9
  WHEN CAL.month_id = 12
  THEN 10
  ELSE NULL
  END AS periode,
 CC_MAP.classification_1 AS `indeling 1`,
 CC_MAP.classification_2 AS `indeling 2`,
 CC_MAP.classification_3 AS `indeling 3`,
 CC_MAP.classification_4 AS `indeling 4`,
 COALESCE(STORE_MAP.account_manager_name, '0') AS `indeling 5`,
 COALESCE(STORE_MAP.sales_manager_name, '0') AS `indeling 6`,
 0 AS `ljbruto omzet`,
 0 AS `vjbruto omzet`,
 COALESCE(LJ_TURNOVER_SAP.turnover_net, 0) AS `ljnetto omzet`,
 COALESCE(VJ_TURNOVER_SAP.turnover_net, 0) AS `vjnetto omzet`,
 0 AS `ljlager omzet`,
 0 AS `vjlager omzet`,
 COALESCE(LJ_HR_DATA.uren_contract_lj, 0) AS ljcontracturen,
 COALESCE(LJ_HR_DATA.uren_gewerkt_hk_lj, 0) AS `ljgewerkte uren _u0028_hulpkracht_u0029_`,
 COALESCE(LJ_HR_DATA.uren_meer_lj, 0) AS ljmeeruren,
 COALESCE(LJ_HR_DATA.uren_verlof_adv_lj, 0) AS `ljopgenomen vakantierechten_u002f_adv`,
 COALESCE(LJ_HR_DATA.uren_betaalde_feestdag_lj, 0) AS `ljbetaalde feestdaguren`,
 COALESCE(LJ_HR_DATA.uren_ziekte_lj, 0) AS ljziekteuren,
 COALESCE(LJ_HR_DATA.uren_overige_lj, 0) AS ljoverig,
 COALESCE(LJ_HR_DATA.uren_bruto_lj, 0) AS `ljbruto uren`,
 COALESCE(COALESCE(LJ_HR_DATA.uren_contract_lj, 0) + LJ_HR_DATA.uren_gewerkt_hk_lj + LJ_HR_DATA.uren_meer_lj, 0) AS
 `ljnetto uren`,
 COALESCE(VJ_HR_DATA.uren_contract_lj, 0) AS vjcontracturen,
 COALESCE(VJ_HR_DATA.uren_gewerkt_hk_lj, 0) AS `vjgewerkte uren _u0028_hulpkracht_u0029_`,
 COALESCE(VJ_HR_DATA.uren_meer_lj, 0) AS vjmeeruren,
 COALESCE(VJ_HR_DATA.uren_verlof_adv_lj, 0) AS `vjopgenomen vakantierechten_u002f_adv`,
 COALESCE(VJ_HR_DATA.uren_betaalde_feestdag_lj, 0) AS `vjbetaalde feestdaguren`,
 COALESCE(VJ_HR_DATA.uren_ziekte_lj, 0) AS vjziekteuren,
 COALESCE(VJ_HR_DATA.uren_overige_lj, 0) AS vjoverig,
 COALESCE(VJ_HR_DATA.uren_bruto_lj, 0) AS `vjbruto uren`,
 COALESCE(COALESCE(VJ_HR_DATA.uren_contract_lj, 0) + VJ_HR_DATA.uren_gewerkt_hk_lj + VJ_HR_DATA.uren_meer_lj, 0) AS
 `vjnetto uren`,
  COALESCE(LJ_COST.kosten_contractlonen, 0) * - 1 AS `ljkosten contractlonen`,
  COALESCE(LJ_COST.kosten_gewerkte_uren_oproep, 0) * - 1 AS `ljkosten gewerkte uren _u0028_oproep_u0029_`,
  COALESCE(LJ_COST.kosten_meeruren, 0) * - 1 AS `ljkosten meeruren`,
  COALESCE(LJ_COST.kosten_toeslaguren, 0) * - 1 AS `ljkosten toeslaguren`,
  COALESCE(LJ_COST.kosten_uitbet_vakantierechten_adv, 0) * - 1 AS `ljkosten uitbet_u002e_ vakantierechten_u002f_adv`,
  COALESCE(LJ_COST.kosten_betaalde_feestdaguren, 0) * - 1 AS `ljkosten betaalde feestdaguren`,
  COALESCE(LJ_COST.kosten_total_overige_temp, 0) * - 1 AS `ljtotaal overig`,
  COALESCE(LJ_COST.kosten_afkoopsom, 0) * - 1 AS `ljkosten afkoopsom`,
  COALESCE(LJ_COST.kosten_ziekengeld, 0) * - 1 AS `ljkosten ziekengeld`,
  COALESCE(LJ_COST.kosten_premiebedragen, 0) * - 1 AS `ljkosten premiebedragen`,
  COALESCE(LJ_COST.kosten_vakantietoeslag, 0) * - 1 AS `ljkosten vakantietoeslag`,
  COALESCE(LJ_COST.kosten_kalkulatorische_pk, 0) * - 1 AS `ljkosten kalkulatorische pk`,
  COALESCE(LJ_COST.kosten_sociale_lasten, 0) * - 1 AS `ljkosten sociale lasten`,
  COALESCE(LJ_COST.kosten_vut_en_pensioen, 0) * - 1 AS `ljkosten vut en pensioen`,
  COALESCE(LJ_COST.kosten_overig, 0) * - 1 AS `ljkosten overig`,
   COALESCE(LJ_COST.kosten_total, 0) * - 1 - COALESCE(LJ_COST.kosten_externe, 0) * - 1 AS ljpersoneelskosten,
  COALESCE(VJ_COST.kosten_contractlonen, 0) * - 1 AS `vjkosten contractlonen`,
  COALESCE(VJ_COST.kosten_gewerkte_uren_oproep, 0) * - 1 AS `vjkosten gewerkte uren _u0028_oproep_u0029_`,
  COALESCE(VJ_COST.kosten_meeruren, 0) * - 1 AS `vjkosten meeruren`,
  COALESCE(VJ_COST.kosten_toeslaguren, 0) * - 1 AS `vjkosten toeslaguren`,
  COALESCE(VJ_COST.kosten_uitbet_vakantierechten_adv, 0) * - 1 AS `vjkosten uitbet_u002e_ vakantierechten_u002f_adv`,
  COALESCE(VJ_COST.kosten_betaalde_feestdaguren, 0) * - 1 AS `vjkosten betaalde feestdaguren`,
  COALESCE(VJ_COST.kosten_total_overige_temp, 0) * - 1 AS `vjtotaal overig`,
  COALESCE(VJ_COST.kosten_afkoopsom, 0) * - 1 AS `vjkosten afkoopsom`,
  COALESCE(VJ_COST.kosten_ziekengeld, 0) * - 1 AS `vjkosten ziekengeld`,
  COALESCE(VJ_COST.kosten_premiebedragen, 0) * - 1 AS `vjkosten premiebedragen`,
  COALESCE(VJ_COST.kosten_vakantietoeslag, 0) * - 1 AS `vjkosten vakantietoeslag`,
  COALESCE(VJ_COST.kosten_kalkulatorische_pk, 0) * - 1 AS `vjkosten kalkulatorische pk`,
  COALESCE(VJ_COST.kosten_sociale_lasten, 0) * - 1 AS `vjkosten sociale lasten`,
  COALESCE(VJ_COST.kosten_vut_en_pensioen, 0) * - 1 AS `vjkosten vut en pensioen`,
  COALESCE(VJ_COST.kosten_overig, 0) * - 1 AS `vjkosten overig`,
   COALESCE(VJ_COST.kosten_total, 0) * - 1 - COALESCE(VJ_COST.kosten_externe, 0) * - 1 AS vjpersoneelskosten,
  COALESCE(LJ_COST.kosten_externe, 0) * - 1 AS `ljkosten externe`,
  COALESCE(VJ_COST.kosten_externe, 0) * - 1 AS `vjkosten externe`,
 COALESCE(LJ_HOURS_EXTERNAL.hours_external, 0) AS `ljuren externe`,
 COALESCE(VJ_HOURS_EXTERNAL.hours_external, 0) AS `vjuren externe`,
 COALESCE(LJ_MIS_DATA.omzet_lj, 0) AS `ljomzet mis`,
 COALESCE(VJ_MIS_DATA.omzet_lj, 0) AS `vjomzet mis`,
 COALESCE(LJ_MIS_DATA.klanten_lj, 0) AS `ljklanten mis`,
 COALESCE(VJ_MIS_DATA.klanten_lj, 0) AS `vjklanten mis`,
 COALESCE(LJ_MIS_DATA.omzet_lj / LJ_MIS_DATA.nettouren_lj, 0) AS ljleistung,
 COALESCE(VJ_MIS_DATA.omzet_lj / VJ_MIS_DATA.nettouren_lj, 0) AS vjleistung,
 COALESCE(LJ_MIS_DATA.nettouren_lj, 0) AS `ljleistung stunden`,
 COALESCE(VJ_MIS_DATA.nettouren_lj, 0) AS `vjleistung stunden`,
  COALESCE(LJ_COST.kosten_geen_personeelskosten, 0) * - 1 AS `ljgeen personeelskosten`,
  COALESCE(VJ_COST.kosten_geen_personeelskosten, 0) * - 1 AS `vjgeen personeelskosten`
FROM (SELECT DISTINCT cost_center
  FROM ldl_s_conl_workbench.v_m_cost_center_all
  WHERE cost_center IS NOT NULL) AS cte_s
 INNER JOIN (SELECT DISTINCT cy_month,
   byr
  FROM ldl_s_conl.v_cal_month
  WHERE cy_month IS NOT NULL) AS cte_d ON TRUE
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_store AS STORE_MAP ON cte_s.cost_center = CAST(STORE_MAP.cost_center AS STRING)
    AND STORE_MAP.cost_center NOT IN (101000, 201000, 311000, 401000, 411000, 501000, 601000, 101001, 201001, 311001,
    401001, 411001, 501001, 601001)
 LEFT JOIN ldl_s_conl.v_cal_month AS CAL ON cte_d.cy_month = CAL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_m_cost_center_all AS CC_MAP ON cte_s.cost_center = CC_MAP.cost_center
 LEFT JOIN ldl_s_conl_workbench.v_cost_store_basis AS LJ_COST ON cte_s.cost_center = LJ_COST.orig_store_nr AND cte_d.cy_month
    = CAST(LJ_COST.cy_month AS FLOAT64)
 LEFT JOIN ldl_s_conl_workbench.v_cost_store_basis AS VJ_COST ON cte_s.cost_center = VJ_COST.orig_store_nr AND CAL.prev_cy_month
    = CAST(VJ_COST.cy_month AS FLOAT64)
 LEFT JOIN ldl_s_conl_workbench.v_mstr_mis_store AS LJ_MIS_DATA ON cte_s.cost_center = CAST(LJ_MIS_DATA.filialnummer AS STRING)
    AND cte_d.cy_month = LJ_MIS_DATA.monat_gj
 LEFT JOIN ldl_s_conl_workbench.v_mstr_mis_store AS VJ_MIS_DATA ON cte_s.cost_center = CAST(VJ_MIS_DATA.filialnummer AS STRING)
    AND CAL.prev_cy_month = VJ_MIS_DATA.monat_gj
 LEFT JOIN ldl_s_conl_workbench.v_mstr_hr_store_db_hans AS LJ_HR_DATA ON cte_s.cost_center = LJ_HR_DATA.cost_center AND
   cte_d.cy_month = LJ_HR_DATA.monat_gj
 LEFT JOIN ldl_s_conl_workbench.v_mstr_hr_store_db_hans AS VJ_HR_DATA ON cte_s.cost_center = VJ_HR_DATA.cost_center AND
   CAL.prev_cy_month = VJ_HR_DATA.monat_gj
 LEFT JOIN ldl_s_conl_workbench.v_turnover_net_sap AS LJ_TURNOVER_SAP ON cte_s.cost_center = LJ_TURNOVER_SAP.store_nr
  AND cte_d.cy_month = LJ_TURNOVER_SAP.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_turnover_net_sap AS VJ_TURNOVER_SAP ON cte_s.cost_center = VJ_TURNOVER_SAP.store_nr
  AND CAL.prev_cy_month = VJ_TURNOVER_SAP.cy_month
 LEFT JOIN ldl_s_conl_workbench.t_i_wh_hours_external AS LJ_HOURS_EXTERNAL ON cte_s.cost_center = LJ_HOURS_EXTERNAL.cost_center
    AND cte_d.cy_month = CAST(LJ_HOURS_EXTERNAL.cy_month AS FLOAT64)
 LEFT JOIN ldl_s_conl_workbench.t_i_wh_hours_external AS VJ_HOURS_EXTERNAL ON cte_s.cost_center = VJ_HOURS_EXTERNAL.cost_center
     AND CAL.prev_cy_month = CAST(VJ_HOURS_EXTERNAL.cy_month AS FLOAT64) AND (STORE_MAP.transfer_fg IS NULL OR STORE_MAP
      .transfer_fg = 0 OR STORE_MAP.transfer_fg = 1 AND STORE_MAP.move_fg = 0)
WHERE cte_d.byr = 2021
 AND (STORE_MAP.cost_center IS NULL OR STORE_MAP.cost_center >= 100)
 AND (STORE_MAP.mis_store_active_fg IS NULL OR STORE_MAP.mis_store_active_fg = 1);