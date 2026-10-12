-- KFL_PRODUCTION_CLONE_SCM.DBP_MSI_VIEW_SCM.MV_TS_WBS_ARTIKEL_VZ_1 source


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_ts_wbs_artikel_vz_1 AS WITH DAT_EINGREZUNG AS (SELECT mandant_id
   ,
   MAX(dat_beladung) AS max_dat_beladung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1
  GROUP BY mandant_id) (SELECT V00.mandant_id,
   V00.ausliefergruppe_id,
   V00.kjwo,
   V00.offer_id AS angebot_id,
   V00.aktion_id,
   V00.art_id,
   V00.wup_id_vz,
   V00.nb_id_vz,
   V00.mandant_id_vz,
   MAX(COALESCE(V01.clear_stock_id, 0)) AS clear_stock_id,
   MAX(COALESCE(V10.clear_stock_bez, 'kein')) AS clear_stock_bez,
   MAX(COALESCE(COALESCE(COALESCE(V01.estimation_fg, WG.estimation_fg), WG_STD.estimation_fg), 0)) AS estimation_fg,
   MAX(COALESCE(V01.max_kapa_fg, 0)) AS max_kapa_fg,
   MAX(COALESCE(COALESCE(COALESCE(V01.adjustment_id, WG.adjustment_id), WG_STD.adjustment_id), 0)) AS adjustment_fg,
   MAX(V01.dat_letzte_nachversorgung) AS dat_letzte_nachversorgung
  FROM kfl_production_dbp_view.v_wbs_werbeaenderungen_1 AS V00
   INNER JOIN DAT_EINGREZUNG AS v99 ON V00.mandant_id = v99.mandant_id AND V00.dat_beladung = v99.max_dat_beladung
   LEFT JOIN kfl_production_dbp_view.v_ts_wbs_artikel_vz_1 AS V01 ON V00.mandant_id = V01.mandant_id AND V00.ausliefergruppe_id
             = V01.ausliefergruppe_id AND V00.kjwo = V01.kjwo AND V00.offer_id = V01.angebot_id AND V00.aktion_id = V01
         .aktion_id AND V00.art_id = V01.art_id AND V00.wup_id_vz = V01.wup_id_vz AND V00.nb_id_vz = V01.nb_id_vz AND
     V00.mandant_id_vz = V01.mandant_id_vz
   LEFT JOIN kfl_production_dbp_view.v_l_clear_stock_1 AS V10 ON V01.clear_stock_id = V10.clear_stock_id AND V01.mandant_id
      = V10.mandant_id
   INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS WG_ZU ON V00.mandant_id = WG_ZU.mandant_id AND V00.art_id =
       WG_ZU.art_id AND WG_ZU.arthiertyp_id = 2 AND WG_ZU.dat_bis = DATE '9999-12-31'
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_1 AS WG ON WG_ZU.mandant_id = WG.mandant_id AND WG_ZU.wg_id =
      WG.wg_id AND V00.kjwo = WG.kjwo
   LEFT JOIN kfl_production_dbp_msi_data.ts_wbs_warengruppe_standard_1 AS WG_STD ON WG_ZU.mandant_id = WG_STD.mandant_id
    AND WG_ZU.wg_id = WG_STD.wg_id
  GROUP BY V00.mandant_id,
   V00.ausliefergruppe_id,
   V00.kjwo,
   angebot_id,
   V00.aktion_id,
   V00.art_id,
   V00.wup_id_vz,
   V00.nb_id_vz,
   V00.mandant_id_vz);