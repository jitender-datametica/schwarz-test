CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_techn_platz_2 (mandant_id, nb_id, wup_id, techn_platz_id,
land_id, marktyp_kategorie_id, ginfo_markt_typ, ginfo_markt_typ_bez, ginfo_konz_typ_kz, ginfo_konz_typ_bez,
ginfo_bauform_id, ginfo_bauform_bez, baujahr, uebernahme_von, tankstelle_vorh_fg, anz_kassen, anz_kassen_getraenkemarkt
, anz_zusatzkassen, kassen_hardware, kassen_software, kassentisch_situation, einkaufswagen_fabrikat, einkaufswagen_typ,
einkaufswagen_griff, einkaufswagen_rollen, kbl_nl_bez, tp_betreuer_kbl_name, tp_arbeitsrecht_name, anz_parkpl_old,
parkdeck_fg, anz_parkpl, anz_parkpl_behind, anz_parkpl_eltern_kind, parkpl_eben_kz, parkpl_dach_kz, parkpl_dach_mg_kz,
parkhaus_kz, tiefgarage_eg_kz, tiefgarage_mg_kz, sbw_flaeche, vk_flaeche, konz_flaeche, allg_flaeche, neben_flaeche,
betrieb_flaeche, aussen_flaeche, objekt_flaeche, anz_frische_bedien_bereiche, anz_tische_obst_gemuese, anz_achsen_food,
anz_achsen_nonfood, getraenkemarkt_fg, nachtanlief_fg, baecker_kz, baecker_bez, fl_sbw, fl_vkf_kasse, fl_vkf_info,
fl_vkf_roll, fl_vkf_getraenke, fl_vkf_sbw, fl_kof, fl_kofe, fl_snf, fl_tf, fl_vf, fl_anf, fl_ubf, fl_bbf) AS SELECT wp.mandant_id
 ,
 wp.nb_id,
 wp.wup_id,
 tpl.techn_platz_id,
 tpl.land_id,
      CASE
      WHEN tpl2.ginfo_markt_typ <> ''
      THEN tpl2.ginfo_markt_typ
      ELSE '-'
      END || '/' || CASE
     WHEN tpl2.ginfo_konz_typ_kz = 'F'
     THEN tpl2.ginfo_konz_typ_kz
     ELSE '-'
     END || '/' || CASE
   WHEN tpl2.ginfo_bauform_id > - 1
   THEN TRIM(SUBSTR(CAST(tpl2.ginfo_bauform_id AS STRING), 1, 39))
   ELSE '-'
   END AS marktyp_kategorie_id,
 tpl2.ginfo_markt_typ,
 tpl2.ginfo_markt_typ_bez,
 tpl2.ginfo_konz_typ_kz,
 tpl2.ginfo_konz_typ_bez,
 tpl2.ginfo_bauform_id,
 tpl2.ginfo_bauform_bez,
 tpl2.baujahr,
 COALESCE(tpl2.uebernahme_von, '') AS uebernahme_von,
 COALESCE(tpl2.tankstelle_vorh_fg, 0) AS tankstelle_vorh_fg,
 tpl2.anz_kassen,
 tpl2.anz_kassen_getraenkemarkt,
 tpl2.anz_zusatzkassen,
 tpl2.kassen_hardware,
 tpl2.kassen_software,
 tpl2.kassentisch_situation,
 tpl2.einkaufswagen_fabrikat,
 tpl2.einkaufswagen_typ,
 tpl2.einkaufswagen_griff,
 tpl2.einkaufswagen_rollen,
 tpl2.kbl_nl_bez,
 tpl2.tp_betreuer_kbl_name,
 tpl2.tp_arbeitsrecht_name,
 IFNULL(ginf.anz_ppl, 0) AS anz_parkpl_old,
 COALESCE(tpl2.parkdeck_fg, - 1) AS parkdeck_fg,
 COALESCE(tpl2.anz_parkpl, ginf.anz_ppl, 0) AS anz_parkpl,
 COALESCE(tpl2.anz_parkpl_behind, - 1) AS anz_parkpl_behind,
 COALESCE(tpl2.anz_parkpl_eltern_kind, - 1) AS anz_parkpl_eltern_kind,
 COALESCE(tpl2.parkpl_eben_kz, - 1) AS parkpl_eben_kz,
 COALESCE(tpl2.parkpl_dach_kz, - 1) AS parkpl_dach_kz,
 COALESCE(tpl2.parkpl_dach_mg_kz, - 1) AS parkpl_dach_mg_kz,
 COALESCE(tpl2.parkhaus_kz, - 1) AS parkhaus_kz,
 COALESCE(tpl2.tiefgarage_eg_kz, - 1) AS tiefgarage_eg_kz,
 COALESCE(tpl2.tiefgarage_mg_kz, - 1) AS tiefgarage_mg_kz,
 ginf.fl_sbw AS sbw_flaeche,
     ginf.fl_vkf_kasse + ginf.fl_vkf_info + ginf.fl_vkf_roll + ginf.fl_vkf_getraenke + ginf.fl_vkf_sbw AS vk_flaeche,
  ginf.fl_kof + ginf.fl_kofe AS konz_flaeche,
 ginf.fl_vf AS allg_flaeche,
  ginf.fl_snf + ginf.fl_tf AS neben_flaeche,
        ginf.fl_vkf_kasse + ginf.fl_vkf_info + ginf.fl_vkf_roll + ginf.fl_vkf_getraenke + ginf.fl_vkf_sbw + (ginf.fl_kof
       + ginf.fl_kofe) + ginf.fl_vf + (ginf.fl_snf + ginf.fl_tf) AS betrieb_flaeche,
   ginf.fl_anf + ginf.fl_ubf + ginf.fl_bbf AS aussen_flaeche,
         ginf.fl_vkf_kasse + ginf.fl_vkf_info + ginf.fl_vkf_roll + ginf.fl_vkf_getraenke + ginf.fl_vkf_sbw + (ginf.fl_kof
        + ginf.fl_kofe) + ginf.fl_vf + (ginf.fl_snf + ginf.fl_tf) + (ginf.fl_anf + ginf.fl_ubf + ginf.fl_bbf) AS
 objekt_flaeche,
     ginf.achs_01 + ginf.achs_02 + ginf.achs_03 + ginf.achs_04 + ginf.achs_05 AS anz_frische_bedien_bereiche,
 ginf.achs_04 AS anz_tische_obst_gemuese,
 ginf.achs_06 AS anz_achsen_food,
 ginf.achs_07 AS anz_achsen_nonfood,
 COALESCE(ginf.fg_getraenke, - 1) AS getraenkemarkt_fg,
 COALESCE(ginf.fg_nacht, - 1) AS nachtanlief_fg,
 COALESCE(ginf.kz_baecker, 0) AS baecker_kz,
  CASE
  WHEN COALESCE(ginf.kz_baecker, 0) = 1
  THEN 'Discountbäckerei'
  WHEN COALESCE(ginf.kz_baecker, 0) = 2
  THEN 'Frischebäcker'
  WHEN COALESCE(ginf.kz_baecker, 0) = 3
  THEN 'Backshop Typ 3'
  WHEN COALESCE(ginf.kz_baecker, 0) = 4
  THEN 'Frischebäcker Bedienung'
  WHEN COALESCE(ginf.kz_baecker, 0) = 0
  THEN '-'
  ELSE ''
  END AS baecker_bez,
 ginf.fl_sbw,
 ginf.fl_vkf_kasse,
 ginf.fl_vkf_info,
 ginf.fl_vkf_roll,
 ginf.fl_vkf_getraenke,
 ginf.fl_vkf_sbw,
 ginf.fl_kof,
 ginf.fl_kofe,
 ginf.fl_snf,
 ginf.fl_tf,
 ginf.fl_vf,
 ginf.fl_anf,
 ginf.fl_ubf,
 ginf.fl_bbf
FROM (SELECT mandant_id,
   nb_id,
   wup_id
  FROM kfl_production_dbp_view.v_wup_2
  WHERE nb_id IN (0)
   AND dat_von > DATE '1900-01-01'
   AND dat_eroeffnung > DATE '1900-01-01'
   AND umzugsfiliale_fg = 0
   AND wup_id = aktuell_wup_id) AS wp
 LEFT JOIN (SELECT mandant_id,
   techn_platz_id,
   wup_id,
   land_id
  FROM kfl_production_dbp_view.v_techn_platz_per_2
  WHERE techn_platz_ebene_id = 2
   AND dat_bis = DATE '9999-12-31') AS tpl ON wp.mandant_id = tpl.mandant_id AND wp.wup_id = tpl.wup_id
 LEFT JOIN (SELECT mandant_id,
   techn_platz_id,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id LIKE 'VKF-A%'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_sbw,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id = '02.01'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_kasse,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id = '02.10'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_info,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id = '02.08'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_roll,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id = '02.18'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_getraenke,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id = '02.02'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vkf_sbw,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_kof,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_kofe,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_snf,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_tf,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_vf,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_anf,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('KOF')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_ubf,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('BBF') AND ginfo_flaeche_id NOT IN ('PPL', 'PPE', 'PPB')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS fl_bbf,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('BBF') AND ginfo_flaeche_id = 'PPL'
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS anz_ppl,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id IN ('BBF') AND ginfo_flaeche_id IN ('PPE', 'PPB')
     THEN ginfo_flaeche_brutto
     ELSE 0
     END) AS anz_ppx,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A01'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_01,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A02'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_02,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A03'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_03,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A04'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_04,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A05'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_05,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A06'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_06,
   SUM(CASE
     WHEN ginfo_flaeche_typ_id = 'VKF-A07'
     THEN ginfo_achse_wert
     ELSE 0
     END) AS achs_07,
   MAX(CASE
     WHEN ginfo_flaeche_typ_id IN ('VKF') AND ginfo_flaeche_id = '02.18' AND ginfo_flaeche_brutto > 0
     THEN 1
     ELSE 0
     END) AS fg_getraenke,
   MAX(CASE
     WHEN ginfo_flaeche_typ_id IN ('SNF') AND ginfo_flaeche_id = '04.04' AND ginfo_flaeche_brutto > 0
     THEN 1
     ELSE 0
     END) AS fg_nacht,
   MAX(CASE
     WHEN ginfo_flaeche_id = 'ABF-F2.01' AND ginfo_flaeche_brutto > 0
     THEN 1
     WHEN ginfo_flaeche_id = 'ABF-F2.02' AND ginfo_flaeche_brutto > 0
     THEN 2
     WHEN ginfo_flaeche_id = 'ABF-F2.10' AND ginfo_flaeche_brutto > 0
     THEN 3
     WHEN ginfo_flaeche_id IN ('ABF-F2.06', 'ABF-F2.07') AND ginfo_flaeche_brutto > 0
     THEN 4
     ELSE 0
     END) AS kz_baecker
  FROM kfl_production_dbp_view.v_ginfo_flaeche_per_2 AS S01
  WHERE dat_bis = DATE '9999-12-31'
  GROUP BY mandant_id,
   techn_platz_id) AS ginf ON tpl.techn_platz_id = ginf.techn_platz_id
 LEFT JOIN (SELECT S010.mandant_id,
   S010.techn_platz_id,
   S010.baujahr,
   S010.uebernahme_von,
   S010.ginfo_markt_typ,
   S02.ginfo_markt_typ_bez,
   S010.ginfo_konz_typ_kz,
   S03.ginfo_konz_typ_bez,
   S010.ginfo_bauform_id,
   S04.ginfo_bauform_bez,
    CASE
    WHEN S010.ginfo_bauform_id = 2
    THEN 1
    ELSE 0
    END AS parkdeck_fg,
   S010.tankstelle_vorh_fg,
   S010.anz_kassen,
   S010.anz_kassen_getraenkemarkt,
   S010.anz_zusatzkassen,
   S010.kassen_hardware,
   S010.kassen_software,
   S010.kassentisch_situation,
   S010.einkaufswagen_fabrikat,
   S010.einkaufswagen_typ,
   S010.einkaufswagen_griff,
   S010.einkaufswagen_rollen,
   S010.kbl_nl_bez,
   S010.tp_betreuer_kbl_name,
   S010.tp_arbeitsrecht_name,
   S010.anz_parkpl,
   S010.anz_parkpl_behind,
   S010.anz_parkpl_eltern_kind,
   S010.parkpl_eben_kz,
   S010.parkpl_dach_kz,
   S010.parkpl_dach_mg_kz,
   S010.parkhaus_kz,
   S010.tiefgarage_eg_kz,
   S010.tiefgarage_mg_kz
  FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per_2 AS S010
   LEFT JOIN kfl_production_dbp_view.v_l_ginfo_markt_typ_2 AS S02 ON S010.ginfo_markt_typ = S02.ginfo_markt_typ
   LEFT JOIN kfl_production_dbp_view.v_l_ginfo_konz_typ_2 AS S03 ON S010.ginfo_konz_typ_kz = S03.ginfo_konz_typ_kz
   LEFT JOIN kfl_production_dbp_view.v_ginfo_bauform_spr_zu_2 AS S04 ON S010.ginfo_bauform_id = S04.ginfo_bauform_id AND
     S04.spr_id = 22
  WHERE S010.dat_bis = DATE '9999-12-31') AS tpl2 ON tpl.techn_platz_id = tpl2.techn_platz_id;