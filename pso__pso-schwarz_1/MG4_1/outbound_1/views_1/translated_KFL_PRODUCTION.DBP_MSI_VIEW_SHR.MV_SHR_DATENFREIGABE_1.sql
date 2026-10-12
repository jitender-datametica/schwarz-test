CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_shr.mv_shr_datenfreigabe_1 (mandant_id, kjmo, dat, user_id,
shr_freigabe_fg) AS SELECT mandant_id,
 kjmo,
 MAX(dat) AS dat,
 MAX(user_id) AS user_id,
 shr_freigabe_fg
FROM kfl_production_dbp_msi_v_view.v_shr_datenfreigabe_1 AS v01
WHERE shr_freigabe_fg = 1
GROUP BY mandant_id,
 kjmo,
 shr_freigabe_fg;