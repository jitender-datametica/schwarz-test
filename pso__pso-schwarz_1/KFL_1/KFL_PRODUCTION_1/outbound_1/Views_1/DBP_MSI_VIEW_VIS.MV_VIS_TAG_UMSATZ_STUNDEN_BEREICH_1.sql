CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_umsatz_stunden_bereich_1 (mandant_id, nb_id, wup_id,
wrg_id, dat, hr_objekt_bereich_id, ums_netto, ums_netto_wvj, ums_netto_kvj, stunden_netto, stunden_netto_plan,
stunden_soll_fix, stunden_soll_dyn, stunden_soll) AS SELECT VIS.mandant_id,
 VIS.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 VIS.wrg_id,
 VIS.dat,
 VIS.hr_objekt_bereich_id,
 VIS.ums_netto,
 VIS.ums_netto_wvj,
 VIS.ums_netto_kvj,
 NSB.stunden_netto,
 NSB.stunden_netto_plan,
 0.00 AS stunden_soll_fix,
 0.00 AS stunden_soll_dyn,
 0.00 AS stunden_soll
FROM (SELECT VIS00.mandant_id,
    VIS00.nb_id,
    VIS00.wup_id,
    VIS00.wrg_id,
    VIS00.dat,
    hob00.hr_objekt_bereich_id,
    SUM(VIS00.ums_netto) AS ums_netto,
    SUM(VIS00.ums_netto_wvj) AS ums_netto_wvj,
    SUM(VIS00.ums_netto_kvj) AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_kunde_wup_1 AS VIS00
    INNER JOIN (SELECT DISTINCT hr_objekt_bereich_id
     FROM kfl_production_dbp_view.v_l_org_einheit_bereich_1
     WHERE hr_objekt_bereich_id IN (- 1, 10, 60)) AS hob00 ON TRUE
   WHERE VIS00.nb_id IN (- 1, 0)
    AND VIS00.akt_gj BETWEEN - 1 AND 1
   GROUP BY VIS00.mandant_id,
    VIS00.dat,
    VIS00.nb_id,
    VIS00.wup_id,
    VIS00.wrg_id,
    hob00.hr_objekt_bereich_id
   UNION ALL
   SELECT VIS01.mandant_id,
    VIS01.nb_id,
    VIS01.wup_id,
    VIS01.wrg_id,
    VIS01.dat,
    ware.hr_objekt_bereich_id,
    SUM(VIS01.ums_netto) AS ums_netto,
    SUM(VIS01.ums_netto_wvj) AS ums_netto_wvj,
    SUM(VIS01.ums_netto_kvj) AS ums_netto_kvj
   FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg_1 AS VIS01
    INNER JOIN (SELECT DISTINCT OWG.hr_objekt_bereich_id,
      WG.owg_id,
      WG.wg_id
     FROM kfl_production_dbp_view.v_wg_per_1 AS WG
      INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS OWG ON WG.owg_id = OWG.owg_id AND OWG.dat_bis = DATE '9999-12-31'
       AND OWG.arthiertyp_id = 2) AS ware ON VIS01.wg_id = ware.wg_id
   WHERE VIS01.nb_id IN (- 1, 0)
   GROUP BY VIS01.mandant_id,
    VIS01.dat,
    VIS01.nb_id,
    VIS01.wup_id,
    VIS01.wrg_id,
    ware.hr_objekt_bereich_id) AS VIS
 LEFT JOIN (SELECT mandant_id,
   nb_id,
   wup_id,
   dat,
   hr_objekt_bereich_id,
   SUM(CASE
     WHEN stunden_typ_fg = 0
     THEN stunden_1
     ELSE 0.00
     END) AS stunden_netto,
   SUM(CASE
     WHEN stunden_typ_fg = 1
     THEN stunden_1
     ELSE 0.00
     END) AS stunden_netto_plan
  FROM kfl_production_dbp_view.v_nettostunden_bereich_1 AS NSB
  GROUP BY mandant_id,
   nb_id,
   wup_id,
   dat,
   hr_objekt_bereich_id) AS NSB ON VIS.wup_id = NSB.wup_id AND VIS.mandant_id = NSB.mandant_id AND VIS.dat = NSB.dat AND
   VIS.hr_objekt_bereich_id = NSB.hr_objekt_bereich_id
 INNER JOIN kfl_production_dbp_view.v_wup_1 AS WUP_1 ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id;