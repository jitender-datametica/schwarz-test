CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_l_sb_aggregat_grund AS SELECT mandant_id,
 sb_grund_id
FROM kfl_production_dbp_view.v_l_sb_grund AS V01
UNION ALL
SELECT mandant_id,
 - 1 AS sb_grund_id
FROM kfl_production_dbp_view.v_mandant AS V01
WHERE mandant_id <> 4;