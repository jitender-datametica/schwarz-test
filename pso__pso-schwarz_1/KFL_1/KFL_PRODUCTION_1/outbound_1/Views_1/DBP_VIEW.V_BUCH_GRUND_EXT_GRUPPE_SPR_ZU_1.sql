CREATE OR REPLACE VIEW kfl_production_dbp_view.v_buch_grund_ext_gruppe_spr_zu_1 AS SELECT system_id,
 mandant_id,
 buch_grund_ext_gruppe_id,
 spr_id,
 buch_grund_ext_gruppe_bez
FROM kfl_production_dbp_data.buch_grund_ext_gruppe_spr_zu_1;