CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_buch_grund_int_gruppe_zu (system_id, mandant_id,
buch_grund_int_id, buch_grund_int_gruppe_id) AS SELECT 7 AS system_id,
 mandant_id,
 buch_grund_int_id,
 buch_grund_int_gruppe_id
FROM kfl_production_dbp_view.v_buch_grund_int_gruppe_zu
WHERE mandant_id = 1;