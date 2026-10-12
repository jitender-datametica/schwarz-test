CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mstr_cost_store_export_1 AS
/* Needed because wh dummies in MIS only exist on BGES (1) not VGES (2); for costs on WH level */ -- Store master data

-- vj mapping
 SELECT -- store_map.store_nr AS  filial_nr,
 STORE_MAP.store_id AS filial_id,
  CASE
  WHEN STORE_MAP.store_nr < 100
  THEN 1
  ELSE 2
  END AS ges_type_id,
 22 AS landes_id,
 CAL.cy_month AS monat_id,
 LJ.kosten_total AS kosten_total_lj,
 VJ.kosten_total AS kosten_total_vj,
 LJ.kosten_contractlonen AS kosten_contractlonen_lj,
 VJ.kosten_contractlonen AS kosten_contractlonen_vj,
 LJ.kosten_gewerkte_uren_oproep AS kosten_gewerkte_uren_oproep_lj,
 VJ.kosten_gewerkte_uren_oproep AS kosten_gewerkte_uren_oproep_vj,
 LJ.kosten_meeruren AS kosten_meeruren_lj,
 VJ.kosten_meeruren AS kosten_meeruren_vj,
 LJ.kosten_toeslaguren AS kosten_toeslaguren_lj,
 VJ.kosten_toeslaguren AS kosten_toeslaguren_vj,
 LJ.kosten_uitbet_vakantierechten_adv AS kosten_uitbet_vakantie_adv_lj,
 VJ.kosten_uitbet_vakantierechten_adv AS kosten_uitbet_vakantie_adv_vj,
 LJ.kosten_betaalde_feestdaguren AS kosten_betaalde_feestdaguren_lj,
 VJ.kosten_betaalde_feestdaguren AS kosten_betaalde_feestdaguren_vj,
 LJ.reservering_hk_meer_toeslag AS reservering_hk_meer_toeslag_lj,
 VJ.reservering_hk_meer_toeslag AS reservering_hk_meer_toeslag_vj,
 LJ.kosten_total_overige AS kosten_total_overige_lj,
 VJ.kosten_total_overige AS kosten_total_overige_vj,
 LJ.kosten_externe AS kosten_externe_lj,
 VJ.kosten_externe AS kosten_externe_vj,
 LJ.kosten_afkoopsom AS kosten_afkoopsom_lj,
 VJ.kosten_afkoopsom AS kosten_afkoopsom_vj,
 LJ.kosten_ziekengeld AS kosten_ziekengeld_lj,
 VJ.kosten_ziekengeld AS kosten_ziekengeld_vj,
 LJ.kosten_premiebedragen AS kosten_premiebedragen_lj,
 VJ.kosten_premiebedragen AS kosten_premiebedragen_vj,
 LJ.kosten_vakantietoeslag AS kosten_vakantietoeslag_lj,
 VJ.kosten_vakantietoeslag AS kosten_vakantietoeslag_vj,
 LJ.kosten_kalkulatorische_pk AS kosten_kalkulatorische_pk_lj,
 VJ.kosten_kalkulatorische_pk AS kosten_kalkulatorische_pk_vj,
 LJ.kosten_sociale_lasten AS kosten_sociale_lasten_lj,
 VJ.kosten_sociale_lasten AS kosten_sociale_lasten_vj,
 LJ.kosten_vut_en_pensioen AS kosten_vut_en_pensioen_lj,
 VJ.kosten_vut_en_pensioen AS kosten_vut_en_pensioen_vj,
 LJ.kosten_overig AS kosten_overig_lj,
 VJ.kosten_overig AS kosten_overig_vj,
 LJ.plan_turnover_netto AS umsatz_plan,
 LJ.plan_cost_total_perc AS kosten_total_plan_perc,
 LJ.plan_cost_total_abs AS kosten_total_plan,
 LJ.plan_perf_netto AS nettoleistung_plan,
 LJ.plan_perf_hours_netto AS nettostunden_plan,
 TURNOVER_SAP_LJ.turnover_net AS umsatz_sap_lj
FROM ldl_s_conl_workbench.v_cost_store_basis_1 AS LJ
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_store_1 AS STORE_MAP ON CAST(LJ.orig_store_nr AS FLOAT64) = STORE_MAP.cost_center
  
 INNER JOIN ldl_s_conl.v_cal_month_1 AS CAL ON CAST(LJ.cy_month AS FLOAT64) = CAL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_cost_store_basis_1 AS VJ ON LJ.orig_store_nr = VJ.orig_store_nr AND CAST(VJ.cy_month AS FLOAT64)
   = CAL.prev_cy_month
 LEFT JOIN ldl_s_conl.v_cal_calendarday_1 AS CAL_DAY ON STORE_MAP.dat_opening_ovis = CAL_DAY.dat_calendar
 LEFT JOIN ldl_s_conl_workbench.v_turnover_net_sap_1 AS TURNOVER_SAP_LJ ON TURNOVER_SAP_LJ.store_nr = CAST(STORE_MAP.cost_center AS STRING)
     AND CAL.cy_month = TURNOVER_SAP_LJ.cy_month AND TURNOVER_SAP_LJ.store_nr NOT LIKE 'ECD01'
WHERE CAST(LJ.cy_month AS FLOAT64) >= 201803
 AND LJ.classification_2 LIKE 'Filiaal';