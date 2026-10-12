-- 2024-03-20, dknop, copy from VIS
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_werbe_woche
(mandant_id, werbe_typ_id, kjwo, werbewoche, werbemonat, abw_zeitr_fg, anz_dat_von, anz_dat_bis, suffix, dat_von,
dat_bis, ww_von_bis) AS -- kjwo = führend
 -- folgewoche (wichtig beim jahreswechsel)
 -- alle werbetpyen
 SELECT WT.mandant_id
 ,
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
 = DV.wtag_id
   
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
 abw_zeitr_fg;