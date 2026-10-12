CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_buch_grund_ext_gruppe (system_id, mandant_id,
buch_grund_ext_gruppe_id) AS SELECT 7 AS system_id,
 mandant_id,
 buch_grund_ext_gruppe_id
FROM kfl_production_dbp_view.v_l_buch_grund_ext_gruppe
WHERE mandant_id = 1;