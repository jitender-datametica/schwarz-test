CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_hfm_inventur (mandant_id, nb_id, wup_id, gj, kjmo,
owg_id, hwg_id, abt_id, inventurart_int_id, abt_invart_id, dat_plan_zaehlung, dat_vorletzte_zaehlung, zeitraum, wrg_id,
inv_fg, inv_inv_fg, inventur_wert_netto, inventur_ums_netto, inventur_diebstahl_abschrift_netto,
inventur_preis_abschrift_netto, inventur_total_abschrift_netto, inventur_diff_kalk, inv_ums_netto_owg, inv_ums_netto_hwg
, inv_ums_netto_abt, inv_diebstahl_netto_owg) AS SELECT hfm.mandant_id,
 hfm.nb_id,
 hfm.wup_id,
 hfm.gj,
 hfm.kjmo,
 hfm.owg_id,
 OWG0.hwg_id,
 HWG0.abt_id,
 hfm.inventurart_int_id,
 AIA.abt_invart_id,
 hfm.dat_plan_zaehlung,
 hfm.dat_vorletzte_zaehlung,
 hfm.zeitraum,
 hfm.wrg_id,
 hfm.inv_fg,
 hfm.inv_inv_fg,
 hfm.inventur_wert_vk_netto AS inventur_wert_netto,
 hfm.umsatz_vk_netto_sum AS inventur_ums_netto,
 hfm.betrag_netto_diebstahl_abschrift AS inventur_diebstahl_abschrift_netto,
 hfm.betrag_netto_preis_abschrift AS inventur_preis_abschrift_netto,
 hfm.betrag_netto_total_abschrift AS inventur_total_abschrift_netto,
 hfm.betrag_kalk_inventur_diff AS inventur_diff_kalk,
 hfm.ums_netto_owg AS inv_ums_netto_owg,
 hfm.ums_netto_hwg AS inv_ums_netto_hwg,
 hfm.ums_netto_abt AS inv_ums_netto_abt,
 hfm.abs_netto_owg AS inv_diebstahl_netto_owg
FROM (SELECT inv.mandant_id,
   inv.nb_id,
   WUP.aktuell_wup_id AS wup_id,
   inv.owg_id,
   inv.inventurart_int_id,
   inv.dat_plan_zaehlung,
   inv.dat_vorletzte_zaehlung,
   CAST(DATE_DIFF(inv.dat_plan_zaehlung, inv.dat_vorletzte_zaehlung, DAY) AS BIGNUMERIC) AS zeitraum,
   ZEIT.gj,
   ZEIT.kjmo,
   inv.wrg_id,
   inv.inv_inv_fg,
   1 AS inv_fg,
   inv.inventur_wert_vk_netto,
   inv.umsatz_vk_netto_sum,
   inv.betrag_netto_diebstahl_abschrift,
   inv.betrag_netto_preis_abschrift,
   inv.betrag_netto_total_abschrift,
   inv.betrag_kalk_inventur_diff,
   SUM(vis_agg.ums_netto_owg) AS ums_netto_owg,
   SUM(vis_agg.ums_netto_hwg) AS ums_netto_hwg,
   SUM(vis_agg.ums_netto_abt) AS ums_netto_abt,
   SUM(vis_agg.abs_netto_owg) AS abs_netto_owg
  FROM (SELECT INV0.mandant_id,
     INV0.nb_id,
     INV0.wup_id,
     INV0.owg_id,
     INV0.inventurart_int_id,
     INV0.dat_plan_zaehlung,
     INV0.dat_vorletzte_zaehlung,
     krs.nach_wrg_id AS wrg_id,
      INV0.inventur_wert_vk_netto * krs.umrechnungskurs AS inventur_wert_vk_netto,
      INV0.umsatz_vk_netto_sum * krs.umrechnungskurs AS umsatz_vk_netto_sum,
      INV0.betrag_netto_diebstahl_abschrift * krs.umrechnungskurs AS betrag_netto_diebstahl_abschrift,
      INV0.betrag_netto_preis_abschrift * krs.umrechnungskurs AS betrag_netto_preis_abschrift,
      INV0.betrag_netto_total_abschrift * krs.umrechnungskurs AS betrag_netto_total_abschrift,
      INV0.betrag_kalk_inventur_diff * krs.umrechnungskurs AS betrag_kalk_inventur_diff,
     MAX(CASE
       WHEN INV0.inventurart_int_id IN (4, 5)
       THEN INV0.dat_plan_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_z_akt,
     MIN(CASE
       WHEN INV0.inventurart_int_id IN (4, 5)
       THEN INV0.dat_vorletzte_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_z_vor,
     MAX(CASE
       WHEN INV0.inventurart_int_id IN (3)
       THEN INV0.dat_plan_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_wg_akt,
     MIN(CASE
       WHEN INV0.inventurart_int_id IN (3)
       THEN INV0.dat_vorletzte_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_wg_vor,
     CAST(CASE
       WHEN INV0.inventurart_int_id = 8
       THEN - 1
       WHEN (MAX(CASE
           WHEN INV0.inventurart_int_id IN (4, 5)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL AND (MAX(CASE
           WHEN INV0.inventurart_int_id IN (3)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL
       THEN 1
       WHEN INV0.dat_plan_zaehlung = (MAX(CASE
           WHEN INV0.inventurart_int_id IN (4, 5)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN 1
       WHEN INV0.dat_plan_zaehlung BETWEEN MIN(CASE
          WHEN INV0.inventurart_int_id IN (4, 5)
          THEN INV0.dat_vorletzte_zaehlung
          ELSE NULL
          END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
           , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AND (MAX(CASE
           WHEN INV0.inventurart_int_id IN (4, 5)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN 0
       WHEN INV0.inventurart_int_id = 3
       THEN 1
       WHEN INV0.inventurart_int_id IN (1, 2) AND INV0.dat_plan_zaehlung BETWEEN MIN(CASE
           WHEN INV0.inventurart_int_id IN (3)
           THEN INV0.dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AND (MAX(CASE
            WHEN INV0.inventurart_int_id IN (3)
            THEN INV0.dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
             , CAST(INV0.owg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN 0
       ELSE 1
       END AS BIGNUMERIC) AS inv_inv_fg
    FROM kfl_production_dbp_view.v_hfm_inventur_termin_owg_wup_zu AS INV0
     INNER JOIN (SELECT von_wrg_id,
        nach_wrg_id,
        umrechnungskurs
       FROM kfl_production_dbp_data.kurs AS KRS1
       WHERE kurstyp_id = 3
        AND dat_bis = DATE '9999-12-31'
        AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
       UNION ALL
       SELECT von_wrg_id,
        von_wrg_id AS nach_wrg_id,
        1.00000 AS umrechnungskurs
       FROM kfl_production_dbp_data.kurs AS KRS2
       WHERE kurstyp_id = 3
        AND dat_bis = DATE '9999-12-31'
        AND von_wrg_id NOT IN ('AUD', 'DEM', 'EUR', 'SIT')) AS krs ON INV0.wrg_id = krs.von_wrg_id) AS inv
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT ON inv.dat_plan_zaehlung = ZEIT.dat
   LEFT JOIN (SELECT VIS_UMS.mandant_id,
     VIS_UMS.nb_id,
     VIS_UMS.wup_id,
     VIS_UMS.wrg_id,
     VIS_UMS.dat,
     HWG.abt_id,
     OWG.hwg_id,
     WG.owg_id,
     SUM(VIS_UMS.ums_netto) AS ums_netto_owg,
     SUM(VIS_ABS.abschrift_netto * - 1) AS abs_netto_owg,
     SUM(SUM(VIS_UMS.ums_netto)) OVER (PARTITION BY CAST(VIS_UMS.mandant_id AS STRING), CAST(VIS_UMS.wup_id AS STRING),
        VIS_UMS.wrg_id, VIS_UMS.dat, CAST(OWG.hwg_id AS STRING) ORDER BY VIS_UMS.mandant_id IS NULL, VIS_UMS.mandant_id
        , VIS_UMS.wup_id IS NULL, VIS_UMS.wup_id, VIS_UMS.wrg_id IS NULL, VIS_UMS.wrg_id, VIS_UMS.dat IS NULL, VIS_UMS.dat
        , WG.owg_id IS NULL, WG.owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ums_netto_hwg,
     SUM(SUM(VIS_UMS.ums_netto)) OVER (PARTITION BY CAST(VIS_UMS.mandant_id AS STRING), CAST(VIS_UMS.wup_id AS STRING),
        VIS_UMS.wrg_id, VIS_UMS.dat, CAST(HWG.abt_id AS STRING) ORDER BY VIS_UMS.mandant_id IS NULL, VIS_UMS.mandant_id
        , VIS_UMS.wup_id IS NULL, VIS_UMS.wup_id, VIS_UMS.wrg_id IS NULL, VIS_UMS.wrg_id, VIS_UMS.dat IS NULL, VIS_UMS.dat
        , WG.owg_id IS NULL, WG.owg_id RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ums_netto_abt
    FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg AS VIS_UMS
     INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT0 ON VIS_UMS.dat = ZEIT0.dat AND ZEIT0.akt_gj BETWEEN - 2 AND 0
     INNER JOIN kfl_production_dbp_view.v_wg_per AS WG ON VIS_UMS.wg_id = WG.wg_id AND VIS_UMS.mandant_id = WG.mandant_id
          AND WG.arthiertyp_id = 2 AND WG.dat_bis = DATE '9999-12-31'
     INNER JOIN kfl_production_dbp_view.v_owg_per AS OWG ON WG.owg_id = OWG.owg_id AND WG.mandant_id = OWG.mandant_id
       AND OWG.arthiertyp_id = 2 AND OWG.dat_bis = DATE '9999-12-31'
     INNER JOIN kfl_production_dbp_view.v_hwg_per AS HWG ON OWG.hwg_id = HWG.hwg_id AND OWG.mandant_id = HWG.mandant_id
       AND HWG.arthiertyp_id = 2 AND HWG.dat_bis = DATE '9999-12-31'
     LEFT JOIN (kfl_production_dbp_msi_v_view.v_vis_tag_abschriften_wg AS VIS_ABS INNER JOIN (SELECT abschriftart_id
       FROM kfl_production_dbp_view.v_abschriftart_int_zu
       WHERE abschriftart_int_id IN (190)
       GROUP BY abschriftart_id) AS t6 ON VIS_ABS.abschriftart_id = t6.abschriftart_id) ON VIS_UMS.mandant_id = VIS_ABS
          .mandant_id AND VIS_UMS.wup_id = VIS_ABS.wup_id AND VIS_UMS.wrg_id = VIS_ABS.wrg_id AND VIS_UMS.wg_id =
        VIS_ABS.wg_id AND VIS_UMS.dat = VIS_ABS.dat
    GROUP BY VIS_UMS.mandant_id,
     VIS_UMS.nb_id,
     VIS_UMS.wup_id,
     VIS_UMS.wrg_id,
     VIS_UMS.dat,
     HWG.abt_id,
     OWG.hwg_id,
     WG.owg_id) AS vis_agg ON inv.mandant_id = vis_agg.mandant_id AND inv.wup_id = vis_agg.wup_id AND inv.wrg_id =
       vis_agg.wrg_id AND inv.owg_id = vis_agg.owg_id AND vis_agg.dat BETWEEN inv.dat_vorletzte_zaehlung AND inv.dat_plan_zaehlung
     
   INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON inv.mandant_id = WUP.mandant_id AND inv.wup_id = WUP.wup_id
  GROUP BY inv.mandant_id,
   inv.nb_id,
   wup_id,
   inv.owg_id,
   inv.inventurart_int_id,
   inv.dat_plan_zaehlung,
   inv.dat_vorletzte_zaehlung,
   zeitraum,
   ZEIT.gj,
   ZEIT.kjmo,
   inv.wrg_id,
   inv.inv_inv_fg,
   inv_fg,
   inv.inventur_wert_vk_netto,
   inv.umsatz_vk_netto_sum,
   inv.betrag_netto_diebstahl_abschrift,
   inv.betrag_netto_preis_abschrift,
   inv.betrag_netto_total_abschrift,
   inv.betrag_kalk_inventur_diff) AS hfm
 INNER JOIN kfl_production_dbp_view.v_owg_per AS OWG0 ON hfm.owg_id = OWG0.owg_id AND hfm.mandant_id = OWG0.mandant_id
   AND OWG0.arthiertyp_id = 2 AND OWG0.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_hwg_per AS HWG0 ON OWG0.hwg_id = HWG0.hwg_id AND OWG0.mandant_id = HWG0.mandant_id
      AND HWG0.arthiertyp_id = 2 AND HWG0.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_abt_inventurart_int_zu AS AIA ON HWG0.abt_id = AIA.abt_id AND hfm.inventurart_int_id
    = AIA.inventurart_int_id;