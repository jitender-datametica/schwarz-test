CREATE OR REPLACE VIEW ldl_s_conl_workbench.v_mstr_cost_store_2 AS -- Store master data
 -- vj mapping

-- Kosten voor opening ----------------- To discuss
 SELECT 'Nederland' AS land_2,
 STORE_MAP.store_nr AS filialnummer,
 STORE_MAP.store_name AS filialname,
 STORE_MAP.wh_id AS ges_nummer,
 STORE_MAP.wh_name AS ges_name,
 STORE_MAP.account_manager_name AS vertriebsleiter,
 STORE_MAP.sales_manager_name AS verkaufsleiter,
 STORE_MAP.longitude AS lengtegraad,
 STORE_MAP.latitude AS breedtegraad,
 -- Verkaufsfläche
 STORE_MAP.dat_opening_ovis AS eroeffnungsdatum,
 STORE_MAP.dat_closing_ovis AS `schließungsdatum`,
 CAL.cy AS kalenderjahr,
 CAL.byr AS geschaeftsjahr,
 CAL.month_id AS monat_nr,
 CAL.cy_month AS monat_gj,
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
 LJ.plan_perf_hours_netto AS nettostunden_plan
FROM ldl_s_conl_workbench.v_cost_store_basis_2 AS LJ
 INNER JOIN ldl_s_conl_workbench.v_m_cost_center_store_2 AS STORE_MAP ON CAST(LJ.orig_store_nr AS FLOAT64) = STORE_MAP.cost_center
  
 INNER JOIN ldl_s_conl.v_cal_month_2 AS CAL ON CAST(LJ.cy_month AS FLOAT64) = CAL.cy_month
 LEFT JOIN ldl_s_conl_workbench.v_cost_store_basis_2 AS VJ ON LJ.orig_store_nr = VJ.orig_store_nr AND CAST(VJ.cy_month AS FLOAT64)
   = CAL.prev_cy_month
 LEFT JOIN ldl_s_conl.v_cal_calendarday_2 AS CAL_DAY ON STORE_MAP.dat_opening_ovis = CAL_DAY.dat_calendar
WHERE CAST(LJ.cy_month AS FLOAT64) >= 201803
 AND (STORE_MAP.store_nr <> 699 OR CAL.cy_month <> 201904);