CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_buch_grund_ext_1 (buch_grund_ext_id, mandant_id, system_id) AS
SELECT buch_grund_ext_id,
 mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_buch_grund_ext_1
WHERE mandant_id = 1
UNION DISTINCT
SELECT '0',
 1,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_buch_grund_ext_1;