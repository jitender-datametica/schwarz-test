CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hfm_inventur_termin AS SELECT hfm.mandant_id,
 hfm.nb_id,
 hfm.wup_id,
 hfm.gj,
 hfm.wg_id,
 HWG.hwg_id,
 ABT.abt_id,
 hfm.inventurart_int_id,
   hfm.inventurart_int_id * 100 + CAST(HWG.hwg_id AS BIGNUMERIC) AS inventurart_hwg_id,
 hfm.dat_plan_zaehlung,
 hfm.dat_vorletzte_zaehlung,
 hfm.zeitraum,
 hfm.wrg_id,
 hfm.wert_netto_inventur,
 hfm.ums_netto_inventur,
 hfm.ums_netto_wg,
 hfm.ums_netto_abt,
 hfm.inv_fg,
 hfm.inv_inv AS inv_inv_fg
FROM (SELECT inv.mandant_id,
   inv.nb_id,
   inv.wup_id,
   inv.wg_id,
   inv.inventurart_int_id,
   inv.dat_plan_zaehlung,
   inv.dat_vorletzte_zaehlung,
   CAST(DATE_DIFF(inv.dat_plan_zaehlung, inv.dat_vorletzte_zaehlung, DAY) AS BIGNUMERIC) AS zeitraum,
   ZEIT.gj,
   inv.wrg_id,
   inv.inventur_wert_vk_netto AS wert_netto_inventur,
   inv.umsatz_vk_netto_sum AS ums_netto_inventur,
   inv.inv_inv,
   1 AS inv_fg,
   SUM(vis.ums_netto) AS ums_netto_wg,
   SUM(vis.ums_netto_abt) AS ums_netto_abt
  FROM (SELECT mandant_id,
      nb_id,
      wup_id,
      wg_id,
      inventurart_int_id,
      dat_plan_zaehlung,
      dat_vorletzte_zaehlung,
      wrg_id,
      inventur_wert_vk_netto,
      umsatz_vk_netto_sum,
      MAX(CASE
        WHEN inventurart_int_id IN (4, 5)
        THEN dat_plan_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_aktuell,
      MIN(CASE
        WHEN inventurart_int_id IN (4, 5)
        THEN dat_vorletzte_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_vorher,
      MAX(CASE
        WHEN inventurart_int_id IN (3)
        THEN dat_plan_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_aktuell_wg,
      MIN(CASE
        WHEN inventurart_int_id IN (3)
        THEN dat_vorletzte_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_vorher_wg,
      CAST(CASE
        WHEN inventurart_int_id = 8
        THEN - 1
        WHEN (MAX(CASE
            WHEN inventurart_int_id IN (4, 5)
            THEN dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL AND (MAX(CASE
            WHEN inventurart_int_id IN (3)
            THEN dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL
        THEN 1
        WHEN dat_plan_zaehlung = (MAX(CASE
            WHEN inventurart_int_id IN (4, 5)
            THEN dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN 1
        WHEN dat_plan_zaehlung BETWEEN MIN(CASE
           WHEN inventurart_int_id IN (4, 5)
           THEN dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AND (MAX(CASE
            WHEN inventurart_int_id IN (4, 5)
            THEN dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN 0
        WHEN inventurart_int_id = 3
        THEN 1
        WHEN inventurart_int_id IN (1, 2) AND dat_plan_zaehlung BETWEEN MIN(CASE
            WHEN inventurart_int_id IN (3)
            THEN dat_vorletzte_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AND (MAX(CASE
             WHEN inventurart_int_id IN (3)
             THEN dat_plan_zaehlung
             ELSE NULL
             END) OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(nb_id AS STRING), CAST(wup_id AS STRING), CAST(wg_id AS STRING)
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN 0
        ELSE 1
        END AS BIGNUMERIC) AS inv_inv
     FROM kfl_production_dbp_view.v_hfm_inventur_termin_wg_wup_zu_per AS INV0
     UNION ALL
     SELECT INV0.mandant_id,
      INV0.nb_id,
      INV0.wup_id,
      INV0.wg_id,
      INV0.inventurart_int_id,
      INV0.dat_plan_zaehlung,
      INV0.dat_vorletzte_zaehlung,
      KURS0.nach_wrg_id AS wrg_id,
       INV0.inventur_wert_vk_netto * KURS0.umrechnungskurs AS inventur_wert_vk_netto,
       INV0.umsatz_vk_netto_sum * KURS0.umrechnungskurs AS umsatz_vk_netto_sum,
      MAX(CASE
        WHEN INV0.inventurart_int_id IN (4, 5)
        THEN INV0.dat_plan_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
         , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_aktuell,
      MIN(CASE
        WHEN INV0.inventurart_int_id IN (4, 5)
        THEN INV0.dat_vorletzte_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
         , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_vorher,
      MAX(CASE
        WHEN INV0.inventurart_int_id IN (3)
        THEN INV0.dat_plan_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
         , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_aktuell_wg,
      MIN(CASE
        WHEN INV0.inventurart_int_id IN (3)
        THEN INV0.dat_vorletzte_zaehlung
        ELSE NULL
        END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
         , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS dat_inv_vorher_wg,
      CAST(CASE
        WHEN INV0.inventurart_int_id = 8
        THEN - 1
        WHEN (MAX(CASE
            WHEN INV0.inventurart_int_id IN (4, 5)
            THEN INV0.dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
             , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL AND (MAX(CASE
            WHEN INV0.inventurart_int_id IN (3)
            THEN INV0.dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
             , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) IS NULL
        THEN 1
        WHEN INV0.dat_plan_zaehlung = (MAX(CASE
            WHEN INV0.inventurart_int_id IN (4, 5)
            THEN INV0.dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
             , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN 1
        WHEN INV0.dat_plan_zaehlung BETWEEN MIN(CASE
           WHEN INV0.inventurart_int_id IN (4, 5)
           THEN INV0.dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AND (MAX(CASE
            WHEN INV0.inventurart_int_id IN (4, 5)
            THEN INV0.dat_plan_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
             , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN 0
        WHEN INV0.inventurart_int_id = 3
        THEN 1
        WHEN INV0.inventurart_int_id IN (1, 2) AND INV0.dat_plan_zaehlung BETWEEN MIN(CASE
            WHEN INV0.inventurart_int_id IN (3)
            THEN INV0.dat_vorletzte_zaehlung
            ELSE NULL
            END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
             , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AND (MAX(CASE
             WHEN INV0.inventurart_int_id IN (3)
             THEN INV0.dat_plan_zaehlung
             ELSE NULL
             END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
              , CAST(INV0.wg_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
        THEN 0
        ELSE 1
        END AS BIGNUMERIC) AS inv_inv
     FROM kfl_production_dbp_view.v_hfm_inventur_termin_wg_wup_zu_per AS INV0
      INNER JOIN kfl_production_dbp_view.v_mandant AS MAN0 ON INV0.mandant_id = MAN0.mandant_id AND MAN0.default_wrg <>
        'EUR'
      INNER JOIN kfl_production_dbp_view.v_kurs AS KURS0 ON INV0.wrg_id = KURS0.von_wrg_id AND KURS0.kurstyp_id = 3 AND
        KURS0.dat_bis = DATE '9999-12-31') AS inv
   INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT ON inv.dat_plan_zaehlung = ZEIT.dat
   LEFT JOIN (SELECT VIS0.mandant_id,
     VIS0.nb_id,
     VIS0.wup_id,
     WG0.abt_id,
     VIS0.wg_id,
     VIS0.wrg_id,
     VIS0.dat,
     VIS0.ums_netto,
     SUM(VIS0.ums_netto) OVER (PARTITION BY CAST(VIS0.mandant_id AS STRING), CAST(VIS0.wup_id AS STRING), CAST(WG0.abt_id AS STRING)
        , VIS0.wrg_id, VIS0.dat ORDER BY VIS0.mandant_id IS NULL, VIS0.mandant_id, VIS0.wup_id IS NULL, VIS0.wup_id, WG0
        .abt_id IS NULL, WG0.abt_id, VIS0.wg_id IS NULL, VIS0.wg_id, VIS0.wrg_id IS NULL, VIS0.wrg_id, VIS0.dat IS NULL
        , VIS0.dat RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS ums_netto_abt
    FROM kfl_production_dbp_msi_v_view.v_vis_tag_umsatz_wg AS VIS0
     INNER JOIN kfl_production_dbp_view.v_tag AS ZEIT0 ON VIS0.dat = ZEIT0.dat AND ZEIT0.akt_gj BETWEEN - 1 AND 0
     INNER JOIN kfl_production_dbp_view.v_wg_per AS WG0 ON VIS0.wg_id = WG0.wg_id AND VIS0.mandant_id = WG0.mandant_id
       AND WG0.arthiertyp_id = 2 AND WG0.dat_bis = DATE '9999-12-31') AS vis ON inv.mandant_id = vis.mandant_id AND inv
        .wup_id = vis.wup_id AND inv.wg_id = vis.wg_id AND inv.wrg_id = vis.wrg_id AND vis.dat BETWEEN inv.dat_vorletzte_zaehlung
     AND inv.dat_plan_zaehlung
  GROUP BY inv.mandant_id,
   inv.nb_id,
   inv.wup_id,
   inv.wg_id,
   inv.inventurart_int_id,
   inv.dat_plan_zaehlung,
   inv.dat_vorletzte_zaehlung,
   zeitraum,
   ZEIT.gj,
   inv.wrg_id,
   wert_netto_inventur,
   ums_netto_inventur,
   inv.inv_inv) AS hfm
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_wg_hwg_zu AS HWG ON hfm.mandant_id = HWG.mandant_id AND hfm.wg_id = HWG.wg_id
   
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_hwg_abt_zu AS ABT ON HWG.mandant_id = ABT.mandant_id AND HWG.hwg_id = ABT
   .hwg_id;