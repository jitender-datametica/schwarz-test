CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_best_entw_typ_1 (mandant_id, best_entw_typ_id, nachbelastung_fg,
preis_pruefen_fg, td_update, td_insert) AS SELECT mandant_id,
 best_entw_typ_id,
 nachbelastung_fg,
 preis_pruefen_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_best_entw_typ_1;