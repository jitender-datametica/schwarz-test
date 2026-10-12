CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_umsatz_stunden_bereich_de_2 (mandant_id, nb_id, wup_id,
wrg_id, dat, hr_objekt_bereich_id, hr_objekt_bereich_bez, ums_netto, ums_netto_wvj, ums_netto_kvj, stunden_netto,
stunden_netto_plan) AS SELECT vis.mandant_id,
 vis.nb_id,
 vis.wup_id,
 vis.wrg_id,
 vis.dat,
 vis.hr_objekt_bereich_id,
 '' AS hr_objekt_bereich_bez,
 vis.ums_netto,
 vis.ums_netto_wvj,
 vis.ums_netto_kvj,
  nsb.std_ist + nsb.sonst_ist AS stunden_netto,
  nsb.std_plan + nsb.sonst_plan AS stunden_netto_plan
FROM (SELECT mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    -1 AS hr_objekt_bereich_id,
    SUM(ums_netto) AS ums_netto,
    SUM(ums_netto_wvj) AS ums_netto_wvj,
    SUM(ums_netto_kvj) AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 AS VIS
   WHERE nb_id IN (-1, 0)
    AND akt_gj BETWEEN -1 AND 1
   GROUP BY mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    hr_objekt_bereich_id
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    60 AS hr_objekt_bereich_id,
    SUM(ums_netto) AS ums_netto,
    SUM(ums_netto_wvj) AS ums_netto_wvj,
    SUM(ums_netto_kvj) AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 AS VIS
   WHERE nb_id IN (-1, 0)
    AND akt_gj BETWEEN -1 AND 1
   GROUP BY mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    hr_objekt_bereich_id
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    10 AS hr_objekt_bereich_id,
    SUM(ums_netto) AS ums_netto,
    SUM(ums_netto_wvj) AS ums_netto_wvj,
    SUM(ums_netto_kvj) AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 AS VIS
   WHERE nb_id = 0
    AND akt_gj BETWEEN -1 AND 1
   GROUP BY mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    hr_objekt_bereich_id
   UNION ALL
   SELECT mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    11 AS hr_objekt_bereich_id,
    0.00 AS ums_netto,
    0.00 AS ums_netto_wvj,
    0.00 AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_2 AS VIS
   WHERE nb_id = 0
    AND akt_gj BETWEEN -1 AND 1
   GROUP BY mandant_id,
    nb_id,
    wup_id,
    wrg_id,
    dat,
    hr_objekt_bereich_id
   UNION ALL
   SELECT VIS3.mandant_id,
    VIS3.nb_id,
    VIS3.wup_id,
    VIS3.wrg_id,
    VIS3.dat,
    ware.hr_objekt_bereich_id,
    SUM(VIS3.ums_netto) AS ums_netto,
    SUM(VIS3.ums_netto_wvj) AS ums_netto_wvj,
    SUM(VIS3.ums_netto_kvj) AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg_2 AS VIS3
    INNER JOIN (SELECT DISTINCT OWG.hr_objekt_bereich_id_de AS hr_objekt_bereich_id,
      WG.owg_id,
      WG.wg_id
     FROM kfl_production_dbp_view.v_wg_per_2 AS WG
      INNER JOIN kfl_production_dbp_view.v_owg_per_2 AS OWG ON WG.owg_id = OWG.owg_id AND OWG.dat_bis = DATE '9999-12-31'
       AND OWG.arthiertyp_id = 2) AS ware ON VIS3.wg_id = ware.wg_id
   WHERE VIS3.nb_id IN (-1, 0)
   GROUP BY VIS3.mandant_id,
    VIS3.dat,
    VIS3.nb_id,
    VIS3.wup_id,
    VIS3.wrg_id,
    ware.hr_objekt_bereich_id) AS vis
 LEFT JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   dat,
   hr_objekt_bereich_id,
   SUM(CASE
     WHEN stunden_typ_fg = 0 AND quelle_id IN (2, 3, 4)
     THEN stunden_2
     ELSE 0.00
     END) AS std_ist,
   SUM(CASE
     WHEN stunden_typ_fg = 1 AND quelle_id IN (2, 3, 4)
     THEN stunden_2
     ELSE 0.00
     END) AS std_plan,
   SUM(CASE
     WHEN stunden_typ_fg = 0 AND quelle_id NOT IN (2, 3, 4)
     THEN stunden_2
     ELSE 0.00
     END) AS sonst_ist,
   SUM(CASE
     WHEN stunden_typ_fg = 1 AND quelle_id NOT IN (2, 3, 4)
     THEN stunden_2
     ELSE 0.00
     END) AS sonst_plan
  FROM kfl_production_dbp_view.v_nettostunden_bereich_2 AS NSB
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   dat,
   hr_objekt_bereich_id) AS nsb ON vis.wup_id = nsb.wup_id AND vis.mandant_id = nsb.mandant_id AND vis.dat = nsb.dat AND
   vis.hr_objekt_bereich_id = nsb.hr_objekt_bereich_id
 LEFT JOIN (SELECT SSM.mandant_id,
   SSM.wup_id,
   SSM.nb_id,
   SSM.dat,
   SSM_DE.wup_bereich_id
  FROM kfl_production_dbp_view.v_ssm_wup_tag_stunde_2 AS SSM
   INNER JOIN kfl_production_dbp_view.v_l_ssm_abteilung_de_2 AS SSM_DE ON SSM.wup_abt_id = SSM_DE.wup_abt_id
  GROUP BY SSM.mandant_id,
   SSM.wup_id,
   SSM.nb_id,
   SSM.dat,
   SSM_DE.wup_bereich_id) AS ssm ON vis.wup_id = ssm.wup_id AND vis.mandant_id = ssm.mandant_id AND vis.dat = ssm.dat;