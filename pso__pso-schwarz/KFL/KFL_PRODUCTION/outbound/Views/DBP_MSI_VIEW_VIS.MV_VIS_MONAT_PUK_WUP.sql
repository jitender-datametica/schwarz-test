CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_puk_wup (mandant_id, nb_id, wup_id, vkl_id, gf_id,
vs_id, wrg_id, kjmo, ums_netto, ums_netto_kvj, ums_netto_plan, ums_netto_frische, ums_netto_frische_kvj, anz_kunde,
anz_kunde_kvj, pers_std, pers_std_kvj, pers_std_plan, pers_kosten, pers_kosten_kvj, pers_kosten_plan, menge, menge_kvj,
menge_frische, menge_frische_kvj, kassierzeit, kassierzeit_kvj, scanzeit, scanzeit_kvj, abschrift_op, abschrift_op_kvj,
abschrift_op_frische, abschrift_op_frische_kvj) AS SELECT VIS.mandant_id,
 VIS.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 WUP.vkl_id,
 WUP.gf_id,
 WUP.vs_id,
 VIS.wrg_id,
 VIS.kjmo,
 VIS.ums_netto,
 VIS.ums_netto_kvj,
 VIS.ums_netto_plan,
 uwg.sum_ums_netto_frische AS ums_netto_frische,
 uwg.sum_ums_netto_frische_kvj AS ums_netto_frische_kvj,
 VIS.anz_kunde,
 VIS.anz_kunde_kvj,
 VIS.pers_std,
 VIS.pers_std_kvj,
 VIS.pers_std_plan,
 VIS.pers_kosten,
 VIS.pers_kosten_kvj,
 VIS.pers_kosten_plan,
 uwg.sum_menge AS menge,
 uwg.sum_menge_kvj AS menge_kvj,
 uwg.sum_menge_frische AS menge_frische,
 uwg.sum_menge_frische_kvj AS menge_frische_kvj,
 vtk.sum_kassierzeit AS kassierzeit,
 vtk_kvj.sum_kassierzeit AS kassierzeit_kvj,
 vtk.sum_scanzeit AS scanzeit,
 vtk_kvj.sum_scanzeit AS scanzeit_kvj,
 awg.sum_abschrift_netto AS abschrift_op,
 awg.sum_abschrift_netto_kvj AS abschrift_op_kvj,
 awg.sum_abschrift_frische AS abschrift_op_frische,
 awg.sum_abschrift_frische_kvj AS abschrift_op_frische_kvj
FROM kfl_production_dbp_msi_data.vis_monat_ums_kunde_pers_wup AS VIS
 INNER JOIN kfl_production_dbp_data.wup AS WUP ON VIS.wup_id = WUP.wup_id AND VIS.mandant_id = WUP.mandant_id
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   nb_id,
   wrg_id,
   kjmo,
   SUM(menge_absatz) AS sum_menge,
   SUM(menge_absatz_kvj) AS sum_menge_kvj,
   SUM(IF(abt_id = 5, menge_absatz, 0.00)) AS sum_menge_frische,
   SUM(IF(abt_id = 5, menge_absatz_kvj, 0.00)) AS sum_menge_frische_kvj,
   SUM(IF(abt_id = 5, ums_netto, 0.00)) AS sum_ums_netto_frische,
   SUM(IF(abt_id = 5, ums_netto_kvj, 0.00)) AS sum_ums_netto_frische_kvj
  FROM kfl_production_dbp_msi_data.vis_monat_umsatz_wg
  GROUP BY mandant_id,
   wup_id,
   nb_id,
   wrg_id,
   kjmo) AS uwg ON VIS.wup_id = uwg.wup_id AND VIS.mandant_id = uwg.mandant_id AND VIS.kjmo = uwg.kjmo AND VIS.wrg_id =
   uwg.wrg_id
 LEFT JOIN (SELECT VTK.mandant_id,
   VTK.wup_id,
   VTK.nb_id,
   ZEIT.kjmo,
   SUM(VTK.kassierzeit) AS sum_kassierzeit,
   SUM(VTK.registrierzeit / 60) AS sum_scanzeit
  FROM kfl_production_dbp_data.vis_tag_kasse AS VTK
   INNER JOIN kfl_production_dbp_data.tag AS ZEIT ON VTK.dat = ZEIT.dat
   LEFT JOIN kfl_production_dbp_data.kasse_typ_per AS KTP ON VTK.mandant_id = KTP.mandant_id AND VTK.wup_id = KTP.wup_id
        AND VTK.kasse_nr = KTP.kasse_nr AND VTK.dat BETWEEN KTP.dat_von AND KTP.dat_bis
  WHERE COALESCE(KTP.kasse_typ_id, VTK.kasse_typ_id) = 1
  GROUP BY VTK.wup_id,
   VTK.nb_id,
   VTK.mandant_id,
   ZEIT.kjmo) AS vtk ON VIS.wup_id = vtk.wup_id AND VIS.mandant_id = vtk.mandant_id AND VIS.kjmo = vtk.kjmo
 LEFT JOIN (SELECT VTK0.mandant_id,
   VTK0.wup_id,
   VTK0.nb_id,
   ZEIT0.kjmo,
   SUM(VTK0.kassierzeit) AS sum_kassierzeit,
   SUM(VTK0.registrierzeit / 60) AS sum_scanzeit
  FROM kfl_production_dbp_data.vis_tag_kasse AS VTK0
   INNER JOIN kfl_production_dbp_data.tag AS ZEIT0 ON VTK0.dat = ZEIT0.dat
   LEFT JOIN kfl_production_dbp_data.kasse_typ_per AS KTP0 ON VTK0.mandant_id = KTP0.mandant_id AND VTK0.wup_id = KTP0.wup_id
        AND VTK0.kasse_nr = KTP0.kasse_nr AND VTK0.dat BETWEEN KTP0.dat_von AND KTP0.dat_bis
  WHERE COALESCE(KTP0.kasse_typ_id, VTK0.kasse_typ_id) = 1
  GROUP BY VTK0.wup_id,
   VTK0.nb_id,
   VTK0.mandant_id,
   ZEIT0.kjmo) AS vtk_kvj ON VIS.wup_id = vtk_kvj.wup_id AND VIS.mandant_id = vtk_kvj.mandant_id AND VIS.kjmo = vtk_kvj
    .kjmo + 100
 LEFT JOIN (SELECT AWG.mandant_id,
   AWG.wup_id,
   AWG.nb_id,
   AWG.wrg_id,
   AWG.kjmo,
   SUM(CASE
      WHEN AWG.mandant_id = 6 AND AWG.abschriftart_id = 2 OR AWG.mandant_id = 3 AND AWG.abschriftart_id = 11 OR AWG.mandant_id
           IN (2, 5, 7, 8) AND AWG.abschriftart_id = 7 OR AWG.mandant_id IN (2, 5) AND AWG.abschriftart_id = 10
      THEN 1
      ELSE - 1
      END * AWG.abschrift_netto) AS sum_abschrift_netto,
   SUM(CASE
      WHEN AWG.mandant_id = 6 AND AWG.abschriftart_id = 2 OR AWG.mandant_id = 3 AND AWG.abschriftart_id = 11 OR AWG.mandant_id
           IN (2, 5, 7, 8) AND AWG.abschriftart_id = 7 OR AWG.mandant_id IN (2, 5) AND AWG.abschriftart_id = 10
      THEN 1
      ELSE - 1
      END * AWG.abschrift_netto_kvj) AS sum_abschrift_netto_kvj,
   SUM(CASE
     WHEN AWG.abt_id IN (5)
     THEN CASE
       WHEN AWG.mandant_id = 6 AND AWG.abschriftart_id = 2 OR AWG.mandant_id = 3 AND AWG.abschriftart_id = 11 OR AWG.mandant_id
            IN (2, 5, 7, 8) AND AWG.abschriftart_id = 7 OR AWG.mandant_id IN (2, 5) AND AWG.abschriftart_id = 10
       THEN 1
       ELSE - 1
       END * AWG.abschrift_netto
     ELSE 0.00
     END) AS sum_abschrift_frische,
   SUM(CASE
     WHEN AWG.abt_id IN (5)
     THEN CASE
       WHEN AWG.mandant_id = 6 AND AWG.abschriftart_id = 2 OR AWG.mandant_id = 3 AND AWG.abschriftart_id = 11 OR AWG.mandant_id
            IN (2, 5, 7, 8) AND AWG.abschriftart_id = 7 OR AWG.mandant_id IN (2, 5) AND AWG.abschriftart_id = 10
       THEN 1
       ELSE - 1
       END * AWG.abschrift_netto_kvj
     ELSE 0.00
     END) AS sum_abschrift_frische_kvj
  FROM kfl_production_dbp_msi_data.vis_tag_abschriften_wg AS AWG
   INNER JOIN (SELECT mandant_id,
     abschriftart_id
    FROM kfl_production_dbp_data.abschriftart_int_zu AS AIZ
    WHERE abschriftart_int_id IN (SELECT abschriftart_int_id
       FROM kfl_production_dbp_data.l_abschriftart_int
       WHERE abschriftart_thema_int_id IN (1, 4))) AS aiz ON AWG.mandant_id = aiz.mandant_id AND AWG.abschriftart_id =
     aiz.abschriftart_id
  GROUP BY AWG.mandant_id,
   AWG.wup_id,
   AWG.nb_id,
   AWG.wrg_id,
   AWG.kjmo) AS awg ON VIS.wup_id = awg.wup_id AND VIS.mandant_id = awg.mandant_id AND VIS.kjmo = awg.kjmo AND VIS.wrg_id
    = awg.wrg_id
WHERE MOD(CAST(VIS.kjmo AS BIGNUMERIC), 100) <> 13
 AND VIS.nb_id = 0;