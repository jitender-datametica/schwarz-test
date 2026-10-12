CREATE OR REPLACE VIEW kfl_production_dbp_view.v_buch_grund_int_gruppe_zu AS SELECT system_id,
 mandant_id,
 buch_grund_int_gruppe_id,
 buch_grund_int_id
FROM kfl_production_dbp_data.buch_grund_int_gruppe_zu;