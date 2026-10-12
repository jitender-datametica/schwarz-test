CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_wup_autodispo_tag_dif_bme AS SELECT F.mandant_id,
 F.kunde_id,
 F.art_id,
 WG.wg_id,
 F.dat,
 MAX(CASE
   WHEN TS.dif_typ_id = 1
   THEN TS.dif_kommentar
   ELSE NULL
   END) AS dif_komm_mult,
 MAX(CASE
   WHEN TS.dif_typ_id = 2
   THEN TS.dif_kommentar
   ELSE NULL
   END) AS dif_komm_add,
 MAX(CASE
   WHEN TS.dif_typ_id = 3
   THEN TS.dif_kommentar
   ELSE NULL
   END) AS dif_komm_abs,
 EXP(SUM(LN(CASE
     WHEN TS.dif_typ_id = 1
     THEN TS.dif_wert
     ELSE NULL
     END))) AS dif_mult,
 SUM(CASE
   WHEN TS.dif_typ_id = 2
   THEN TS.dif_wert / F.egalisierungsfaktor
   ELSE NULL
   END) AS dif_add,
 AVG(CASE
   WHEN TS.dif_typ_id = 3
   THEN TS.dif_wert / F.egalisierungsfaktor
   ELSE NULL
   END) AS dif_abs,
 SUM(CASE
   WHEN TS.dif_typ_id = 1
   THEN 1
   ELSE 0
   END) AS anz_dif_mult,
 SUM(CASE
   WHEN TS.dif_typ_id = 2
   THEN 1
   ELSE 0
   END) AS anz_dif_add,
 SUM(CASE
   WHEN TS.dif_typ_id = 3
   THEN 1
   ELSE 0
   END) AS anz_dif_abs,
 MAX(CASE
   WHEN TS.dif_typ_id = 1 AND TS.dif_status_id = 1
   THEN TS.dif_kommentar
   ELSE NULL
   END) AS dif_komm_mult_exp,
 MAX(CASE
   WHEN TS.dif_typ_id = 2 AND TS.dif_status_id = 1
   THEN TS.dif_kommentar
   ELSE NULL
   END) AS dif_komm_add_exp,
 MAX(CASE
   WHEN TS.dif_typ_id = 3 AND TS.dif_status_id = 1
   THEN TS.dif_kommentar
   ELSE NULL
   END) AS dif_komm_abs_exp,
 EXP(SUM(LN(CASE
     WHEN TS.dif_typ_id = 1 AND TS.dif_status_id = 1
     THEN TS.dif_wert
     ELSE NULL
     END))) AS dif_mult_exp,
 SUM(CASE
   WHEN TS.dif_typ_id = 2 AND TS.dif_status_id = 1
   THEN TS.dif_wert / F.egalisierungsfaktor
   ELSE NULL
   END) AS dif_add_exp,
 AVG(CASE
   WHEN TS.dif_typ_id = 3 AND TS.dif_status_id = 1
   THEN TS.dif_wert / F.egalisierungsfaktor
   ELSE NULL
   END) AS dif_abs_exp,
 SUM(CASE
   WHEN TS.dif_typ_id = 1 AND TS.dif_status_id = 1
   THEN 1
   ELSE 0
   END) AS anz_dif_mult_exp,
 SUM(CASE
   WHEN TS.dif_typ_id = 2 AND TS.dif_status_id = 1
   THEN 1
   ELSE 0
   END) AS anz_dif_add_exp,
 SUM(CASE
   WHEN TS.dif_typ_id = 3 AND TS.dif_status_id = 1
   THEN 1
   ELSE 0
   END) AS anz_dif_abs_exp
FROM kfl_production_dbp_view.v_art_wup_autodispo_flw_tag AS F
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON F.dat = T.dat AND T.akt_tag BETWEEN - 7 AND 30 AND T.wtag_id <> 7
 INNER JOIN kfl_production_dbp_view.v_wup AS W ON F.mandant_id = W.mandant_id AND F.kunde_id = W.wup_id AND F.nb_id_kunde
    = W.nb_id
 LEFT JOIN kfl_production_dbp_view.v_wupcal_ereignis_zu AS WE ON W.mandant_id = WE.mandant_id AND W.wup_id = WE.wup_id
  AND F.dat = WE.dat
 INNER JOIN kfl_production_dbp_view.v_art AS A ON F.art_id = A.art_id AND F.mandant_id = A.mandant_id AND A.artikeltyp_id
    <> 12
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per AS WG ON F.art_id = WG.art_id AND F.dat BETWEEN WG.dat_von AND WG.dat_bis
      AND F.mandant_id = WG.mandant_id AND WG.arthiertyp_id = 2
 LEFT JOIN kfl_production_dbp_view.v_art_art_gruppe_flw AS AGF ON F.mandant_id = AGF.mandant_id AND F.art_id = AGF.art_id
   
 INNER JOIN kfl_production_dbp_msi_v_view.v_wup_denorm AS WD ON F.mandant_id = WD.mandant_id AND F.kunde_id = WD.wup_id
 INNER JOIN kfl_production_dbp_view.v_wup_marktmerkmal_zu_per AS MM ON F.mandant_id = MM.mandant_id AND F.kunde_id = MM
     .wup_id AND MM.marktmerkmal_id = '0051' AND F.dat BETWEEN MM.dat_von AND MM.dat_bis
 INNER JOIN kfl_production_dbp_view.v_marktmerkmal_wert_spr_zu AS MMW ON MM.marktmerkmal_id = MMW.marktmerkmal_id AND MM
    .marktmerkmal_wert = MMW.marktmerkmal_wert AND MMW.spr_id = 22
 INNER JOIN kfl_production_dbp_view.v_ts_autodispo_dif AS TS ON F.dat BETWEEN TS.dat_von AND TS.dat_bis AND F.mandant_id
         = TS.mandant_id_kunde AND F.menge_einh_id = TS.menge_einh_id AND CASE
       WHEN TS.wup_id_kunde <> - 1
       THEN CAST(TS.wup_id_kunde AS STRING)
       WHEN TS.vkl_id <> - 1
       THEN CAST(TS.vkl_id AS STRING)
       WHEN TS.werbegruppe_fleisch <> '-1'
       THEN CAST(TS.werbegruppe_fleisch AS STRING)
       WHEN TS.frische_manager_id <> - 1
       THEN CAST(TS.frische_manager_id AS STRING)
       WHEN TS.vs_id <> - 1
       THEN CAST(TS.vs_id AS STRING)
       ELSE CAST(TS.mandant_id_kunde AS STRING)
       END = CASE
       WHEN TS.wup_id_kunde <> - 1
       THEN CAST(W.wup_id AS STRING)
       WHEN TS.vkl_id <> - 1
       THEN CAST(W.vkl_id AS STRING)
       WHEN TS.werbegruppe_fleisch <> '-1'
       THEN CAST(MMW.marktmerkmal_wert AS STRING)
       WHEN TS.frische_manager_id <> - 1
       THEN CAST(WD.frische_manager_id AS STRING)
       WHEN TS.vs_id <> - 1
       THEN CAST(W.vs_id AS STRING)
       ELSE CAST(W.mandant_id AS STRING)
       END AND CASE
      WHEN TS.art_id <> - 1
      THEN CAST(TS.art_id AS STRING)
      WHEN TS.art_gruppe_id <> '-1'
      THEN CAST(TS.art_gruppe_id AS STRING)
      WHEN TS.wg_id <> - 1
      THEN CAST(TS.wg_id AS STRING)
      ELSE '0'
      END = CASE
      WHEN TS.art_id <> - 1
      THEN CAST(F.art_id AS STRING)
      WHEN TS.art_gruppe_id <> '-1'
      THEN COALESCE(CAST(AGF.art_gruppe_id AS STRING), '-1')
      WHEN TS.wg_id <> - 1
      THEN CAST(WG.wg_id AS STRING)
      ELSE '0'
      END AND TS.sa_af_fg = CASE
     WHEN TS.sa_af_fg = - 1
     THEN CAST(- 1 AS BIGNUMERIC)
     ELSE F.sa_af_fg
     END AND TS.wup_id_vz = CASE
    WHEN TS.wup_id_vz = - 1
    THEN CAST(- 1 AS BIGNUMERIC)
    ELSE F.wup_id
    END
 LEFT JOIN kfl_production_dbp_msi_view_scm.mv_dt_ts_scm_art_cluster_zu AS AC ON F.mandant_id = AC.mandant_id AND F.art_id
      = AC.art_id AND TS.art_cluster_id = AC.art_cluster_id AND TS.art_cluster_id > 0
 LEFT JOIN kfl_production_dbp_msi_view_scm.mv_dt_ts_scm_wup_cluster_zu AS WC ON F.mandant_id = WC.mandant_id AND W.wup_id
      = WC.wup_id AND TS.wup_cluster_id = WC.wup_cluster_id AND TS.wup_cluster_id > 0
WHERE TS.dif_status_id IN (0, 1)
 AND F.mandant_id = 1
 AND COALESCE(WE.offen, 1) = 1
 AND CASE
   WHEN TS.wup_cluster_id > 0
   THEN WC.wup_cluster_id
   ELSE TS.wup_cluster_id
   END = TS.wup_cluster_id
 AND CASE
   WHEN TS.art_cluster_id > 0
   THEN AC.art_cluster_id
   ELSE TS.art_cluster_id
   END = TS.art_cluster_id
GROUP BY F.mandant_id,
 F.kunde_id,
 F.art_id,
 WG.wg_id,
 F.dat;