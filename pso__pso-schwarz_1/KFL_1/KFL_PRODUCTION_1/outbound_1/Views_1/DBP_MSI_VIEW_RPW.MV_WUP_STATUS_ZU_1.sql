CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_wup_status_zu_1 (open_fg, open_bez) AS SELECT open_fg,
  CASE
  WHEN open_fg = 1
  THEN 'Offen'
  WHEN open_fg = 2
  THEN 'Geloescht'
  WHEN open_fg = 3
  THEN 'Geplant'
  ELSE NULL
  END AS open_bez
FROM kfl_production_dbp_msi_view_rpw.mv_wup_1
WHERE nb_id = 0
 AND open_fg <> 0
GROUP BY open_fg;