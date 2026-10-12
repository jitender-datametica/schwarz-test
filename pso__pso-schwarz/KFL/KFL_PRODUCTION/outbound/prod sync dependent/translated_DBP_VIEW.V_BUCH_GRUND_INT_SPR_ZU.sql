CREATE OR REPLACE VIEW kfl_production_dbp_view.v_buch_grund_int_spr_zu (system_id, mandant_id, buch_grund_int_id, spr_id
, buch_grund_int_bez, td_update, td_insert) AS SELECT system_id,
 mandant_id,
 buch_grund_int_id,
 spr_id,
 buch_grund_int_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.buch_grund_int_spr_zu;