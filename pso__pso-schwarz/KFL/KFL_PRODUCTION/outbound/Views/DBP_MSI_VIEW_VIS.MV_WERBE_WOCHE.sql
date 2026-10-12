CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_werbe_woche AS WITH T00 AS (SELECT WT.mandant_id,
   WT.werbe_typ_id,
   W.kjwo,
   COALESCE(WWO.werbewoche, DV.kjwo) AS werbewoche,
   COALESCE(WWO.kjmo, DV.kjmo) AS werbemonat,
    CASE
    WHEN abw.mandant_id IS NOT NULL
    THEN 1
    ELSE 0
    END AS abw_zeitr_fg,
   COUNT(DISTINCT COALESCE(abw.dat_von, DV.dat)) AS anz_dat_von,
   COUNT(DISTINCT COALESCE(abw.dat_bis, DB.dat)) AS anz_dat_bis,
    CASE
    WHEN COUNT(DISTINCT COALESCE(abw.dat_von, DV.dat)) + COUNT(DISTINCT COALESCE(abw.dat_bis, DB.dat)) > 2
    THEN ' [!]'
    ELSE ''
    END AS suffix,
   MIN(COALESCE(abw.dat_von, DV.dat)) AS dat_von,
   MAX(COALESCE(abw.dat_bis, DB.dat)) AS dat_bis,
      FORMAT_DATE('%d.%m.%Y', MIN(COALESCE(abw.dat_von, DV.dat))) || ' - ' || FORMAT_DATE('%d.%m.%Y', MAX(COALESCE(abw.dat_bis
        , DB.dat))) || CASE
     WHEN COUNT(DISTINCT COALESCE(abw.dat_von, DV.dat)) + COUNT(DISTINCT COALESCE(abw.dat_bis, DB.dat)) > 2
     THEN ' [!]'
     ELSE ''
     END AS ww_von_bis
  FROM kfl_production_dbp_view.v_woche AS W
   INNER JOIN kfl_production_dbp_view.v_woche AS FW ON DATE_ADD(W.wo_dat_bis, INTERVAL 1 DAY) = FW.wo_dat_von
   INNER JOIN kfl_production_dbp_view.v_l_werbe_typ AS WT ON TRUE
   INNER JOIN kfl_production_dbp_view.v_tag AS DV ON W.kjwo = DV.kjwo AND WT.wtag_id_start -- startdatum in der kw
 = DV
     .wtag_id
   INNER JOIN kfl_production_dbp_view.v_tag AS DB ON CASE
      WHEN WT.wtag_id_start > WT.wtag_id_ende OR WT.werbe_typ_id = 15
      THEN FW.kjwo
      ELSE W.kjwo
      END = DB.kjwo AND WT.wtag_id_ende -- enddatum ggfs. mit wochenuebergang
 = DB.wtag_id
   LEFT JOIN (SELECT T0.mandant_id,
     T0.werbe_typ_id,
     T1.kjwo,
     T0.dat_bis,
     T0.dat_von
    FROM kfl_production_dbp_view.v_ts_avq_werbezeitraum_abw AS T0
     INNER JOIN kfl_production_dbp_view.v_tag AS T1 ON T0.dat_von = T1.dat) AS abw ON WT.mandant_id = abw.mandant_id AND
      WT.werbe_typ_id = abw.werbe_typ_id AND W.kjwo = abw.kjwo
   LEFT JOIN kfl_production_dbp_view.v_werbe_typ_woche_zu AS WWO ON WT.mandant_id = WWO.mandant_id AND WT.werbe_typ_id =
      WWO.werbe_typ_id AND W.kjwo = WWO.kjwo
  WHERE W.kjwo BETWEEN ROUND(CAST(CAST(EXTRACT(YEAR FROM CURRENT_DATE) - 2 AS STRING) || '01' AS BIGNUMERIC), 0) AND (SELECT
      kjwo
     FROM kfl_production_dbp_view.v_tag
     WHERE dat = CURRENT_DATE)
  GROUP BY WT.mandant_id,
   WT.werbe_typ_id,
   W.kjwo,
   werbewoche,
   werbemonat,
   abw_zeitr_fg
  HAVING dat_von < CURRENT_DATE) (-- 2020-11-17 | nwag2310 | added werbewoche / -monat / abw_zeitr_fg

  -- 2021-01-20 | nwag2310 | werbetyp only once per week
 -- 2022-01-18 | nwag2310 | adjustments for SF

  -- 2025-03-24 | nwag | add AKT_WMO
 -- 2025-04-28 | nwag | change AKT_WMO (not depending on Mandant any more)

  -- kjwo = führend
 -- folgewoche (wichtig beim jahreswechsel)
 -- alle werbetpyen
 SELECT t000.mandant_id,
   t000.werbe_typ_id,
   t000.kjwo,
   t000.werbewoche,
   t000.werbemonat,
   t000.abw_zeitr_fg,
   t000.anz_dat_von,
   t000.anz_dat_bis,
   t000.suffix,
   t000.dat_von,
   t000.dat_bis,
   t000.ww_von_bis,
   t001.akt_wmo
  FROM T00 AS t000
   INNER JOIN (SELECT werbemonat,
        (ROW_NUMBER() OVER (ORDER BY werbemonat IS NULL DESC, werbemonat DESC)) * - 1 + 1 AS akt_wmo
    FROM T00
    WHERE dat_von < CURRENT_DATE
    GROUP BY werbemonat) AS t001 ON t000.werbemonat = t001.werbemonat);