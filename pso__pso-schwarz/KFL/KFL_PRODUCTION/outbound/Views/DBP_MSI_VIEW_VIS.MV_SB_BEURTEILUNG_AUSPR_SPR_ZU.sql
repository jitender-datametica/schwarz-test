CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_beurteilung_auspr_spr_zu AS SELECT CASE
  WHEN akt_tag = 1
  THEN 'Storecheck'
  WHEN akt_tag = 2
  THEN 'Früh'
  WHEN akt_tag = 3
  THEN 'Spät'
  ELSE ''
  END AS frueh_fg,
  CASE
  WHEN akt_tag = 1
  THEN 'Storecheck'
  WHEN akt_tag = 2
  THEN 'Früh'
  WHEN akt_tag = 3
  THEN 'Spät'
  ELSE ''
  END AS frueh_bez
FROM kfl_production_dbp_view.v_tag
WHERE akt_tag BETWEEN 0 AND 3;