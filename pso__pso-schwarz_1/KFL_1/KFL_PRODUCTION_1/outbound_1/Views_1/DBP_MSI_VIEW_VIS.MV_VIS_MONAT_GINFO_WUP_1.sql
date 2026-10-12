CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_ginfo_wup_1 (mandant_id, nb_id, wup_id, techn_platz_id
, land_id, kjmo, vk_flaeche, konz_flaeche, betrieb_flaeche, sbw_flaeche, allg_flaeche, neben_flaeche, aussen_flaeche,
objekt_flaeche, anz_parkpl, achs_01, achs_02, achs_03, achs_04, achs_05, achs_06, achs_07, flaech_01, flaech_02,
flaech_03, flaech_04, flaech_05, flaech_06, flaech_07, getraenkemarkt_fg, nachtanlief_fg, baecker_kz, baecker_bez) AS
SELECT v01.mandant_id,
 v01.nb_id,
 v01.wup_id,
 v02.techn_platz_id,
 v02.land_id,
 COALESCE(v03.kjmo, 0) AS kjmo,
 COALESCE(v03.fl_vkf_kasse + v03.fl_vkf_info + v03.fl_vkf_roll + v03.fl_vkf_getraenke + v03.fl_vkf_sbw, 0) AS vk_flaeche
 ,
 COALESCE(v03.fl_kof + v03.fl_kofe, 0) AS konz_flaeche,
 COALESCE(COALESCE(v03.fl_vkf_kasse + v03.fl_vkf_info + v03.fl_vkf_roll + v03.fl_vkf_getraenke + v03.fl_vkf_sbw, 0) +
     COALESCE(v03.fl_kof + v03.fl_kofe, 0) + v03.fl_vf + (v03.fl_snf + v03.fl_tf), 0) AS betrieb_flaeche,
 v03.fl_sbw AS sbw_flaeche,
 v03.fl_vf AS allg_flaeche,
  v03.fl_snf + v03.fl_tf AS neben_flaeche,
   v03.fl_anf + v03.fl_ubf + v03.fl_bbf AS aussen_flaeche,
  COALESCE(COALESCE(v03.fl_vkf_kasse + v03.fl_vkf_info + v03.fl_vkf_roll + v03.fl_vkf_getraenke + v03.fl_vkf_sbw, 0) +
      COALESCE(v03.fl_kof + v03.fl_kofe, 0) + v03.fl_vf + (v03.fl_snf + v03.fl_tf), 0) + (v03.fl_anf + v03.fl_ubf + v03
    .fl_bbf) AS objekt_flaeche,
  v03.anz_ppl + v03.anz_ppx AS anz_parkpl,
 v03.achs_01,
 v03.achs_02,
 v03.achs_03,
 v03.achs_04,
 v03.achs_05,
 v03.achs_06,
 v03.achs_07,
 v03.flaech_01,
 v03.flaech_02,
 v03.flaech_03,
 v03.flaech_04,
 v03.flaech_05,
 v03.flaech_06,
 v03.flaech_07,
 COALESCE(v03.fg_getraenke, - 1) AS getraenkemarkt_fg,
 COALESCE(v03.fg_nacht, - 1) AS nachtanlief_fg,
 COALESCE(v03.kz_baecker, 0) AS baecker_kz,
  CASE
  WHEN COALESCE(v03.kz_baecker, 0) = 1
  THEN 'Discountbäckerei'
  WHEN COALESCE(v03.kz_baecker, 0) = 2
  THEN 'Frischebäcker'
  WHEN COALESCE(v03.kz_baecker, 0) = 3
  THEN 'Backshop Typ 3'
  WHEN COALESCE(v03.kz_baecker, 0) = 4
  THEN 'Frischebäcker Bedienung'
  WHEN COALESCE(v03.kz_baecker, 0) = 0
  THEN '-'
  ELSE ''
  END AS baecker_bez
FROM (SELECT mandant_id,
   nb_id,
   wup_id,
   dat_eroeffnung,
   verkaufsflaeche
  FROM kfl_production_dbp_view.v_wup_1
  WHERE nb_id IN (0)
   AND dat_eroeffnung > DATE '1900-01-01'
   AND wup_id = aktuell_wup_id) AS v01
 LEFT JOIN (SELECT mandant_id,
   techn_platz_id,
   wup_id,
   land_id
  FROM kfl_production_dbp_view.v_techn_platz_per_1
  WHERE techn_platz_ebene_id = 2
   AND dat_bis = DATE '9999-12-31') AS v02 ON v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
 LEFT JOIN (SELECT S01.mandant_id,
   S01.techn_platz_id,
   s02.kjmo,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id LIKE 'VKF-A%'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_sbw,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('VKF') AND S01.ginfo_flaeche_id = '02.01'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_kasse,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('VKF') AND S01.ginfo_flaeche_id = '02.10'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_info,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('VKF') AND S01.ginfo_flaeche_id = '02.08'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_roll,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('VKF') AND S01.ginfo_flaeche_id = '02.18'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_getraenke,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('VKF') AND S01.ginfo_flaeche_id = '02.02'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_sbw,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_kof,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_kofe,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_snf,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_tf,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vf,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_anf,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('KOF')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_ubf,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('BBF') AND S01.ginfo_flaeche_id NOT IN ('PPL', 'PPE', 'PPB')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_bbf,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('BBF') AND S01.ginfo_flaeche_id = 'PPL'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS anz_ppl,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('BBF') AND S01.ginfo_flaeche_id IN ('PPE', 'PPB')
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS anz_ppx,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A01'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_01,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A02'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_02,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A03'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_03,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A04'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_04,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A05'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_05,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A06'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_06,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A07'
     THEN S01.ginfo_achse_wert
     ELSE 0
     END) AS achs_07,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A01'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_01,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A02'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_02,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A03'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_03,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A04'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_04,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A05'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_05,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A06'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_06,
   SUM(CASE
     WHEN S01.ginfo_flaeche_typ_id = 'VKF-A07'
     THEN S01.ginfo_flaeche_brutto
     ELSE 0
     END) AS flaech_07,
   MAX(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('VKF') AND S01.ginfo_flaeche_id = '02.18' AND S01.ginfo_flaeche_brutto > 0
     THEN 1
     ELSE 0
     END) AS fg_getraenke,
   MAX(CASE
     WHEN S01.ginfo_flaeche_typ_id IN ('SNF') AND S01.ginfo_flaeche_id = '04.04' AND S01.ginfo_flaeche_brutto > 0
     THEN 1
     ELSE 0
     END) AS fg_nacht,
   MAX(CASE
     WHEN S01.ginfo_flaeche_id = 'ABF-F2.01' AND S01.ginfo_flaeche_brutto > 0
     THEN 1
     WHEN S01.ginfo_flaeche_id = 'ABF-F2.02' AND S01.ginfo_flaeche_brutto > 0
     THEN 2
     WHEN S01.ginfo_flaeche_id = 'ABF-F2.10' AND S01.ginfo_flaeche_brutto > 0
     THEN 3
     WHEN S01.ginfo_flaeche_id IN ('ABF-F2.06', 'ABF-F2.07') AND S01.ginfo_flaeche_brutto > 0
     THEN 4
     ELSE 0
     END) AS kz_baecker
  FROM kfl_production_dbp_view.v_ginfo_flaeche_per_1 AS S01
   INNER JOIN (SELECT kjmo,
     max_dat
    FROM kfl_production_dbp_view.v_monat_1
    WHERE akt_gj IN (- 3, - 2, - 1, 0)) AS s02 ON s02.max_dat BETWEEN S01.dat_von AND S01.dat_bis
  GROUP BY S01.mandant_id,
   S01.techn_platz_id,
   s02.kjmo) AS v03 ON v02.techn_platz_id = v03.techn_platz_id;