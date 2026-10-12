CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_zeitentwicklung_tag_zu_2 (dat, zeit_id) AS SELECT dat,
 kjmo AS zeit_id
FROM kfl_production_dbp_view.v_tag_2
UNION ALL
SELECT dat,
 gj AS zeit_id
FROM kfl_production_dbp_view.v_tag_2
UNION ALL
SELECT dat,
  kjwo * 10 AS zeit_id
FROM kfl_production_dbp_view.v_tag_2;