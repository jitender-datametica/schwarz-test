CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_row_grund_spr_zu_1 (mandant_id, row_grund_id, spr_id,
row_grund_bez, system_id) AS SELECT mandant_id,
 row_grund_id,
 spr_id,
 row_grund_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_row_grund_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22
GROUP BY mandant_id,
 spr_id,
 row_grund_id,
 row_grund_bez
UNION ALL
SELECT 1 AS mandant_id,
 '0' AS row_grund_id,
 22 AS spr_id,
 'Sachkontenbuchung ohne ROW' AS row_grund_bez,
 7 AS system_id;