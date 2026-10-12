CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_best_entw_typ_spr_zu_2 (mandant_id, best_entw_typ_id,
best_entw_typ_kbez, best_entw_typ_bez) AS SELECT mandant_id,
 best_entw_typ_id,
 best_entw_typ_kbez,
 best_entw_typ_bez
FROM kfl_production_dbp_view.v_best_entw_typ_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;