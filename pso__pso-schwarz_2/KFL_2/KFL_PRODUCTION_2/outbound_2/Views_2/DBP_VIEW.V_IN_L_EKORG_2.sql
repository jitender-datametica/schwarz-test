CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_l_ekorg_2 AS SELECT einkaufsorganisation_id,
 mandant_id,
 buchungskreis_id,
 sako_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_l_ekorg_2;