CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_wup_stunden_tag_2 AS WITH ZEIT_2 AS (SELECT dat,
   wtag_id,
   akt_tag,
   akt_wo,
   akt_wo_komplett,
   akt_mo,
   akt_mo_komplett,
   akt_gj
  FROM kfl_production_dbp_data.tag_2
  WHERE akt_gj BETWEEN -3 AND 1), BASIS_VIS AS (SELECT VIS.mandant_id,
   VIS.nb_id,
   VIS.wrg_id,
   VIS.wup_id,
   VIS.dat,
   t1.wtag_id,
   t1.akt_tag,
   t1.akt_wo,
   t1.akt_wo_komplett,
   t1.akt_mo,
   t1.akt_mo_komplett,
   t1.akt_gj,
   SUM(VIS.anz_offen) AS offen,
   SUM(VIS.ums_netto) AS ums_ist,
   SUM(VIS.ums_netto_plan) AS ums_plan,
   SUM(VIS.ums_netto_wvj) AS ums_wvj
  FROM kfl_production_dbp_msi_view_vis.mv_vis_tag_fakt_wup_2 AS VIS
   INNER JOIN ZEIT_2 AS t1_2 ON VIS.dat = t1.dat
  WHERE VIS.nb_id IN (-1, 0)
  GROUP BY VIS.mandant_id,
   VIS.nb_id,
   VIS.wup_id,
   VIS.wrg_id,
   VIS.dat,
   t1.wtag_id,
   t1.akt_tag,
   t1.akt_wo,
   t1.akt_wo_komplett,
   t1.akt_mo,
   t1.akt_mo_komplett,
   t1.akt_gj), BASIS_WST AS (SELECT WST.mandant_id,
   krs.nach_wrg_id AS wrg_id,
   WUP.aktuell_wup_id AS wup_id,
   WST.dat,
   SUM(WST.stunden_markt) AS std_ist,
   SUM(WST.stunden_sonstige) AS std_ist_sonst,
   SUM(WST.stunden_plan) AS std_plan,
   SUM(WST.stunden_plan_pep) AS std_plan_pep,
   SUM(WST.stunden_sonstige_plan) AS std_plan_sonst,
   SUM(WST.stunden_plan_meldeschluss_plus1) AS std_plan_plus1,
   SUM(WST.stunden_plan_meldeschluss_plus2) AS std_plan_plus2,
   SUM(WST.stunden_sonstige_plan_plus1) AS std_plan_sonst_plus1,
   SUM(WST.stunden_sonstige_plan_plus2) AS std_plan_sonst_plus2,
   SUM(WST.stunden_co_ist) AS co_ist,
   SUM(WST.stunden_co1_iks) AS co1,
   SUM(WST.stunden_co2_ea) AS co2,
   SUM(WST.stunden_co3_anue) AS co3,
   SUM(WST.stunden_co4_reinigung) AS co4,
   SUM(WST.stunden_co5_sonstige) AS co5,
   SUM(WST.stunden_co_plan) AS co_plan,
   SUM(WST.stunden_co_plan_plus1) AS co_plan_plus1,
   SUM(WST.stunden_co_plan_plus2) AS co_plan_plus2,
   SUM(WST.ums_netto_plan_man * krs.umrechnungskurs) AS ums_plan_man,
   SUM(WST.ums_netto_plan_man_meldeschluss_plus1 * krs.umrechnungskurs) AS ums_plan_man_plus1,
   SUM(WST.ums_netto_plan_man_meldeschluss_plus2 * krs.umrechnungskurs) AS ums_plan_man_plus2,
   SUM(WST.stunden_plan_ssm) AS std_plan_ssm
  FROM kfl_production_dbp_view.v_wup_stunden_tag_2 AS WST
   INNER JOIN kfl_production_dbp_view.v_wup_2 AS WUP_2 ON WST.mandant_id = WUP.mandant_id AND WST.wup_id = WUP.wup_id
   INNER JOIN ZEIT_2 AS t7 ON WST.dat = t7.dat
   INNER JOIN (SELECT *
    FROM (SELECT von_wrg_id,
        nach_wrg_id,
        umrechnungskurs
       FROM kfl_production_dbp_data.kurs_2 AS KRS1
       WHERE kurstyp_id = 3
        AND dat_bis = DATE '9999-12-31'
        AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
       UNION ALL
       SELECT von_wrg_id,
        von_wrg_id AS nach_wrg_id,
        1.00000 AS umrechnungskurs
       FROM kfl_production_dbp_data.kurs_2 AS KRS2
       WHERE kurstyp_id = 3
        AND dat_bis = DATE '9999-12-31'
        AND von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')) AS t12) AS krs ON WST.wrg_id = krs.von_wrg_id
  WHERE WST.nb_id IN (-1, 0)
  GROUP BY WST.mandant_id,
   wrg_id,
   wup_id,
   WST.dat) (SELECT vis.mandant_id,
   vis.nb_id,
   vis.wup_id,
   vis.wrg_id,
   vis.dat,
   vis.wtag_id,
   vis.akt_tag,
   vis.akt_wo,
   vis.akt_wo_komplett,
   vis.akt_mo,
   vis.akt_mo_komplett,
   vis.akt_gj,
   vis.offen AS anz_offen,
   vis.ums_ist AS ums_netto,
   vis.ums_wvj AS ums_netto_wvj,
   vis.ums_plan AS ums_netto_plan,
   wst.ums_plan_man AS ums_netto_plan_man,
   wst.std_ist_sonst AS stunden_sonstige,
   wst.std_plan AS stunden_plan,
   wst.std_plan_sonst AS stunden_sonstige_plan,
   wst.std_ist AS stunden_markt,
   wst.std_plan_pep AS stunden_plan_pep,
   wst.co_ist AS stunden_co_ist,
   wst.co1 AS stunden_co1_iks,
   wst.co2 AS stunden_co2_ea,
   wst.co3 AS stunden_co3_anue,
   wst.co4 AS stunden_co4_reinigung,
   wst.co5 AS stunden_co5_sonstige,
   wst.co_plan AS stunden_co_plan,
   wst.std_plan_ssm AS stunden_jahresplan_ssm,
   IF(vis.akt_tag < 1, 1, 0) AS hoch_fg,
    CASE
    WHEN vis.mandant_id IN (1, 6)
    THEN IF(vis.akt_wo_komplett < 3, 1, 0)
    ELSE 1
    END AS plan_fg,
    CASE
    WHEN vis.mandant_id IN (1, 6)
    THEN IF(vis.akt_wo_komplett < 3, 1, 0)
    ELSE IF(vis.akt_mo_komplett < 3, 1, 0)
    END AS plan_fg1,
    CASE
    WHEN vis.mandant_id IN (1, 6)
    THEN IF(vis.akt_wo_komplett < 3, 1, 0)
    ELSE IF(vis.akt_mo_komplett < 2, 1, 0)
    END AS plan_fg2,
        IFNULL(wst.co_ist, 0) + wst.co1 + wst.co2 + wst.co3 + wst.co4 + wst.co5 AS basis_stunden_ist_co,
         IFNULL(wst.co_ist, 0) + wst.co1 + wst.co2 + wst.co3 + wst.co4 + wst.co5 + (wst.co4 + wst.co5) * IF(vis.akt_tag
       < 1, 1, 0) AS basis_stunden_ist_co2,
     IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5 AS basis_stunden_plan_co,
    IFNULL(wst.std_ist, 0) + IFNULL(wst.std_ist_sonst, 0) AS basis_stunden_ist,
    IFNULL(wst.std_plan, 0) + IFNULL(wst.std_plan_sonst, 0) AS basis_stunden_plan_hl,
    wst.std_plan_pep + IFNULL(wst.std_plan_sonst, 0) AS basis_stunden_plan_pep,
     IFNULL(wst.std_ist, 0) + IFNULL(wst.std_ist_sonst, 0) + (IFNULL(wst.co_ist, 0) + wst.co1 + wst.co2 + wst.co3 + wst
       .co4 + wst.co5) AS netto_stunden_ist,
     (IFNULL(wst.std_ist, 0) + IFNULL(wst.std_ist_sonst, 0) + (IFNULL(wst.co_ist, 0) + wst.co1 + wst.co2 + wst.co3 + wst
         .co4 + wst.co5)) * IF(vis.akt_tag < 1, 1, 0) AS netto_stunden_ist2,
     IFNULL(wst.std_plan, 0) + IFNULL(wst.std_plan_sonst, 0) + (IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5) AS
   netto_stunden_plan_hl,
     wst.std_plan_pep + IFNULL(wst.std_plan_sonst, 0) + (IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5) AS
   netto_stunden_plan_pep,
   IF(CASE
      WHEN vis.mandant_id = 1
      THEN IF(vis.akt_wo_komplett < 3, 1, 0)
      WHEN vis.mandant_id = 6
      THEN IF(vis.akt_wo_komplett < 3, 1, 0)
      ELSE 1
      END = 1, wst.std_plan_pep + IFNULL(wst.std_plan_sonst, 0) + (IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5), IFNULL(wst
       .std_plan, 0) + IFNULL(wst.std_plan_sonst, 0) + (IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5)) AS
   netto_stunden_plan,
   IF(IF(vis.akt_tag < 1, 1, 0) = 1, IFNULL(wst.std_ist, 0) + IFNULL(wst.std_ist_sonst, 0) + (IFNULL(wst.co_ist, 0) +
           wst.co1 + wst.co2 + wst.co3 + wst.co4 + wst.co5), IF(CASE
       WHEN vis.mandant_id = 1
       THEN IF(vis.akt_wo_komplett < 3, 1, 0)
       WHEN vis.mandant_id = 6
       THEN IF(vis.akt_wo_komplett < 3, 1, 0)
       ELSE 1
       END = 1, wst.std_plan_pep + IFNULL(wst.std_plan_sonst, 0) + (IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5), IFNULL(wst
        .std_plan, 0) + IFNULL(wst.std_plan_sonst, 0) + (IFNULL(wst.co_plan, 0) + wst.co4 + wst.co5))) AS
   netto_stunden_hoch,
   vis.ums_ist AS umsatz_netto_ist,
   vis.ums_plan AS umsatz_netto_plan_ker,
   wst.ums_plan_man AS umsatz_netto_plan_hl,
   IF(wst.ums_plan_man <> 0, wst.ums_plan_man, vis.ums_plan) AS umsatz_netto_plan,
   IF(IF(vis.akt_tag < 1, 1, 0) = 1, vis.ums_ist, IF(wst.ums_plan_man <> 0, wst.ums_plan_man, vis.ums_plan)) AS
   umsatz_netto_hoch,
   wst.std_plan_plus1 AS stunden_plan_meldeschluss_plus1,
   wst.std_plan_plus2 AS stunden_plan_meldeschluss_plus2,
   wst.std_plan_sonst_plus1 AS stunden_sonstige_plan_plus1,
   wst.std_plan_sonst_plus2 AS stunden_sonstige_plan_plus2,
   wst.co_plan_plus1 AS stunden_co_plan_plus1,
   wst.co_plan_plus2 AS stunden_co_plan_plus2,
   wst.ums_plan_man_plus1 AS ums_netto_plan_man_meldeschluss_plus1,
   wst.ums_plan_man_plus2 AS ums_netto_plan_man_meldeschluss_plus2,
   IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) AS umsatz_netto_plan_plus2,
      (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) /
     IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0
       , wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 AS abw,
    CASE
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
          )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
           <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 < -20
    THEN 1
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 >= -20 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) -
          IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0,
           wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis
          .ums_plan)) * 100.00 < -10
    THEN 2
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 >= -10 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) -
          IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0,
           wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis
          .ums_plan)) * 100.00 < -5
    THEN 3
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 >= -5 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst
            .ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2
           , vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 <
      -2.5
    THEN 4
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 >= -2.5 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) -
          IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0,
           wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis
          .ums_plan)) * 100.00 < -1
    THEN 5
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 >= -1 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst
            .ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2
           , vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 <=
      1
    THEN 6
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 > 1 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst
            .ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2
           , vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 <=
      2.5
    THEN 7
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 > 2.5 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst
            .ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2
           , vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 <=
      5
    THEN 8
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 > 5 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst
            .ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2
           , vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 <=
      10
    THEN 9
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
           )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
            <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 > 10 AND (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst
            .ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2
           , vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 <=
      20
    THEN 10
    WHEN (IF(vis.ums_ist = 0, NULL, vis.ums_ist) - IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan
          )) / IF(IF(wst.ums_plan_man_plus2 <> 0, wst.ums_plan_man_plus2, vis.ums_plan) = 0, NULL, IF(wst.ums_plan_man_plus2
           <> 0, wst.ums_plan_man_plus2, vis.ums_plan)) * 100.00 > 20
    THEN 11
    ELSE -1
    END AS filialebene_id,
   NULL AS stunden_versetzung,
   NULL AS ums_netto_plan_man_meldeschluss,
   NULL AS stunden_plan_meldeschluss
  FROM BASIS_VIS AS vis
   LEFT JOIN BASIS_WST AS wst ON vis.mandant_id = wst.mandant_id AND vis.wup_id = wst.wup_id AND vis.wrg_id = wst.wrg_id
       AND vis.dat = wst.dat);