CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TECHN_PLATZ_EBENE_2 AS
SELECT

--20241204 alavih: Filialumgliederung Anpassung
   tp2.mandant_id,
   tp.land_id,
   tp2.techn_platz_id, 
   COALESCE(w.aktuell_wup_id,tp.wup_id) AS wup_id,
   COALESCE(w.nb_id, 0) AS nb_id,
   COALESCE(w.breitengrad, 0) AS breitengrad,
   COALESCE(w.laengengrad, 0) AS laengengrad,
   COALESCE(vs.vs_id, 0) AS vs_id,
   COALESCE(vs.vs_bez, vs_dummy.vs_bez) AS vsvt_bez,
   COALESCE(w.vw_id, 0) AS vw_id,
   COALESCE(vw.vw_bez, '') AS vw_bez,
   COALESCE(w.vf_id, 0) AS vf_id,
   COALESCE(vf.vf_name, '') AS vf_name,
   w.wup_standort,
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
   tp2.baujahr,
   tp2.eigentum_bez,
   tp2.tankstelle_typ,
   tp2.tankstelle_vorh_fg,
   tp2.bwz_gesamt,
   LEFT(tp2.ginfo_markt_typ,2) AS markt_typ,
   tp2.ginfo_bauform_id AS ginfo_bauform_id,
   tp2.ginfo_konz_typ_kz,
   1 AS techn_platz_quelle_id,
   w.dat_eroeffnung AS wup_dat_eroeffnung,
   w.dat_bis AS wup_dat_schliessung,
   (
      (
         TRIM(ma_spr_zu_gl.ma_anrede) || ' ' || TRIM(ma_spr_zu_gl.ma_vorname) || ' ' || TRIM(ma_spr_zu_gl.ma_name)
      )
   ) AS tp_gl_bez,
   (
      (
         TRIM(ma_spr_zu_gf.ma_anrede) || ' ' || TRIM(ma_spr_zu_gf.ma_vorname) || ' ' || TRIM(ma_spr_zu_gf.ma_name)
      )
   ) AS tp_vl_name,
   (
      (
         TRIM(ma_spr_zu_vkl.ma_anrede) || ' ' || TRIM(ma_spr_zu_vkl.ma_vorname) || ' ' || TRIM(ma_spr_zu_vkl.ma_name)
      )
   ) AS tp_vkl_name,
   COALESCE(tp2.tp_hl_name, '') AS tp_hl_name,
   COALESCE(tp2.tp_fm_name, '') AS tp_fm_name,
   COALESCE(tp2.tp_kas_name, '') AS tp_kas_name,
   COALESCE(tp2.tp_bl_kbl_name, '') AS tp_bl_kbl_name,
   COALESCE(tp2.tp_betreuer_kbl_vertr_name, '') AS tp_betreuer_kbl_vertr_name,
   tp2.tp_ol_vermietung,
   COALESCE(tp2.tp_betreuer_kbl_name, '') AS tp_betreuer_kbl_name,
   tp2.tp_betreuer_handy_nr,
   tp2.tp_betreuer_hls_name,
   tp2.tp_betreuer_elektro_name,
   '' AS parkplatz_reinig_zust,
   '' AS winterdienst_zust,
   '' AS gruenfl_pflege_zust,
   tp2.anz_zusatzkassen,
   tp2.kassen_hardware,
   tp2.kassen_software,
   tp2.kassentisch_situation,
   tp2.einkaufswagen_fabrikat,
   tp2.einkaufswagen_typ,
   tp2.einkaufswagen_griff,
   tp2.einkaufswagen_rollen,
   tp2.einkaufswagen_bemerkung,
   tp2.anz_warentr_164_tabak,
   tp2.anz_warentr_164_standard,
   tp2.anz_warentr_164_suessw_frei,
   tp2.anz_warentr_164_sonstige,
   tp2.anz_nkz_164_food,
   tp2.anz_nkz_164_nonfood,
   tp2.anz_nkz_164_suessw_frei,
   tp2.anz_nkz_164_sonstige,
   tp2.anz_warentr_126_tabak,
   tp2.anz_warentr_126_standard,
   tp2.anz_warentr_126_suessw_frei,
   tp2.anz_warentr_126_sonst,
   tp2.anz_nkz_126_food,
   tp2.anz_nkz_126_nonfood,
   tp2.anz_nkz_126_suessw_frei,
   tp2.anz_nkz_126_sonst,
   tp2.bemerkung_warentraeger,
   tp2.anz_kassen,
   tp2.anz_kassen_getraenkemarkt,
   COALESCE(tp2.kbl_nl_bez, '') AS kbl_nl_bez,
   tp2.uebernahme_von,
   tp2.regalierung,
   (
      (
         TRIM(tp.land_id) || ' / NL  ' || TRIM(tp2.kbl_nl_bez)
      )
   ) AS land_nl
FROM
   dbp_view.v_techn_platz_ebene_2_per tp2
   LEFT OUTER JOIN (
      SELECT
         COALESCE (imb.techn_platz_id, emt.techn_platz_id) AS rpm_techn_platz_id,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_BEDINS' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bedien_insel,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_BEDINS' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bedien_insel_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_BOCKW' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_bockw,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_BOCKW' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_bockw_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_BULK' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_bulk_food,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_BULK' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_bulk_food_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' THEN a.bedienkonzept_auspr_bez
            END
         ) AS discount_backshop,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_DISCOUNT' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS discount_backshop_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FEINK' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_feinkost,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FEINK' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_feinkost_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FISCH' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_fisch,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FISCH' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_fisch_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_fleisch,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FLEISCH' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_fleisch_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' THEN a.bedienkonzept_auspr_bez
            END
         ) AS frische_baecker,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_FRISCHB' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS frische_baecker_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_GEFL' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_gefluegel,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_GEFL' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_gefluegel_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_IMBISS' THEN a.bedienkonzept_auspr_bez
            END
         ) AS imbiss,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_IMBISS' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS imbiss_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_KAESE' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_kaese,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_KAESE' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_kaese_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_leergut,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_LEERGUT' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_leergut_dat,
         MIN(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_WURST' THEN a.bedienkonzept_auspr_bez
            END
         ) AS bed_konzept_wurst,
         MAX(
            CASE
               WHEN bedienkonzept_bez = 'ZPPM_WURST' THEN COALESCE(emt_dat_bedienkonzept, imb_dat_bedienkonzept)
               ELSE NULL
            END
         ) AS bed_konzept_wurst_dat
      FROM
         (
            SELECT
               techn_platz_id,
               dat_bedienkonzept AS imb_dat_bedienkonzept,
               bedienkonzept_id AS imb_bedienkonzept_id,
               bedienkonzept_auspr_id AS imb_bedienkonzept_auspr_id
            FROM
               dbp_view.v_rpm_immobilie_per i
               INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per b ON i.rpm_hierarchie_id = b.rpm_hierarchie_id --IMMOBILIE
            WHERE
               b.rpm_tab_id = 2
               AND b.dat_bis = '9999-12-31'
               AND i.dat_bis = '9999-12-31'
               AND dat_bedienkonzept < CURRENT_DATE
         ) AS imb FULL
         OUTER JOIN (
            SELECT
               DISTINCT techn_platz_id,
               dat_bedienkonzept AS emt_dat_bedienkonzept,
               bedienkonzept_id AS emt_bedienkonzept_id,
               bedienkonzept_auspr_id AS emt_bedienkonzept_auspr_id
            FROM
               dbp_view.v_rpm_immobilie_per ri
               INNER JOIN dbp_view.v_rpm_element_per i ON ri.rpm_hierarchie_id = i.rpm_immobilie_id
               AND i.rpm_status_id NOT IN (1, 4, 5, 6)
               INNER JOIN dbp_view.v_rpm_phase_spr_zu rp ON rp.rpm_phase_id = i.rpm_phase_id
               AND rp.rpm_projekt_typ_id = i.rpm_projekt_typ_id
               AND rp.spr_id = 22
               AND rp.rpm_phase_bez NOT IN ('Abgeschlossen', 'Nachbetrachtung')
               INNER JOIN dbp_view.v_rpm_hier_bed_konzept_zu_per b ON i.rpm_hierarchie_id = b.rpm_hierarchie_id -- ELEMENT
            WHERE
               b.rpm_tab_id = 1
               AND b.dat_bis = '9999-12-31'
               AND i.dat_bis = '9999-12-31'
               AND (
                  dat_bedienkonzept >= CURRENT_DATE
                  OR dat_bedienkonzept = CAST('1900-01-01' AS DATE)
               )
               AND ri.dat_bis = '9999-12-31'
         ) AS emt ON emt.techn_platz_id = imb.techn_platz_id
         AND emt.emt_bedienkonzept_id = imb.imb_bedienkonzept_id
         INNER JOIN dbp_view.v_l_bedienkonzept l ON COALESCE(emt_bedienkonzept_id, imb_bedienkonzept_id) = l.bedienkonzept_id
         INNER JOIN dbp_view.v_bedienkonzept_auspr_spr_zu a ON COALESCE(emt_bedienkonzept_id, imb_bedienkonzept_id) = a.bedienkonzept_id
         AND COALESCE(
            emt_bedienkonzept_auspr_id,
            imb_bedienkonzept_auspr_id
         ) = a.bedienkonzept_auspr_id
         AND a.spr_id = 22
      GROUP BY
         rpm_techn_platz_id
   ) tp3 ON tp2.techn_platz_id = tp3.rpm_techn_platz_id
   INNER JOIN dbp_view.v_techn_platz_per tp ON tp.techn_platz_id = tp2.techn_platz_id
   AND tp.techn_platz_ebene_id = 2
   AND tp.dat_bis = '9999-12-31'
   LEFT OUTER JOIN dbp_view.v_wup w ON COALESCE(tp.wup_id, 0) = w.wup_id
   AND tp.mandant_id = w.mandant_id
   AND tp.nb_id = w.nb_id
   AND tp.wup_id > 0
   LEFT OUTER JOIN dbp_view.v_vs vs ON w.vs_id = vs.vs_id
   AND w.mandant_id = vs.mandant_id
   LEFT OUTER JOIN dbp_view.v_vs vs_dummy ON tp2.mandant_id = vs_dummy.mandant_id
   AND vs_dummy.vs_id = 0
   LEFT OUTER JOIN dbp_view.v_l_vw vw ON w.vw_id = vw.vw_id
   AND w.mandant_id = vw.mandant_id
   LEFT OUTER JOIN dbp_view.v_vf vf ON w.vf_id = vf.vf_id
   AND w.mandant_id = vf.mandant_id
   LEFT OUTER JOIN dbp_msi_v_view.v_wup_denorm wup_denorm ON tp.wup_id = wup_denorm.wup_id
   AND tp2.mandant_id = wup_denorm.mandant_id
   LEFT OUTER JOIN dbp_view.v_vkl vkl ON vkl.vkl_id = wup_denorm.vkl_id
   AND vkl.mandant_id = wup_denorm.mandant_id
   LEFT OUTER JOIN dbp_view.v_ma_spr_zu ma_spr_zu_vkl ON vkl.vkl_id = ma_spr_zu_vkl.ma_id
   AND vkl.mandant_id = ma_spr_zu_vkl.mandant_id
   AND ma_spr_zu_vkl.spr_id = 22
   LEFT OUTER JOIN dbp_msi_view_ios.mv_gl gl ON gl.gl_vertrieb_id = wup_denorm.gl_vertrieb_id
   AND gl.mandant_id = wup_denorm.mandant_id
   LEFT OUTER JOIN dbp_view.v_ma_spr_zu ma_spr_zu_gl ON gl.gl_vertrieb_id = ma_spr_zu_gl.ma_id
   AND gl.mandant_id = ma_spr_zu_gl.mandant_id
   AND ma_spr_zu_gl.spr_id = 22
   LEFT OUTER JOIN dbp_view.v_gf gf ON gf.gf_id = wup_denorm.gf_gbl_vertrieb_id
   AND gf.mandant_id = wup_denorm.mandant_id
   LEFT OUTER JOIN dbp_view.v_ma_spr_zu ma_spr_zu_gf ON gf.gf_id = ma_spr_zu_gf.ma_id
   AND gf.mandant_id = ma_spr_zu_gf.mandant_id
   AND ma_spr_zu_gf.spr_id = 22
WHERE
   tp2.dat_bis = '9999-12-31'
UNION
SELECT
   pr.mandant_id,
   pr.land_id,
   pr.techn_platz_id,
   COALESCE(wup.aktuell_wup_id,pr.wup_id) AS wup_id,
   0 nb_id,
   0 AS breitengrad,
   0 AS laengengrad,
   COALESCE(vs.vs_id, 0) AS vs_id,
   COALESCE(vs.vs_bez, vs_dummy.vs_bez) AS vsvt_bez,
   COALESCE(vw.vw_id, 0) vw_id,
   COALESCE(vw.vw_bez, 'n.N. ' || pr.land_id) vw_bez,
   COALESCE(vf.vf_id, 0) vf_id,
   COALESCE(vf.vf_name, 'n.N. ' || pr.land_id) vf_name,
   CASE
      WHEN COALESCE(wup.aktuell_wup_id,pr.wup_id) IS NOT NULL THEN pr_s.projekt_kbez
      ELSE NULL
   END wup_standort,
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
   NULL AS bed_konzept_fleisch_dat,
   NULL AS bed_konzept_wurst_dat,
   NULL AS bed_konzept_kaese_dat,
   NULL AS bed_konzept_fisch_dat,
   NULL AS frische_baecker_dat,
   NULL AS discount_backshop_dat,
   NULL AS bed_konzept_leergut_dat,
   NULL AS bed_konzept_bulk_food_dat,
   NULL AS bedien_insel_dat,
   NULL AS imbiss_dat,
   NULL AS bed_konzept_gefluegel_dat,
   NULL AS bed_konzept_feinkost_dat,
   NULL AS bed_konzept_bockw_dat,
   NULL AS baujahr,
   '' AS eigentum_bez,
   '' AS tankstelle_typ,
   NULL AS tankstelle_vorh_fg,
   NULL AS bwz_gesamt,
   LEFT(COALESCE (pr.markt_typ_vp, pr.markt_typ_ea),2) AS markt_typ,
   CAST(NULL AS BYTEINT) AS ginfo_bauform_id,
   CAST(NULL AS CHAR(1)) AS ginfo_konz_typ_kz,
   2 AS techn_platz_quelle_id,
   CAST(NULL AS DATE) AS dat_eroeffnung,
   CAST(NULL AS DATE) AS dat_schliessung,
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
   NULL AS anz_zusatzkassen,
   '' kassen_hardware,
   '' kassen_software,
   '' kassentisch_situation,
   '' einkaufswagen_fabrikat,
   '' einkaufswagen_typ,
   '' einkaufswagen_griff,
   '' einkaufswagen_rollen,
   '' einkaufswagen_bemerkung,
   NULL AS anz_warentr_164_tabak,
   NULL AS anz_warentr_164_standard,
   NULL AS anz_warentr_164_suessw_frei,
   NULL AS anz_warentr_164_sonstige,
   NULL AS anz_nkz_164_food,
   NULL AS anz_nkz_164_nonfood,
   NULL AS anz_nkz_164_suessw_frei,
   NULL AS anz_nkz_164_sonstige,
   NULL AS anz_warentr_126_tabak,
   NULL AS anz_warentr_126_standard,
   NULL AS anz_warentr_126_suessw_frei,
   NULL AS anz_warentr_126_sonst,
   NULL AS anz_nkz_126_food,
   NULL AS anz_nkz_126_nonfood,
   NULL AS anz_nkz_126_suessw_frei,
   NULL AS anz_nkz_126_sonst,
   '' bemerkung_warentraeger,
   NULL AS anz_kassen,
   NULL AS anz_kassen_getraenkemarkt,
   '' AS kbl_nl_bez,
   '' AS ubernahme_von,
   ' ' AS regalierung,
   ((TRIM(pr.land_id) || ' / NL   ')) AS land_nl
FROM
   dbp_view.v_cpr_projekt_per pr
   LEFT OUTER JOIN dbp_msi_view_ios.mv_cpr_projekt_spr_zu pr_s ON pr.projekt_id = pr_s.projekt_id
   LEFT OUTER JOIN dbp_view.v_vs vs ON pr.cpr_vs = vs.vs_bez
   AND pr.mandant_id = vs.mandant_id
   LEFT OUTER JOIN dbp_view.v_vs vs_dummy ON pr.mandant_id = vs_dummy.mandant_id
   AND vs_dummy.vs_id = 0
   LEFT OUTER JOIN dbp_view.v_l_vw vw ON COALESCE(pr.cpr_vw, 'n.N. ' || pr.land_id) = vw.vw_bez
   AND pr.mandant_id = vw.mandant_id
   LEFT OUTER JOIN dbp_view.v_vf vf ON CASE
      WHEN pr.cpr_filialtyp_bez = 'KL' THEN 'Kaufland'
      ELSE 'n.N. ' || pr.land_id
   END = vf.vf_name
   AND pr.mandant_id = vf.mandant_id
   LEFT OUTER JOIN
   dbp_view.v_wup wup ON
   pr.wup_id = wup.wup_id AND 
   pr.mandant_id = wup.mandant_id
WHERE
   pr.dat_bis = '9999-12-31'
   AND pr.techn_platz_id NOT IN (
      SELECT
         tp0.techn_platz_id AS techn_platz_id
      FROM
         dbp_view.v_techn_platz_ebene_2_per tp0
      WHERE
         tp0.dat_bis = '9999-12-31'
   )
   AND (techn_platz_id, cpr_ext_id) IN (
      SELECT
         pr1.techn_platz_id AS techn_platz_id,
         MAX(pr1.cpr_ext_id) AS cpr_ext_id
      FROM
         dbp_view.v_cpr_projekt_per pr1
      WHERE
         pr1.cpr_standort IS NOT NULL
         AND pr1.dat_bis = '9999-12-31'
      GROUP BY
         techn_platz_id
   );