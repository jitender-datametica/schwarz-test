CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_best_entw_typ_spr_zu_pl_1 (mandant_id, bewtp, spr_id, bewtp_kbez
, bewtp_bez) AS SELECT mandant_id,
 best_entw_typ_id AS bewtp,
 spr_id,
 best_entw_typ_kbez AS bewtp_kbez,
 best_entw_typ_bez AS bewtp_bez
FROM kfl_production_dbp_view.v_best_entw_typ_spr_zu_1 AS V01
WHERE spr_id = 90;