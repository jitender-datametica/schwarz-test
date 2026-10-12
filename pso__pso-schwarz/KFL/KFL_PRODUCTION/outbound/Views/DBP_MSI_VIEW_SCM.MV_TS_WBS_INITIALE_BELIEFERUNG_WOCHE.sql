CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_initiale_belieferung_woche (mandant_id,
ausliefergruppe_id, kjwo, werbe_start_wtag_id, werbe_ende_wtag_id, anz_tage_werbe_dauer, init_lief_markt_cluster_id,
estimation_id, estimation_bez, anz_ame_split_grenze, auto_split_fg, auto_split_prozent,
anz_tage_vor_akt_lieferstart_auto_split_ame, anz_pal_auto_split_grenze, anz_tage_vor_akt_lieferstart_auto_split_pal,
anz_tage_auto_split_pal, anz_tage_fix_split_mhd_grenze, unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent, unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent, unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent, unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent, unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent, unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent, unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent, unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent, unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent, ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent, ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent, ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent, ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent, ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent, ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent, ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent, ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent, anz_tage_phase_switch_i, anz_tage_phase_switch_ii,
anz_tage_phase_switch_iii, anz_tage_phase_switch_iv, standard_fg, update_fg) AS SELECT WBS_IB_S.mandant_id,
 WBS_IB_S.ausliefergruppe_id,
 w.kjwo,
 WBS_IB_S.werbe_start_wtag_id,
 WBS_IB_S.werbe_ende_wtag_id,
 WBS_IB_S.anz_tage_werbe_dauer,
 COALESCE(WBS_IB_S.init_lief_markt_cluster_id, 1) AS init_lief_markt_cluster_id,
 COALESCE(WBS_IB_S.estimation_id, 1) AS estimation_id,
 COALESCE(L_EST.estimation_bez, 'standard estimation (WBS)') AS estimation_bez,
 WBS_IB_S.anz_ame_split_grenze,
 WBS_IB_S.auto_split_fg,
 WBS_IB_S.auto_split_prozent,
 WBS_IB_S.anz_tage_vor_akt_lieferstart_auto_split_ame,
 WBS_IB_S.anz_pal_auto_split_grenze,
 WBS_IB_S.anz_tage_vor_akt_lieferstart_auto_split_pal,
 WBS_IB_S.anz_tage_auto_split_pal,
 WBS_IB_S.anz_tage_fix_split_mhd_grenze,
 WBS_IB_S.unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
 WBS_IB_S.anz_tage_phase_switch_i,
 WBS_IB_S.anz_tage_phase_switch_ii,
 WBS_IB_S.anz_tage_phase_switch_iii,
 WBS_IB_S.anz_tage_phase_switch_iv,
 1 AS standard_fg,
 0 AS update_fg
FROM kfl_production_dbp_msi_data.ts_wbs_initiale_belieferung_standard AS WBS_IB_S
 LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS L_EST ON COALESCE(WBS_IB_S.estimation_id, 0) = L_EST.estimation_id
    AND WBS_IB_S.mandant_id = L_EST.mandant_id
 INNER JOIN (SELECT DISTINCT kjwo,
   akt_wo
  FROM kfl_production_dbp_view.v_woche) AS w ON w.akt_wo BETWEEN 0 AND 6
UNION DISTINCT
SELECT WBS_IB_S.mandant_id,
 WBS_IB_S.ausliefergruppe_id,
 COALESCE(WBS_IB_W.kjwo, w.kjwo) AS kjwo,
 WBS_IB_S.werbe_start_wtag_id,
 WBS_IB_S.werbe_ende_wtag_id,
 WBS_IB_S.anz_tage_werbe_dauer,
 COALESCE(WBS_IB_S.init_lief_markt_cluster_id, 1) AS init_lief_markt_cluster_id,
 COALESCE(WBS_IB_S.estimation_id, 1) AS estimation_id,
 COALESCE(L_EST.estimation_bez, 'standard estimation (WBS)') AS estimation_bez,
 COALESCE(WBS_IB_W.anz_ame_split_grenze, WBS_IB_S.anz_ame_split_grenze) AS anz_ame_split_grenze,
 COALESCE(WBS_IB_W.auto_split_fg, WBS_IB_S.auto_split_fg) AS auto_split_fg,
 COALESCE(WBS_IB_W.auto_split_prozent, WBS_IB_S.auto_split_prozent) AS auto_split_prozent,
 COALESCE(WBS_IB_W.anz_tage_vor_akt_lieferstart_auto_split_ame, WBS_IB_S.anz_tage_vor_akt_lieferstart_auto_split_ame) AS
 anz_tage_vor_akt_lieferstart_auto_split_ame,
 COALESCE(WBS_IB_W.anz_pal_auto_split_grenze, WBS_IB_S.anz_pal_auto_split_grenze) AS anz_pal_auto_split_grenze,
 COALESCE(WBS_IB_W.anz_tage_vor_akt_lieferstart_auto_split_pal, WBS_IB_S.anz_tage_vor_akt_lieferstart_auto_split_pal) AS
 anz_tage_vor_akt_lieferstart_auto_split_pal,
 COALESCE(WBS_IB_W.anz_tage_auto_split_pal, WBS_IB_S.anz_tage_auto_split_pal) AS anz_tage_auto_split_pal,
 COALESCE(WBS_IB_W.anz_tage_fix_split_mhd_grenze, WBS_IB_S.anz_tage_fix_split_mhd_grenze) AS
 anz_tage_fix_split_mhd_grenze,
 COALESCE(WBS_IB_W.unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent
  ) AS unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent, WBS_IB_S.ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent
  ) AS ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent,
 COALESCE(WBS_IB_W.anz_tage_phase_switch_i, WBS_IB_S.anz_tage_phase_switch_i) AS anz_tage_phase_switch_i,
 COALESCE(WBS_IB_W.anz_tage_phase_switch_ii, WBS_IB_S.anz_tage_phase_switch_ii) AS anz_tage_phase_switch_ii,
 COALESCE(WBS_IB_W.anz_tage_phase_switch_iii, WBS_IB_S.anz_tage_phase_switch_iii) AS anz_tage_phase_switch_iii,
 COALESCE(WBS_IB_W.anz_tage_phase_switch_iv, WBS_IB_S.anz_tage_phase_switch_iv) AS anz_tage_phase_switch_iv,
 0 AS standard_fg,
 COALESCE(CASE
   WHEN WBS_IB_W.anz_ame_split_grenze <> WBS_IB_S.anz_ame_split_grenze OR WBS_IB_W.auto_split_fg <> WBS_IB_S.auto_split_fg
          OR (WBS_IB_W.auto_split_prozent <> WBS_IB_S.auto_split_prozent OR (WBS_IB_W.anz_tage_vor_akt_lieferstart_auto_split_ame
             <> WBS_IB_S.anz_tage_vor_akt_lieferstart_auto_split_ame OR WBS_IB_W.anz_pal_auto_split_grenze <> WBS_IB_S.anz_pal_auto_split_grenze
            )) OR (WBS_IB_W.anz_tage_vor_akt_lieferstart_auto_split_pal <> WBS_IB_S.anz_tage_vor_akt_lieferstart_auto_split_pal
           OR (WBS_IB_W.anz_tage_auto_split_pal <> WBS_IB_S.anz_tage_auto_split_pal OR WBS_IB_W.anz_tage_fix_split_mhd_grenze
             <> WBS_IB_S.anz_tage_fix_split_mhd_grenze) OR (WBS_IB_W.unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent
            <> WBS_IB_S.unter_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent OR (WBS_IB_W.unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.unter_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent OR WBS_IB_W.unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.unter_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent))) OR (WBS_IB_W.unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent
           <> WBS_IB_S.unter_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent OR (WBS_IB_W.unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent
             <> WBS_IB_S.unter_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent OR WBS_IB_W.unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent
             <> WBS_IB_S.unter_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent) OR (WBS_IB_W.unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent
            <> WBS_IB_S.unter_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent OR (WBS_IB_W.unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.unter_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent OR WBS_IB_W.unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent
              <> WBS_IB_S.unter_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent)) OR (WBS_IB_W.unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent
            <> WBS_IB_S.unter_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent OR (WBS_IB_W.unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent
              <> WBS_IB_S.unter_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent OR WBS_IB_W.unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent
              <> WBS_IB_S.unter_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent) OR (WBS_IB_W.unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent
             <> WBS_IB_S.unter_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent OR (WBS_IB_W.unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent
               <> WBS_IB_S.unter_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent OR WBS_IB_W.unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent
               <> WBS_IB_S.unter_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent)))) OR (WBS_IB_W.unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent
           <> WBS_IB_S.unter_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent OR WBS_IB_W.unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent
           <> WBS_IB_S.unter_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent
            <> WBS_IB_S.ueber_mhd_grenze_7_tage_vor_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.ueber_mhd_grenze_6_tage_vor_werbestart_fix_split_prozent OR WBS_IB_W.ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.ueber_mhd_grenze_5_tage_vor_werbestart_fix_split_prozent)) OR (WBS_IB_W.ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent
            <> WBS_IB_S.ueber_mhd_grenze_4_tage_vor_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.ueber_mhd_grenze_3_tage_vor_werbestart_fix_split_prozent OR WBS_IB_W.ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent
              <> WBS_IB_S.ueber_mhd_grenze_2_tage_vor_werbestart_fix_split_prozent) OR (WBS_IB_W.ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent
             <> WBS_IB_S.ueber_mhd_grenze_1_tage_vor_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent
               <> WBS_IB_S.ueber_mhd_grenze_0_tage_vor_werbestart_fix_split_prozent OR WBS_IB_W.ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent
               <> WBS_IB_S.ueber_mhd_grenze_1_tage_nach_werbestart_fix_split_prozent))) OR (WBS_IB_W.ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent
            <> WBS_IB_S.ueber_mhd_grenze_2_tage_nach_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent
              <> WBS_IB_S.ueber_mhd_grenze_3_tage_nach_werbestart_fix_split_prozent OR WBS_IB_W.ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent
              <> WBS_IB_S.ueber_mhd_grenze_4_tage_nach_werbestart_fix_split_prozent) OR (WBS_IB_W.ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent
             <> WBS_IB_S.ueber_mhd_grenze_5_tage_nach_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent
               <> WBS_IB_S.ueber_mhd_grenze_6_tage_nach_werbestart_fix_split_prozent OR WBS_IB_W.ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent
               <> WBS_IB_S.ueber_mhd_grenze_7_tage_nach_werbestart_fix_split_prozent)) OR (WBS_IB_W.ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent
             <> WBS_IB_S.ueber_mhd_grenze_8_tage_nach_werbestart_fix_split_prozent OR (WBS_IB_W.ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent
               <> WBS_IB_S.ueber_mhd_grenze_9_tage_nach_werbestart_fix_split_prozent OR WBS_IB_W.anz_tage_phase_switch_i
               <> WBS_IB_S.anz_tage_phase_switch_i) OR (WBS_IB_W.anz_tage_phase_switch_ii <> WBS_IB_S.anz_tage_phase_switch_ii
              OR (WBS_IB_W.anz_tage_phase_switch_iii <> WBS_IB_S.anz_tage_phase_switch_iii OR WBS_IB_W.anz_tage_phase_switch_iv
                <> WBS_IB_S.anz_tage_phase_switch_iv)))))
   THEN 1
   ELSE 0
   END, 0) AS update_fg
FROM kfl_production_dbp_msi_data.ts_wbs_initiale_belieferung_standard AS WBS_IB_S
 LEFT JOIN kfl_production_dbp_view.v_wbs_l_estimation AS L_EST ON COALESCE(WBS_IB_S.estimation_id, 0) = L_EST.estimation_id
    AND WBS_IB_S.mandant_id = L_EST.mandant_id
 INNER JOIN (SELECT DISTINCT kjwo,
   akt_wo
  FROM kfl_production_dbp_view.v_woche) AS w ON w.akt_wo BETWEEN 0 AND 6
 LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_initiale_belieferung_woche AS WBS_IB_W ON WBS_IB_S.mandant_id = WBS_IB_W.mandant_id
          AND WBS_IB_S.ausliefergruppe_id = WBS_IB_W.ausliefergruppe_id AND WBS_IB_S.werbe_start_wtag_id = WBS_IB_W.werbe_start_wtag_id
         AND WBS_IB_S.werbe_ende_wtag_id = WBS_IB_W.werbe_ende_wtag_id AND WBS_IB_S.estimation_id = WBS_IB_W.estimation_id
       AND WBS_IB_S.init_lief_markt_cluster_id = WBS_IB_W.init_lief_markt_cluster_id AND w.kjwo = WBS_IB_W.kjwo AND
   WBS_IB_S.anz_tage_werbe_dauer = WBS_IB_W.anz_tage_werbe_dauer;