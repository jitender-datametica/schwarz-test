CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_bereich_1 (mandant_id, nb_id, wup_id, wrg_id,
gj, kjmo, akt_mo, mo_kj, akt_mo_shr, fruehinfo2, hr_objekt_bereich_id, ber_kopf_gesamt, ber_flukt_rol_fg,
ber_kopf_flukt_aktmo, ber_kopf_flukt_vormo, ber_kopf_fluktuation, ber_kopf_austritte, ber_kopf_austritt_an,
ber_kopf_austritt_ag, ber_kopf_fluktuation_rol, ber_kopf_austritte_rol, ber_kopf_austritt_an_rol,
ber_kopf_austritt_ag_rol, ber_austritt_trw, ber_austritt_vtg, ber_austritt_ana, ber_austritt_ugsi, ber_austritt_ugsw,
ber_austritt_bu, ber_austritt_trw_rol, ber_austritt_vtg_rol, ber_austritt_ana_rol, ber_austritt_ugsi_rol,
ber_austritt_ugsw_rol, ber_austritt_bu_rol) AS SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.gj,
 vis.kjmo,
 vis.akt_mo,
 vis.mo_kj,
  vis.akt_fruehinfo2 - 1 AS akt_mo_shr,
 vis.akt_fruehinfo2 AS fruehinfo2,
 obj_ber.hr_objekt_bereich_id,
 IFNULL(shr_ist.kopf_aktiv, 0) AS ber_kopf_gesamt,
 vis.flukt_fg AS ber_flukt_rol_fg,
 shr_ist.kopf_flukt_aktmo AS ber_kopf_flukt_aktmo,
 shr_ist.kopf_flukt_vormo AS ber_kopf_flukt_vormo,
   (shr_ist.kopf_flukt_aktmo + shr_ist.kopf_flukt_vormo) / 2 AS ber_kopf_fluktuation,
 shr_ist.austritte AS ber_kopf_austritte,
 shr_ist.austritt_an AS ber_kopf_austritt_an,
 shr_ist.austritt_ag AS ber_kopf_austritt_ag,
  shr_ist.kopf_flukt_rol * vis.flukt_fg AS ber_kopf_fluktuation_rol,
  shr_ist.kopf_aus_rol * vis.flukt_fg AS ber_kopf_austritte_rol,
  shr_ist.kopf_aus_an_rol * vis.flukt_fg AS ber_kopf_austritt_an_rol,
  shr_ist.kopf_aus_ag_rol * vis.flukt_fg AS ber_kopf_austritt_ag_rol,
 shr_ist.austritt_trw AS ber_austritt_trw,
 shr_ist.austritt_vtg AS ber_austritt_vtg,
 shr_ist.austritt_ana AS ber_austritt_ana,
 shr_ist.austritt_ugsi AS ber_austritt_ugsi,
 shr_ist.austritt_ugsw AS ber_austritt_ugsw,
 shr_ist.austritt_bu AS ber_austritt_bu,
  shr_ist.kopf_aus_trw_rol * vis.flukt_fg AS ber_austritt_trw_rol,
  shr_ist.kopf_aus_vtg_rol * vis.flukt_fg AS ber_austritt_vtg_rol,
  shr_ist.kopf_aus_ana_rol * vis.flukt_fg AS ber_austritt_ana_rol,
  shr_ist.kopf_aus_ugsi_rol * vis.flukt_fg AS ber_austritt_ugsi_rol,
  shr_ist.kopf_aus_ugsw_rol * vis.flukt_fg AS ber_austritt_ugsw_rol,
  shr_ist.kopf_aus_bu_rol * vis.flukt_fg AS ber_austritt_bu_rol
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.kjmo,
   ZEIT.akt_mo,
   ZEIT.mo_kj,
   ZEIT.gj,
   BSK.akt_fruehinfo2,
   WUP.dat_eroeffnung AS dat_neo,
   WUP.dat_bis AS dat_stl,
     EXTRACT(YEAR FROM WUP.dat_eroeffnung) * 100 + EXTRACT(MONTH FROM WUP.dat_eroeffnung) AS kjmo_neo,
     EXTRACT(YEAR FROM WUP.dat_bis) * 100 + EXTRACT(MONTH FROM WUP.dat_bis) AS kjmo_stl,
   IF(VIS.kjmo BETWEEN EXTRACT(YEAR FROM WUP.dat_eroeffnung) * 100 + EXTRACT(MONTH FROM WUP.dat_eroeffnung) + 100 AND (EXTRACT(YEAR
         FROM WUP.dat_bis) * 100 + EXTRACT(MONTH FROM WUP.dat_bis)), 1, 0) AS flukt_fg
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_msi_view_vis.mv_wup_1 AS WUP_1 ON VIS.mandant_id = WUP.mandant_id AND VIS.wup_id = WUP.wup_id
     
   INNER JOIN kfl_production_dbp_data.l_buchungsstatus_ker_1 AS BSK ON VIS.kjmo = BSK.kj_ker_mo_id
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo AND ZEIT.akt_gj < 1
  WHERE VIS.nb_id IN (- 1, 0)
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.kjmo,
   ZEIT.akt_mo,
   ZEIT.mo_kj,
   ZEIT.gj,
   BSK.akt_fruehinfo2,
   dat_neo,
   dat_stl,
   kjmo_neo,
   kjmo_stl,
   flukt_fg) AS vis
 INNER JOIN (SELECT DISTINCT hr_objekt_bereich_id
  FROM kfl_production_dbp_view.v_l_org_einheit_bereich_1) AS obj_ber ON TRUE
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   kjmo,
   hr_objekt_bereich_id,
   SUM(kopf * aktiv) AS kopf_aktiv,
   SUM(kopf * flukt) AS kopf_flukt_aktmo,
   SUM(kopf * flukt_austritt) AS austritte,
   SUM(austritt_an_fg * flukt_austritt) AS austritt_an,
   SUM(austritt_ag_fg * flukt_austritt) AS austritt_ag,
   SUM(austritt_trw_fg * flukt) AS austritt_trw,
   SUM(austritt_vtg_fg * flukt) AS austritt_vtg,
   SUM(austritt_ana_fg * flukt) AS austritt_ana,
   SUM(austritt_ugsi_fg * flukt) AS austritt_ugsi,
   SUM(austritt_ugsw_fg * flukt) AS austritt_ugsw,
   SUM(austritt_bu_fg * flukt) AS austritt_bu,
   LAST_VALUE(SUM(kopf * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_flukt_vormo,
   AVG(SUM(kopf * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_flukt_rol,
   SUM(SUM(kopf * flukt_austritt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_rol,
   SUM(SUM(austritt_an_fg * flukt_austritt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_an_rol,
   SUM(SUM(austritt_ag_fg * flukt_austritt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ag_rol,
   SUM(SUM(austritt_trw_fg * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_trw_rol,
   SUM(SUM(austritt_vtg_fg * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_vtg_rol,
   SUM(SUM(austritt_ana_fg * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ana_rol,
   SUM(SUM(austritt_ugsi_fg * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ugsi_rol,
   SUM(SUM(austritt_ugsw_fg * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ugsw_rol,
   SUM(SUM(austritt_bu_fg * flukt)) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(wup_id AS STRING), CAST(hr_objekt_bereich_id AS STRING)
      ORDER BY kjmo IS NULL, kjmo ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_bu_rol
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_mitarbeiterbew_1
  WHERE shr_ma_funktion_gruppe_id IN (10, 20, 30, 40, 50, 60, 80)
   AND mandant_id <> 1
  GROUP BY mandant_id,
   wup_id,
   hr_objekt_bereich_id,
   kjmo) AS shr_ist ON vis.mandant_id = shr_ist.mandant_id AND vis.wup_id = shr_ist.wup_id AND vis.kjmo = shr_ist.kjmo
  AND obj_ber.hr_objekt_bereich_id = shr_ist.hr_objekt_bereich_id;