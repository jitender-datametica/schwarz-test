CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_best_entw_typ_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 best_entw_typ_id,
 best_entw_typ_kbez,
 best_entw_typ_bez
FROM kfl_production_dbp_view.v_best_entw_typ_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;