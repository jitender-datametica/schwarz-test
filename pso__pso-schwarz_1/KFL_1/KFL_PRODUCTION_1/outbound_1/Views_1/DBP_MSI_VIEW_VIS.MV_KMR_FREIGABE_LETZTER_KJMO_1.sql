CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_kmr_freigabe_letzter_kjmo_1 (kjmo, mandant_id) AS SELECT MAX(kjmo
  ) AS kjmo,
 mandant_id
FROM kfl_production_dbp_view.v_ts_kmr_freigabe_kjmo_1 AS V01
WHERE freigabe_fg = 1
GROUP BY mandant_id
UNION ALL
SELECT MAX(kjmo) AS kjmo,
 99 AS mandant_id
FROM kfl_production_dbp_view.v_ts_kmr_freigabe_kjmo_1 AS V01
WHERE freigabe_fg = 1
GROUP BY freigabe_fg;