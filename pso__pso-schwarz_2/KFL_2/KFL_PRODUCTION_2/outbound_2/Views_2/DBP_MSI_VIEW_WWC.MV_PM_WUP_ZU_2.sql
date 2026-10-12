CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_pm_wup_zu_2 AS SELECT W.wup_id,
 W.mandant_id,
 W.nb_id,
 w_pm.pm_fl_id,
 w_pm.pm_og_id,
 w_pm.pm_food_id,
 w_pm.pm_nonfood_id,
 w_pm.pm_wurst_bed_id,
 w_pm.pm_sb_wurst_id,
 w_pm.pm_kaese_bed_id
FROM kfl_production_dbp_view.v_wup_2 AS W
 LEFT JOIN (SELECT wup_id,
   mandant_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_fl_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_og_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_food_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_nonfood_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_wurst_bed_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_sb_wurst_id,
   MAX(CASE
     WHEN wg_id IN (2)
     THEN pm_id
     ELSE NULL
     END) AS pm_kaese_bed_id
  FROM kfl_production_dbp_view.v_pm_wup_wg_zu_per_2
  WHERE dat_bis = DATE '9999-12-31'
   AND arthiertyp_id = 2
  GROUP BY wup_id,
   mandant_id) AS w_pm ON W.mandant_id = w_pm.mandant_id AND W.wup_id = w_pm.wup_id
WHERE W.nb_id IN (- 2, - 1, 0, 2, 6, 7) AND W.dat_eroeffnung > PARSE_DATE('%F', '1900-01-01')
 OR W.nb_id IN (- 111, 99);