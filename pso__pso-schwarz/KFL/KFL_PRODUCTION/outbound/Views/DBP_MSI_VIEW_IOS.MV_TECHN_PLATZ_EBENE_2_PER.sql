--20241210 alavih: Filialumgliederung


CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_techn_platz_ebene_2_per AS SELECT TP2.mandant_id,
 TP.land_id,
 TP2.techn_platz_id,
 W.aktuell_wup_id AS wup_id,
 W.nb_id,
 COALESCE(W.breitengrad, 0) AS breitengrad,
 COALESCE(W.laengengrad, 0) AS laengengrad,
 COALESCE(VS.vs_id, 0) AS vs_id,
 COALESCE(VS.vsvt_bez, VS_DUMMY.vsvt_bez) AS vsvt_bez,
 COALESCE(W.vw_id, 0) AS vw_id,
 COALESCE(VW.vw_bez, '') AS vw_bez,
 COALESCE(W.vf_id, 0) AS vf_id,
 COALESCE(VF.vf_name, '') AS vf_name,
 W.wup_standort,
 tp3.bed_konzept_fleisch,
 tp3.bed_konzept_wurst,
 tp3.bed_konzept_kaese,
 tp3.bed_konzept_fisch,
 tp3.frische_baecker,
 tp3.discount_backshop,
 tp3.bed_konzept_leergut,
 tp3.bed_konzept_bulk_food,
 tp3.bedien_insel,
 tp3.imbiss,
 tp3.bed_konzept_gefluegel,
 tp3.bed_konzept_feinkost,
 tp3.bed_konzept_bockw,
 tp3.bed_konzept_fleisch_dat,
 tp3.bed_konzept_wurst_dat,
 tp3.bed_konzept_kaese_dat,
 tp3.bed_konzept_fisch_dat,
 tp3.frische_baecker_dat,
 tp3.discount_backshop_dat,
 tp3.bed_konzept_leergut_dat,
 tp3.bed_konzept_bulk_food_dat,
 tp3.bedien_insel_dat,
 tp3.imbiss_dat,
 tp3.bed_konzept_gefluegel_dat,
 tp3.bed_konzept_feinkost_dat,
 tp3.bed_konzept_bockw_dat,
 TP2.baujahr,
 TP2.eigentum_bez,
 TP2.tankstelle_typ,
 TP2.tankstelle_vorh_fg,
 TP2.bwz_gesamt,
 TP2.ginfo_markt_typ AS markt_typ,
 TP2.ginfo_bauform_id,
 TP2.ginfo_konz_typ_kz,
 1 AS techn_platz_quelle_id,
 W.dat_eroeffnung AS wup_dat_eroeffnung,
 W.dat_bis AS wup_dat_schliessung,
 TP2.tp_gl_bez,
 TP2.tp_vl_name,
 TP2.tp_vkl_name,
 TP2.tp_hl_name,
 TP2.tp_fm_name,
 TP2.tp_kas_name,
 COALESCE(TP2.tp_bl_kbl_name, '') AS tp_bl_kbl_name,
 TP2.tp_betreuer_kbl_vertr_name,
 TP2.tp_ol_vermietung,
 TP2.tp_betreuer_kbl_name,
 TP2.tp_betreuer_handy_nr,
 TP2.tp_betreuer_hls_name,
 TP2.tp_betreuer_elektro_name,
 '' AS parkplatz_reinig_zust,
 '' AS winterdienst_zust,
 '' AS gruenfl_pflege_zust,
 TP2.anz_zusatzkassen,
 TP2.kassen_hardware,
 TP2.kassen_software,
 TP2.kassentisch_situation,
 TP2.einkaufswagen_fabrikat,
 TP2.einkaufswagen_typ,
 TP2.einkaufswagen_griff,
 TP2.einkaufswagen_rollen,
 TP2.einkaufswagen_bemerkung,
 TP2.anz_warentr_164_tabak,
 TP2.anz_warentr_164_standard,
 TP2.anz_warentr_164_suessw_frei,
 TP2.anz_warentr_164_sonstige,
 TP2.anz_nkz_164_food,
 TP2.anz_nkz_164_nonfood,
 TP2.anz_nkz_164_suessw_frei,
 TP2.anz_nkz_164_sonstige,
 TP2.anz_warentr_126_tabak,
 TP2.anz_warentr_126_standard,
 TP2.anz_warentr_126_suessw_frei,
 TP2.anz_warentr_126_sonst,
 TP2.anz_nkz_126_food,
 TP2.anz_nkz_126_nonfood,
 TP2.anz_nkz_126_suessw_frei,
 TP2.anz_nkz_126_sonst,
 TP2.bemerkung_warentraeger,
 TP2.anz_kassen,
 TP2.anz_kassen_getraenkemarkt,
 COALESCE(TP2.kbl_nl_bez, '') AS kbl_nl_bez,
 TP2.uebernahme_von,
 T1.dat AS dat_von,
  CASE
  WHEN T1.dat = CURRENT_DATE
  THEN DATE '9999-12-31'
  ELSE T1.dat
  END AS dat_bis,
 TP2.regalierung
FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per AS TP2
 INNER JOIN (SELECT COALESCE(imb.techn_platz_id, emt.techn_platz_id) AS rpm_techn_platz_id,
   COALESCE(imb.dat, emt.dat) AS dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bedien_insel,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_BEDINS'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bedien_insel_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_bockw,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_BOCKW'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_bockw_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_BULK'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_bulk_food,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_BULK'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_bulk_food_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS discount_backshop,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_DISCOUNT'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS discount_backshop_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FEINK'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_feinkost,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FEINK'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_feinkost_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FISCH'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_fisch,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FISCH'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_fisch_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_fleisch,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FLEISCH'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_fleisch_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS frische_baecker,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_FRISCHB'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS frische_baecker_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_GEFL'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_gefluegel,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_GEFL'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_gefluegel_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS imbiss,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_IMBISS'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS imbiss_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_KAESE'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_kaese,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_KAESE'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_kaese_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_leergut,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_LEERGUT'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_leergut_dat,
   MIN(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_WURST'
     THEN A.bedienkonzept_auspr_bez
     ELSE NULL
     END) AS bed_konzept_wurst,
   MAX(CASE
     WHEN L.bedienkonzept_bez = 'ZPPM_WURST'
     THEN COALESCE(emt.emt_dat_bedienkonzept, imb.imb_dat_bedienkonzept)
     ELSE NULL
     END) AS bed_konzept_wurst_dat
  FROM (SELECT I.techn_platz_id,
     B.dat_bedienkonzept AS imb_dat_bedienkonzept,
     B.bedienkonzept_id AS imb_bedienkonzept_id,
     B.bedienkonzept_auspr_id AS imb_bedienkonzept_auspr_id,
     T.dat
    FROM kfl_production_dbp_view.v_rpm_immobilie_per AS I
     INNER JOIN kfl_production_dbp_view.v_tag AS T ON T.dat BETWEEN I.dat_von AND I.dat_bis AND T.dat <= CURRENT_DATE
      AND T.dat >= DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY)
     INNER JOIN kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per AS B ON I.rpm_hierarchie_id = B.rpm_hierarchie_id
    WHERE B.rpm_tab_id = 2
     AND T.dat BETWEEN B.dat_von AND B.dat_bis
     AND B.dat_bedienkonzept < CURRENT_DATE) AS imb
   FULL JOIN (SELECT DISTINCT RI.techn_platz_id,
     B0.dat_bedienkonzept AS emt_dat_bedienkonzept,
     B0.bedienkonzept_id AS emt_bedienkonzept_id,
     B0.bedienkonzept_auspr_id AS emt_bedienkonzept_auspr_id,
     T0.dat
    FROM kfl_production_dbp_view.v_rpm_immobilie_per AS RI
     INNER JOIN kfl_production_dbp_view.v_rpm_element_per AS I0 ON RI.rpm_hierarchie_id = I0.rpm_immobilie_id AND I0.rpm_status_id
        NOT IN (1, 4, 5, 6)
     INNER JOIN kfl_production_dbp_view.v_tag AS T0 ON T0.dat BETWEEN RI.dat_von AND RI.dat_bis AND T0.dat BETWEEN I0.dat_von
         AND I0.dat_bis AND T0.dat <= CURRENT_DATE AND T0.dat >= DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY)
     INNER JOIN kfl_production_dbp_view.v_rpm_phase_spr_zu AS RP ON I0.rpm_phase_id = RP.rpm_phase_id AND I0.rpm_projekt_typ_id
          = RP.rpm_projekt_typ_id AND RP.spr_id = 22 AND RP.rpm_phase_bez NOT IN ('Abgeschlossen', 'Nachbetrachtung')
     INNER JOIN kfl_production_dbp_view.v_rpm_hier_bed_konzept_zu_per AS B0 ON I0.rpm_hierarchie_id = B0.rpm_hierarchie_id
      
    WHERE B0.rpm_tab_id = 1
     AND T0.dat BETWEEN B0.dat_von AND B0.dat_bis
     AND (B0.dat_bedienkonzept >= CURRENT_DATE OR B0.dat_bedienkonzept = DATE('1900-01-01'))) AS emt ON imb.techn_platz_id
       = emt.techn_platz_id AND imb.dat = emt.dat AND imb.imb_bedienkonzept_id = emt.emt_bedienkonzept_id
   INNER JOIN kfl_production_dbp_view.v_l_bedienkonzept AS L ON COALESCE(emt.emt_bedienkonzept_id, imb.imb_bedienkonzept_id
     ) = L.bedienkonzept_id
   INNER JOIN kfl_production_dbp_view.v_bedienkonzept_auspr_spr_zu AS A ON COALESCE(emt.emt_bedienkonzept_id, imb.imb_bedienkonzept_id
       ) = A.bedienkonzept_id AND COALESCE(emt.emt_bedienkonzept_auspr_id, imb.imb_bedienkonzept_auspr_id) = A.bedienkonzept_auspr_id
       AND A.spr_id = 22
  GROUP BY rpm_techn_platz_id,
   dat) AS tp3 ON TP2.techn_platz_id = tp3.rpm_techn_platz_id
 INNER JOIN kfl_production_dbp_view.v_tag AS T1 ON T1.dat BETWEEN TP2.dat_von AND TP2.dat_bis AND T1.dat <= CURRENT_DATE
      AND T1.dat >= DATE_SUB(CURRENT_DATE, INTERVAL 60 DAY) AND tp3.dat = T1.dat
 INNER JOIN kfl_production_dbp_view.v_techn_platz_per AS TP ON TP2.techn_platz_id = TP.techn_platz_id AND TP.techn_platz_ebene_id
     = 2 AND T1.dat BETWEEN TP.dat_von AND TP.dat_bis
 LEFT JOIN kfl_production_dbp_view.v_wup AS W ON TP.wup_id = W.wup_id AND TP.mandant_id = W.mandant_id AND TP.nb_id = W
    .nb_id AND TP.wup_id > 0
 LEFT JOIN kfl_production_dbp_view.v_vs AS VS ON W.vs_id = VS.vs_id AND W.mandant_id = VS.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_vs AS VS_DUMMY ON TP2.mandant_id = VS_DUMMY.mandant_id AND VS_DUMMY.vs_id = 0
 LEFT JOIN kfl_production_dbp_view.v_l_vw AS VW ON W.vs_id = VW.vw_id AND W.mandant_id = VW.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_vf AS VF ON W.vf_id = VF.vf_id AND W.mandant_id = VF.mandant_id
UNION DISTINCT
SELECT PR.mandant_id,
 PR.land_id,
 PR.techn_platz_id,
 WUP2.aktuell_wup_id AS wup_id,
 0 AS nb_id,
 0 AS breitengrad,
 0 AS laengengrad,
 COALESCE(VS.vs_id, 0) AS vs_id,
 COALESCE(VS.vsvt_bez, VS_DUMMY.vsvt_bez) AS vsvt_bez,
 COALESCE(VW.vw_id, 0) AS vw_id,
 COALESCE(VW.vw_bez, 'n.N. ' || PR.land_id) AS vw_bez,
 COALESCE(VF.vf_id, 0) AS vf_id,
 COALESCE(VF.vf_name, 'n.N. ' || PR.land_id) AS vf_name,
  CASE
  WHEN PR.wup_id IS NOT NULL
  THEN PR_S.projekt_kbez
  ELSE NULL
  END AS wup_standort,
 '' AS bed_konzept_fleisch,
 '' AS bed_konzept_wurst,
 '' AS bed_konzept_kaese,
 '' AS bed_konzept_fisch,
 '' AS frische_baecker,
 '' AS discount_backshop,
 '' AS bed_konzept_leergut,
 '' AS bed_konzept_bulk_food,
 '' AS bedien_insel,
 '' AS imbiss,
 '' AS bed_konzept_gefluegel,
 '' AS bed_konzept_feinkost,
 '' AS bed_konzept_bockw,
 CAST(NULL AS DATE) AS bed_konzept_fleisch_dat,
 CAST(NULL AS DATE) AS bed_konzept_wurst_dat,
 CAST(NULL AS DATE) AS bed_konzept_kaese_dat,
 CAST(NULL AS DATE) AS bed_konzept_fisch_dat,
 CAST(NULL AS DATE) AS frische_baecker_dat,
 CAST(NULL AS DATE) AS discount_backshop_dat,
 CAST(NULL AS DATE) AS bed_konzept_leergut_dat,
 CAST(NULL AS DATE) AS bed_konzept_bulk_food_dat,
 CAST(NULL AS DATE) AS bedien_insel_dat,
 CAST(NULL AS DATE) AS imbiss_dat,
 CAST(NULL AS DATE) AS bed_konzept_gefluegel_dat,
 CAST(NULL AS DATE) AS bed_konzept_feinkost_dat,
 CAST(NULL AS DATE) AS bed_konzept_bockw_dat,
 CAST(NULL AS BIGNUMERIC) AS baujahr,
 '' AS eigentum_bez,
 '' AS tankstelle_typ,
 CAST(NULL AS BIGNUMERIC) AS tankstelle_vorh_fg,
 CAST(NULL AS NUMERIC) AS bwz_gesamt,
 COALESCE(PR.markt_typ_vp, PR.markt_typ_ea) AS markt_typ,
 CAST(NULL AS BIGNUMERIC) AS ginfo_bauform_id,
 SUBSTR(NULL, 1, 1) AS ginfo_konz_typ_kz,
 2 AS techn_platz_quelle_id,
 DATE(NULL) AS dat_eroeffnung,
 DATE(NULL) AS dat_schliessung,
 '' AS tp_gl_bez,
 '' AS tp_vl_name,
 '' AS tp_vkl_name,
 '' AS tp_hl_name,
 '' AS tp_fm_name,
 '' AS tp_kas_name,
 '' AS tp_bl_kbl_name,
 '' AS tp_betreuer_kbl_vertr_name,
 '' AS tp_ol_vermietung,
 '' AS tp_betreuer_kbl_name,
 '' AS tp_betreuer_handy_nr,
 '' AS tp_betreuer_hls_name,
 '' AS tp_betreuer_elektro_name,
 '' AS parkplatz_reinig_zust,
 '' AS winterdienst_zust,
 '' AS gruenfl_pflege_zust,
 CAST(NULL AS BIGNUMERIC) AS anz_zusatzkassen,
 '' AS kassen_hardware,
 '' AS kassen_software,
 '' AS kassentisch_situation,
 '' AS einkaufswagen_fabrikat,
 '' AS einkaufswagen_typ,
 '' AS einkaufswagen_griff,
 '' AS einkaufswagen_rollen,
 '' AS einkaufswagen_bemerkung,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_164_tabak,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_164_standard,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_164_suessw_frei,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_164_sonstige,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_164_food,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_164_nonfood,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_164_suessw_frei,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_164_sonstige,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_126_tabak,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_126_standard,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_126_suessw_frei,
 CAST(NULL AS BIGNUMERIC) AS anz_warentr_126_sonst,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_126_food,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_126_nonfood,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_126_suessw_frei,
 CAST(NULL AS BIGNUMERIC) AS anz_nkz_126_sonst,
 '' AS bemerkung_warentraeger,
 CAST(NULL AS BIGNUMERIC) AS anz_kassen,
 CAST(NULL AS BIGNUMERIC) AS anz_kassen_getraenkemarkt,
 '' AS kbl_nl_bez,
 '' AS ubernahme_von,
 T.dat AS dat_von,
  CASE
  WHEN T.dat = CURRENT_DATE
  THEN DATE '9999-12-31'
  ELSE T.dat
  END AS dat_bis,
 ' ' AS regalierung
FROM kfl_production_dbp_view.v_cpr_projekt_per AS PR
 INNER JOIN kfl_production_dbp_view.v_tag AS T ON T.dat BETWEEN PR.dat_von AND PR.dat_bis AND T.dat <= CURRENT_DATE
 LEFT JOIN kfl_production_dbp_msi_view_ios.mv_cpr_projekt_spr_zu AS PR_S ON PR.projekt_id = PR_S.projekt_id
 LEFT JOIN kfl_production_dbp_view.v_vs AS VS ON PR.cpr_vs = VS.vs_bez AND PR.mandant_id = VS.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_vs AS VS_DUMMY ON PR.mandant_id = VS_DUMMY.mandant_id AND VS_DUMMY.vs_id = 0
 LEFT JOIN kfl_production_dbp_view.v_l_vw AS VW ON COALESCE(PR.cpr_vw, 'n.N. ' || PR.land_id) = VW.vw_bez AND PR.mandant_id
    = VW.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_vf AS VF ON CASE
    WHEN PR.cpr_filialtyp_bez = 'KL'
    THEN 'Kaufland'
    ELSE 'n.N. ' || PR.land_id
    END = VF.vf_name AND PR.mandant_id = VF.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_wup AS WUP2 ON PR.wup_id = WUP2.wup_id AND PR.mandant_id = WUP2.mandant_id
WHERE (PR.techn_platz_id, PR.cpr_ext_id) IN (SELECT (PR1.techn_platz_id, MAX(PR1.cpr_ext_id))
   FROM kfl_production_dbp_view.v_cpr_projekt_per AS PR1
    INNER JOIN kfl_production_dbp_view.v_tag AS T10 ON T10.dat BETWEEN PR1.dat_von AND PR1.dat_bis AND T10.dat <=
      CURRENT_DATE
   WHERE PR1.cpr_standort IS NOT NULL
    AND T10.dat BETWEEN PR1.dat_von AND PR1.dat_bis
   GROUP BY PR1.techn_platz_id)
 AND PR.techn_platz_id NOT IN (SELECT techn_platz_id
   FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per AS TP0
   WHERE dat_von <= T.dat);