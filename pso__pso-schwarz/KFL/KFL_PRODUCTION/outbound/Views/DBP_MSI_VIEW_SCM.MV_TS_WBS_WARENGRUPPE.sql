CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_warengruppe (mandant_id, auslieferungsgruppe_id, wg_id
, kjwo, estimation_fg, estimation_bez, adjustment_fg, auto_bestellmenge_mit_bestand_phase_switch_i_fg,
auto_bestellmenge_mit_bestand_phase_switch_iii_fg, auto_bestellmenge_mit_bestand_phase_switch_i_fg_std,
auto_bestellmenge_mit_bestand_phase_switch_iii_fg_std, estimation_fg_std, estimation_fg_std_bez, adjustment_fg_std,
td_insert, td_update, bonuskauf_promotionstyp, bonuskauf_promotionstyp_bez, bonuskauf_promotionstyp_std,
bonuskauf_promotionstyp_std_bez) AS SELECT WG_AUS.mandant_id,
 WG_AUS.auslieferungsgruppe_id,
 WG_AUS.wg_id,
 WOCHE.kjwo,
 COALESCE(COALESCE(WG.estimation_fg, WG_STD.estimation_fg), 0) AS estimation_fg_,
 COALESCE(L_EST.estimation_bez, '') AS estimation_bez,
 COALESCE(COALESCE(WG.adjustment_id, WG_STD.adjustment_id), 0) AS adjustment_fg,
 COALESCE(COALESCE(WG.auto_bestellmenge_mit_bestand_phase_switch_i_fg, WG_STD.auto_bestellmenge_mit_bestand_phase_switch_i_fg
   ), 0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg,
 COALESCE(COALESCE(WG.auto_bestellmenge_mit_bestand_phase_switch_iii_fg, WG_STD.auto_bestellmenge_mit_bestand_phase_switch_iii_fg
   ), 0) AS auto_bestellmenge_mit_bestand_phase_switch_iii_fg,
 COALESCE(WG_STD.auto_bestellmenge_mit_bestand_phase_switch_i_fg, 0) AS
 auto_bestellmenge_mit_bestand_phase_switch_i_fg_std,
 COALESCE(WG_STD.auto_bestellmenge_mit_bestand_phase_switch_iii_fg, 0) AS
 auto_bestellmenge_mit_bestand_phase_switch_iii_fg_std,
 COALESCE(WG_STD.estimation_fg, 0) AS estimation_fg_std,
 COALESCE(L_EST_STD.estimation_bez, '') AS estimation_fg_std_bez,
 COALESCE(WG_STD.adjustment_id, 0) AS adjustment_fg_std,
 COALESCE(WG.td_insert, WG_STD.td_insert) AS td_insert,
 COALESCE(WG.td_update, WG_STD.td_update) AS td_update,
 COALESCE(COALESCE(WG.bonuskauf_promotionstyp, WG_STD.bonuskauf_promotionstyp), '-1') AS bonuskauf_promotionstyp_,
  CASE
  WHEN COALESCE(COALESCE(WG.bonuskauf_promotionstyp, WG_STD.bonuskauf_promotionstyp), '-1') = '-1'
  THEN 'STANDARD'
  ELSE COALESCE(COALESCE(WG.bonuskauf_promotionstyp, WG_STD.bonuskauf_promotionstyp), '-1')
  END AS bonuskauf_promotionstyp_bez,
 COALESCE(WG_STD.bonuskauf_promotionstyp, '-1') AS bonuskauf_promotionstyp_std,
  CASE
  WHEN COALESCE(WG_STD.bonuskauf_promotionstyp, '-1') = '-1'
  THEN 'STANDARD'
  ELSE COALESCE(WG_STD.bonuskauf_promotionstyp, '-1')
  END AS bonuskauf_promotionstyp_bez0
FROM kfl_production_dbp_view.v_wg_auslieferungsgruppe_per AS WG_AUS
 INNER JOIN kfl_production_dbp_view.v_woche AS WOCHE ON TRUE
 LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe AS WG ON WG_AUS.mandant_id = WG.mandant_id AND WG_AUS.wg_id =
    WG.wg_id AND WOCHE.kjwo = WG.kjwo
 LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_standard AS WG_STD ON WG_AUS.mandant_id = WG_STD.mandant_id
  AND WG_AUS.wg_id = WG_STD.wg_id
 LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS L_EST ON COALESCE(COALESCE(WG.estimation_fg, WG_STD.estimation_fg
     ), 0) = L_EST.estimation_id AND WG_AUS.mandant_id = L_EST.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS L_EST_STD ON COALESCE(WG_STD.estimation_fg, 0) = L_EST_STD.estimation_id
    AND WG_AUS.mandant_id = L_EST_STD.mandant_id
WHERE WG_AUS.dat_bis = DATE '9999-12-31'
 AND WOCHE.akt_wo BETWEEN 0 AND 30
UNION DISTINCT
SELECT WG_AUS.mandant_id,
 WG_AUS.auslieferungsgruppe_id,
 WG_AUS.wg_id,
 WOCHE.kjwo,
 COALESCE(WG_STD.estimation_fg, 0) AS estimation_fg_,
 COALESCE(L_EST.estimation_bez, '') AS estimation_bez,
 COALESCE(WG_STD.adjustment_id, 0) AS adjustment_fg,
 COALESCE(WG_STD.auto_bestellmenge_mit_bestand_phase_switch_i_fg, 0) AS auto_bestellmenge_mit_bestand_phase_switch_i_fg
 ,
 COALESCE(WG_STD.auto_bestellmenge_mit_bestand_phase_switch_iii_fg, 0) AS
 auto_bestellmenge_mit_bestand_phase_switch_iii_fg,
 COALESCE(WG_STD.auto_bestellmenge_mit_bestand_phase_switch_i_fg, 0) AS
 auto_bestellmenge_mit_bestand_phase_switch_i_fg_std,
 COALESCE(WG_STD.auto_bestellmenge_mit_bestand_phase_switch_iii_fg, 0) AS
 auto_bestellmenge_mit_bestand_phase_switch_iii_fg_std,
 COALESCE(WG_STD.estimation_fg, 0) AS estimation_fg_std,
 COALESCE(L_EST_STD.estimation_bez, '') AS estimation_fg_std_bez,
 COALESCE(WG_STD.adjustment_id, 0) AS adjustment_fg_std,
 WG_STD.td_insert,
 WG_STD.td_update,
 COALESCE(WG_STD.bonuskauf_promotionstyp, '-1') AS bonuskauf_promotionstyp_,
  CASE
  WHEN COALESCE(WG_STD.bonuskauf_promotionstyp, '-1') = '-1'
  THEN 'STANDARD'
  ELSE COALESCE(WG_STD.bonuskauf_promotionstyp, '-1')
  END AS bonuskauf_promotionstyp_bez,
 COALESCE(WG_STD.bonuskauf_promotionstyp, '-1') AS bonuskauf_promotionstyp_std,
  CASE
  WHEN COALESCE(WG_STD.bonuskauf_promotionstyp, '-1') = '-1'
  THEN 'STANDARD'
  ELSE COALESCE(WG_STD.bonuskauf_promotionstyp, '-1')
  END AS bonuskauf_promotionstyp_bez0
FROM kfl_production_dbp_view.v_wg_auslieferungsgruppe_per AS WG_AUS
 INNER JOIN kfl_production_dbp_view.v_woche AS WOCHE ON TRUE
 LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_standard AS WG_STD ON WG_AUS.mandant_id = WG_STD.mandant_id
  AND WG_AUS.wg_id = WG_STD.wg_id
 LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS L_EST ON COALESCE(WG_STD.estimation_fg, 0) = L_EST.estimation_id
    AND WG_AUS.mandant_id = L_EST.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS L_EST_STD ON COALESCE(WG_STD.estimation_fg, 0) = L_EST_STD.estimation_id
    AND WG_AUS.mandant_id = L_EST_STD.mandant_id
WHERE WG_AUS.dat_bis = DATE '9999-12-31'
 AND WOCHE.akt_wo BETWEEN 0 AND 30
 AND NOT EXISTS (SELECT mandant_id,
    WG_AUS.auslieferungsgruppe_id AS auslieferungsgruppe_id,
   wg_id,
   bonuskauf_promotionstyp
  FROM kfl_production_dbp_msi_data.ts_wbs_warengruppe AS WG
  WHERE mandant_id = WG_STD.mandant_id
   AND wg_id = WG_STD.wg_id
   AND bonuskauf_promotionstyp = WG_STD.bonuskauf_promotionstyp);