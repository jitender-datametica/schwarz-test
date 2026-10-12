CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_zaehl_auftrag_2 AS SELECT art_id,
 mandant_id,
 wup_id,
 nb_id,
 dat_auftrag,
 zaehl_grund_id,
 bezugsweg_id,
 zaehl_sort_id,
 dat_zaehl,
 zeit_zaehl,
 gesendet_fg,
 td_insert,
 td_update
FROM kfl_production_dbp_data.vis_zaehl_auftrag_2;