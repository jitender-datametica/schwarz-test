CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_l_best_entw_typ_2 (mandant_id, best_entw_typ_id,
nachbelastung_fg, preis_pruefen_fg) AS SELECT mandant_id,
 best_entw_typ_id,
 nachbelastung_fg,
 preis_pruefen_fg
FROM kfl_production_dbp_view.v_l_best_entw_typ_2
WHERE mandant_id = 1;