CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_pm_wup_zu_2 AS SELECT w.mandant_id,
 w.wup_id,
 wpm.pm_fl_id,
 wpm.pm_og_id,
 wpm.pm_food_id,
 wpm.pm_nonfood_id,
 wpm.pm_wurst_bed_id,
 wpm.pm_sb_wurst_id,
 wpm.pm_kaese_bed_id
FROM (SELECT mandant_id,
   land_id,
   nb_id,
   wup_id,
   vw_id
  FROM kfl_production_dbp_view.v_wup_2
  WHERE nb_id = 0
   AND dat_von > DATE '1900-01-01'
   AND dat_eroeffnung > DATE '1900-01-01'
   AND umzugsfiliale_fg = 0) AS w
 LEFT JOIN (SELECT wup_id,
   mandant_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_fl_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_og_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_food_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_nonfood_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_wurst_bed_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_sb_wurst_id,
   MAX(CASE
     WHEN wg_id IN (128)
     THEN pm_id
     ELSE NULL
     END) AS pm_kaese_bed_id
  FROM kfl_production_dbp_view.v_pm_wup_wg_zu_per_2
  WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
   AND arthiertyp_id = 2
  GROUP BY wup_id,
   mandant_id) AS wpm ON w.mandant_id = wpm.mandant_id AND w.wup_id = wpm.wup_id;