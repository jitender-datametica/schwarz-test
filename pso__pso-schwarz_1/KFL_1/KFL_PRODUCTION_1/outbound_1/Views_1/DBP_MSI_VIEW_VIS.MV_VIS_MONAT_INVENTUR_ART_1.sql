CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_monat_inventur_art_1 (mandant_id, nb_id, wup_id, gj, kjmo,
inventurart_int_id, inventurart_vis_id, art_id, wg_id, owg_id, hwg_id, abt_id, dat_plan_zaehlung, dat_vorletzte_zaehlung
, zeitraum, wrg_id, inv_wert_netto, inv_ums_netto, inv_jahr_fg, inv_zwischen_fg) AS SELECT sub01.mandant_id,
 sub01.nb_id,
 sub01.wup_id,
 sub01.gj,
 sub01.kjmo,
 sub01.inventurart_int_id,
 IAV.inventurart_vis_id,
 sub01.art_id,
 WG.wg_id,
 OWG.owg_id,
 HWG.hwg_id,
 ABT.abt_id,
 sub01.dat_plan_zaehlung,
 sub01.dat_vorletzte_zaehlung,
 sub01.zeitraum,
 sub01.wrg_id,
 sub01.inv_wert_netto,
 sub01.inv_ums_netto,
 sub01.inv_jahr_fg,
 sub01.inv_zwischen_fg
FROM (SELECT inv.mandant_id,
   inv.nb_id,
   inv.wup_id,
   inv.art_id,
   inv.inventurart_int_id,
   inv.dat_plan_zaehlung,
   inv.dat_vorletzte_zaehlung,
   CAST(DATE_DIFF(inv.dat_plan_zaehlung, inv.dat_vorletzte_zaehlung, DAY) AS BIGNUMERIC) AS zeitraum,
   ZEIT.gj,
   ZEIT.kjmo,
   inv.wrg_id,
   inv.inv_jahr_fg,
   inv.inv_zwischen_fg,
   SUM(inv.inventur_wert_vk_netto) AS inv_wert_netto,
   SUM(inv.umsatz_vk_netto_sum) AS inv_ums_netto
  FROM (SELECT INV0.mandant_id,
     INV0.nb_id,
     INV0.wup_id,
     INV0.art_id,
     INV0.inventurart_int_vorletzte_zaehlung AS inventurart_int_id,
     INV0.dat_plan_zaehlung,
     INV0.dat_vorletzte_zaehlung,
     krs.nach_wrg_id AS wrg_id,
      INV0.inventur_wert_vk_netto * krs.umrechnungskurs AS inventur_wert_vk_netto,
      INV0.umsatz_vk_netto_sum * krs.umrechnungskurs AS umsatz_vk_netto_sum,
     MAX(CASE
       WHEN INV0.inventurart_int_vorletzte_zaehlung IN (5)
       THEN INV0.dat_plan_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS inv_j_akt,
     MAX(CASE
       WHEN INV0.inventurart_int_vorletzte_zaehlung IN (5)
       THEN INV0.dat_vorletzte_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS inv_j_vor,
     CAST(CASE
       WHEN INV0.dat_plan_zaehlung < (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (5)
           THEN INV0.dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN - 3
       WHEN INV0.dat_plan_zaehlung = (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (5)
           THEN INV0.dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN - 1
       WHEN INV0.dat_plan_zaehlung < (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (5)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN - 2
       WHEN INV0.dat_plan_zaehlung = (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (5)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN 0
       ELSE 1
       END AS BIGNUMERIC) AS inv_jahr_fg,
     MAX(CASE
       WHEN INV0.inventurart_int_vorletzte_zaehlung IN (4)
       THEN INV0.dat_plan_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS inv_z_akt,
     MAX(CASE
       WHEN INV0.inventurart_int_vorletzte_zaehlung IN (4)
       THEN INV0.dat_vorletzte_zaehlung
       ELSE NULL
       END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
        , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS inv_z_vor,
     CAST(CASE
       WHEN INV0.dat_plan_zaehlung < (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (4)
           THEN INV0.dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN - 3
       WHEN INV0.dat_plan_zaehlung = (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (4)
           THEN INV0.dat_vorletzte_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN - 1
       WHEN INV0.dat_plan_zaehlung < (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (4)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN - 2
       WHEN INV0.dat_plan_zaehlung = (MAX(CASE
           WHEN INV0.inventurart_int_vorletzte_zaehlung IN (4)
           THEN INV0.dat_plan_zaehlung
           ELSE NULL
           END) OVER (PARTITION BY CAST(INV0.mandant_id AS STRING), CAST(INV0.nb_id AS STRING), CAST(INV0.wup_id AS STRING)
            , CAST(INV0.art_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
       THEN 0
       ELSE 1
       END AS BIGNUMERIC) AS inv_zwischen_fg
    FROM kfl_production_dbp_view.v_inventur_termin_art_wup_zu_per_1 AS INV0
     INNER JOIN (SELECT von_wrg_id,
        nach_wrg_id,
        umrechnungskurs
       FROM kfl_production_dbp_data.kurs_1 AS KRS1
       WHERE kurstyp_id = 3
        AND dat_bis = DATE '9999-12-31'
        AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
       UNION ALL
       SELECT von_wrg_id,
        von_wrg_id AS von_wrg_id0,
        1.0000
       FROM kfl_production_dbp_data.kurs_1 AS KRS2
       WHERE kurstyp_id = 3
        AND dat_bis = DATE '9999-12-31'
        AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON INV0.wrg_id = krs.von_wrg_id) AS inv
   INNER JOIN kfl_production_dbp_view.v_tag_1 AS ZEIT_1 ON inv.dat_plan_zaehlung = ZEIT.dat
  GROUP BY inv.mandant_id,
   inv.nb_id,
   inv.wup_id,
   inv.art_id,
   inv.inventurart_int_id,
   inv.dat_plan_zaehlung,
   inv.dat_vorletzte_zaehlung,
   inv.wrg_id,
   inv.inv_jahr_fg,
   inv.inv_zwischen_fg,
   ZEIT.kjmo,
   ZEIT.gj) AS sub01
 INNER JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS ART_1 ON sub01.art_id = ART.art_id AND sub01.mandant_id = ART.mandant_id
      AND ART.arthiertyp_id = 2 AND ART.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_wg_per_1 AS WG ON ART.wg_id = WG.wg_id AND ART.mandant_id = WG.mandant_id AND WG.arthiertyp_id
     = 2 AND WG.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_owg_per_1 AS OWG ON WG.owg_id = OWG.owg_id AND WG.mandant_id = OWG.mandant_id AND
    OWG.arthiertyp_id = 2 AND OWG.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_hwg_per_1 AS HWG ON OWG.hwg_id = HWG.hwg_id AND OWG.mandant_id = HWG.mandant_id AND
    HWG.arthiertyp_id = 2 AND HWG.dat_bis = DATE '9999-12-31'
 INNER JOIN kfl_production_dbp_view.v_abt_per_1 AS ABT_1 ON HWG.abt_id = ABT.abt_id AND HWG.mandant_id = ABT.mandant_id AND
    ABT.arthiertyp_id = 2 AND ABT.dat_bis = DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_msi_view_vis.mv_inventurart_int_vis_zu_1 AS IAV ON ABT.abt_id = IAV.abt_id AND sub01.inventurart_int_id
    = IAV.inventurart_int_id;