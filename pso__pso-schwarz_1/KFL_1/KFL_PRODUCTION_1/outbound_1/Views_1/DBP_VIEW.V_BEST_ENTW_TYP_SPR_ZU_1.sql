CREATE OR REPLACE VIEW kfl_production_dbp_view.v_best_entw_typ_spr_zu_1 AS SELECT mandant_id,
 best_entw_typ_id,
 spr_id,
 best_entw_typ_kbez,
 best_entw_typ_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.best_entw_typ_spr_zu_1;