CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_buch_grund_ext_gruppe_2 (system_id, mandant_id,
buch_grund_ext_gruppe_id) AS SELECT system_id,
 mandant_id,
 buch_grund_ext_gruppe_id
FROM kfl_production_dbp_data.l_buch_grund_ext_gruppe_2;