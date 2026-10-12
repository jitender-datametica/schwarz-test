CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_ekorg_spr_zu_2 AS SELECT einkaufsorganisation_id,
 spr_id,
 mandant_id,
 einkaufsorganisation_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_ekorg_spr_zu_2;