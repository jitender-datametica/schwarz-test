CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_buch_grund_int_gruppe (system_id, mandant_id,
buch_grund_int_gruppe_id) AS SELECT system_id,
 mandant_id,
 buch_grund_int_gruppe_id
FROM kfl_production_dbp_data.l_buch_grund_int_gruppe;