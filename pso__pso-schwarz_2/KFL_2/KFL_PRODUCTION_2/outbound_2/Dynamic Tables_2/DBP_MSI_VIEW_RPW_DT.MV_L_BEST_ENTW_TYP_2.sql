CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_best_entw_typ_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 best_entw_typ_id,
 nachbelastung_fg,
 preis_pruefen_fg
FROM kfl_production_dbp_view.v_l_best_entw_typ_2
WHERE mandant_id = 1;