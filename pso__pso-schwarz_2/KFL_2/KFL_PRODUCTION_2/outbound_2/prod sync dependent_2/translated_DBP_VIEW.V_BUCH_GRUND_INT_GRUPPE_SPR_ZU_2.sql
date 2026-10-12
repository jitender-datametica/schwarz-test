CREATE OR REPLACE VIEW kfl_production_dbp_view.v_buch_grund_int_gruppe_spr_zu_2 (system_id, mandant_id,
buch_grund_int_gruppe_id, spr_id, buch_grund_int_gruppe_bez) AS SELECT system_id,
 mandant_id,
 buch_grund_int_gruppe_id,
 spr_id,
 buch_grund_int_gruppe_bez
FROM kfl_production_dbp_data.buch_grund_int_gruppe_spr_zu_2;