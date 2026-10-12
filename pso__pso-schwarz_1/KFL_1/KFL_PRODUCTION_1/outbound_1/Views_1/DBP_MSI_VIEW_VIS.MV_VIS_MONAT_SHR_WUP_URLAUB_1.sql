CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_shr_wup_urlaub_1 (mandant_id, nb_id, wrg_id, wup_id,
gj, kjmo, akt_mo, akt_mo_shr, fruehinfo2, kopf, kopf_kvj, tage_urlaub_rest_vj_kj, tage_urlaub_anspruch_akt_kj,
tage_urlaub_genommen_kj_kum, tage_urlaub_abgeltung_kj_kum, tage_urlaub_rest_vj_kj_kvj, tage_urlaub_anspruch_akt_kj_kvj,
tage_urlaub_genommen_kj_kum_kvj, tage_urlaub_abgeltung_kj_kum_kvj) AS SELECT vis.mandant_id,
 vis.nb_id,
 vis.wrg_id,
 vis.wup_id,
 vis.gj,
 vis.kjmo,
 vis.akt_mo,
  vis.akt_fruehinfo2 - 1 AS akt_mo_shr,
 vis.akt_fruehinfo2 AS fruehinfo2,
 ruq.kopf,
 ruq_kvj.kopf AS kopf_kvj,
 ruq.tage_urlaub_rest_vj_kj,
 ruq.tage_urlaub_anspruch_akt_kj,
 ruq.tage_urlaub_genommen_kj_kum,
 ruq.tage_urlaub_abgeltung_kj_kum,
 ruq_kvj.tage_urlaub_rest_vj_kj AS tage_urlaub_rest_vj_kj_kvj,
 ruq_kvj.tage_urlaub_anspruch_akt_kj AS tage_urlaub_anspruch_akt_kj_kvj,
 ruq_kvj.tage_urlaub_genommen_kj_kum AS tage_urlaub_genommen_kj_kum_kvj,
 ruq_kvj.tage_urlaub_abgeltung_kj_kum AS tage_urlaub_abgeltung_kj_kum_kvj
FROM (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.kjmo,
   ZEIT.gj,
   ZEIT.akt_mo,
   KER.akt_fruehinfo2,
   KER.akt_buchungs_schluss
  FROM kfl_production_dbp_msi_view_vis.mv_vis_monat_fakt_wup_1 AS VIS
   INNER JOIN kfl_production_dbp_data.monat_1 AS ZEIT_1 ON VIS.kjmo = ZEIT.kjmo
   INNER JOIN kfl_production_dbp_data.l_buchungsstatus_ker_1 AS KER ON VIS.kjmo = KER.kj_ker_mo_id
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.kjmo,
   ZEIT.gj,
   ZEIT.akt_mo,
   KER.akt_buchungs_schluss,
   KER.akt_fruehinfo2) AS vis
 LEFT JOIN (SELECT RUQ0.mandant_id,
   RUQ0.nb_id,
   RUQ0.kjmo,
   1 AS kopf,
   WUP.aktuell_wup_id AS wup_id,
   SUM(RUQ0.anz_tage_urlaub_rest_vj_kj) AS tage_urlaub_rest_vj_kj,
   SUM(RUQ0.anz_tage_urlaub_anspruch_akt_kj) AS tage_urlaub_anspruch_akt_kj,
   SUM(RUQ0.anz_tage_urlaub_genommen_kj_kum) AS tage_urlaub_genommen_kj_kum,
   SUM(RUQ0.anz_tage_urlaub_abgeltung_kj_kum) AS tage_urlaub_abgeltung_kj_kum
  FROM kfl_production_dbp_view.v_vis_monat_shr_wup_funktgr_upload_1 AS RUQ0
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON RUQ0.mandant_id = WUP.mandant_id AND RUQ0.wup_id = WUP.wup_id
  WHERE RUQ0.shr_ma_funktion_gruppe_id = - 1
  GROUP BY RUQ0.mandant_id,
   RUQ0.nb_id,
   RUQ0.kjmo,
   kopf,
   wup_id) AS ruq ON vis.mandant_id = ruq.mandant_id AND vis.wup_id = ruq.wup_id AND vis.kjmo = ruq.kjmo
 LEFT JOIN (SELECT RUQ00.mandant_id,
   RUQ00.nb_id,
   RUQ00.kjmo,
   1 AS kopf,
   WUP0.aktuell_wup_id AS wup_id,
   SUM(RUQ00.anz_tage_urlaub_rest_vj_kj) AS tage_urlaub_rest_vj_kj,
   SUM(RUQ00.anz_tage_urlaub_anspruch_akt_kj) AS tage_urlaub_anspruch_akt_kj,
   SUM(RUQ00.anz_tage_urlaub_genommen_kj_kum) AS tage_urlaub_genommen_kj_kum,
   SUM(RUQ00.anz_tage_urlaub_abgeltung_kj_kum) AS tage_urlaub_abgeltung_kj_kum
  FROM kfl_production_dbp_view.v_vis_monat_shr_wup_funktgr_upload_1 AS RUQ00
   INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP0 ON RUQ00.mandant_id = WUP0.mandant_id AND RUQ00.wup_id = WUP0.wup_id
     
  WHERE RUQ00.shr_ma_funktion_gruppe_id = - 1
  GROUP BY RUQ00.mandant_id,
   RUQ00.nb_id,
   RUQ00.kjmo,
   kopf,
   wup_id) AS ruq_kvj ON vis.mandant_id = ruq_kvj.mandant_id AND vis.wup_id = ruq_kvj.wup_id AND ruq_kvj.kjmo + 100 =
   vis.kjmo;