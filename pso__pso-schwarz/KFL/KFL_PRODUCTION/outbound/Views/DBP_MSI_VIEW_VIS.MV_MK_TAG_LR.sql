CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mk_tag_lr AS SELECT dat,
   ((ROW_NUMBER() OVER (ORDER BY dat IS NULL, dat)) - 1) * - 1 AS akt_tag_lr
FROM kfl_production_dbp_view.v_mk_zeroverkauf AS T01
GROUP BY dat;